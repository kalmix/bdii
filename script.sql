-- =====================================================
-- BASE DE DATOS
-- Crea la base de datos solamente si no existe
-- =====================================================

IF DB_ID('GymDB') IS NULL
BEGIN
    CREATE DATABASE GymDB;
END;
GO

USE GymDB;
GO


-- =====================================================
-- 1. MIEMBROS
-- Almacena los datos generales de los miembros
-- Cedula es una clave única diferente de la clave primaria
-- =====================================================

CREATE TABLE Miembros
(
    MiembroId INT IDENTITY(1,1) PRIMARY KEY,
    Cedula VARCHAR(13) NOT NULL UNIQUE,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Telefono VARCHAR(20) NULL,
    Correo VARCHAR(100) NULL,
    FechaRegistro DATE NOT NULL DEFAULT GETDATE(),
    Estado BIT NOT NULL DEFAULT 1
);
GO


-- =====================================================
-- 2. PERFILES MÉDICOS
-- Relación uno a uno entre Miembros y PerfilesMedicos
-- Un miembro puede tener como máximo un perfil médico
-- MiembroId es clave primaria y clave foránea
-- =====================================================

CREATE TABLE PerfilesMedicos
(
    MiembroId INT PRIMARY KEY,
    TipoSangre VARCHAR(5) NULL,
    AptoEntrenamiento BIT NOT NULL DEFAULT 1,
    ObservacionesMedicas VARCHAR(255) NULL,
    ContactoEmergencia VARCHAR(100) NULL,
    TelefonoEmergencia VARCHAR(20) NULL,
    Estado BIT NOT NULL DEFAULT 1,

    CONSTRAINT FK_PerfilesMedicos_Miembros
        FOREIGN KEY (MiembroId)
        REFERENCES Miembros(MiembroId)
);
GO


-- =====================================================
-- 3. ENTRENADORES
-- Almacena los entrenadores del gimnasio
-- Cedula y Correo son claves únicas
-- =====================================================

CREATE TABLE Entrenadores
(
    EntrenadorId INT IDENTITY(1,1) PRIMARY KEY,
    Cedula VARCHAR(13) NOT NULL UNIQUE,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Correo VARCHAR(100) NOT NULL UNIQUE,
    Telefono VARCHAR(20) NULL,
    Especialidad VARCHAR(100) NULL,
    Estado BIT NOT NULL DEFAULT 1
);
GO


-- =====================================================
-- 4. RUTINAS
-- Relación uno a muchos entre Entrenadores y Rutinas
-- Un entrenador puede crear varias rutinas
-- Una rutina puede existir sin un entrenador asignado
-- =====================================================

CREATE TABLE Rutinas
(
    RutinaId INT IDENTITY(1,1) PRIMARY KEY,
    EntrenadorId INT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Objetivo VARCHAR(150) NULL,
    NivelDificultad VARCHAR(30) NULL,
    DuracionEstimadaMinutos INT NULL,
    Descripcion VARCHAR(255) NULL,
    FechaCreacion DATE NOT NULL DEFAULT GETDATE(),
    Estado BIT NOT NULL DEFAULT 1,

    CONSTRAINT FK_Rutinas_Entrenadores
        FOREIGN KEY (EntrenadorId)
        REFERENCES Entrenadores(EntrenadorId)
);
GO


-- =====================================================
-- 5. EJERCICIOS
-- Almacena los ejercicios disponibles en el gimnasio
-- CodigoEjercicio es una clave única
-- =====================================================

CREATE TABLE Ejercicios
(
    EjercicioId INT IDENTITY(1,1) PRIMARY KEY,
    CodigoEjercicio VARCHAR(20) NOT NULL UNIQUE,
    Nombre VARCHAR(100) NOT NULL,
    GrupoMuscular VARCHAR(100) NULL,
    TipoEjercicio VARCHAR(50) NULL,
    Descripcion VARCHAR(255) NULL,
    Estado BIT NOT NULL DEFAULT 1
);
GO


-- =====================================================
-- 6. RUTINA EJERCICIO
-- Relación muchos a muchos entre Rutinas y Ejercicios
-- Una rutina puede contener varios ejercicios
-- Un ejercicio puede formar parte de varias rutinas
-- =====================================================

CREATE TABLE RutinaEjercicio
(
    RutinaEjercicioId INT IDENTITY(1,1) PRIMARY KEY,
    RutinaId INT NOT NULL,
    EjercicioId INT NOT NULL,
    DiaSemana VARCHAR(15) NULL,
    OrdenEjercicio INT NULL,
    Series INT NULL,
    Repeticiones INT NULL,
    DuracionEjercicioSegundos INT NULL,
    PesoSugerido DECIMAL(7,2) NULL,
    DescansoSegundos INT NULL,
    Indicaciones VARCHAR(255) NULL,
    Estado BIT NOT NULL DEFAULT 1,

    CONSTRAINT FK_RutinaEjercicio_Rutinas
        FOREIGN KEY (RutinaId)
        REFERENCES Rutinas(RutinaId),

    CONSTRAINT FK_RutinaEjercicio_Ejercicios
        FOREIGN KEY (EjercicioId)
        REFERENCES Ejercicios(EjercicioId)
);
GO


-- =====================================================
-- 7. ASIGNACIONES DE RUTINA
-- Relación muchos a muchos entre Miembros y Rutinas
-- Un miembro puede recibir varias rutinas
-- Una rutina puede asignarse a varios miembros
-- =====================================================

CREATE TABLE AsignacionesRutina
(
    AsignacionId INT IDENTITY(1,1) PRIMARY KEY,
    MiembroId INT NOT NULL,
    RutinaId INT NOT NULL,
    FechaInicio DATE NOT NULL DEFAULT GETDATE(),
    FechaFin DATE NULL,
    Observaciones VARCHAR(255) NULL,
    Estado BIT NOT NULL DEFAULT 1,

    CONSTRAINT FK_AsignacionesRutina_Miembros
        FOREIGN KEY (MiembroId)
        REFERENCES Miembros(MiembroId),

    CONSTRAINT FK_AsignacionesRutina_Rutinas
        FOREIGN KEY (RutinaId)
        REFERENCES Rutinas(RutinaId)
);
GO


-- =====================================================
-- 8. AUDITORÍA
-- Almacena los cambios realizados en las tablas auditadas
-- Guarda el valor anterior, valor actual, fecha y usuario
-- =====================================================

CREATE TABLE Auditoria
(
    AuditoriaId INT IDENTITY(1,1) PRIMARY KEY,
    NombreTabla VARCHAR(100) NOT NULL,
    RegistroId INT NOT NULL,
    NombreCampo VARCHAR(100) NOT NULL,
    ValorAnterior VARCHAR(500) NULL,
    ValorActual VARCHAR(500) NULL,
    FechaCambio DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    Usuario VARCHAR(128) NOT NULL
);
GO