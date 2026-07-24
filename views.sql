USE GymDB;
GO


-- ==========================================================
-- VISTA 1: Vista_RutinasEntrenadores
-- Relaciona las tablas Rutinas y Entrenadores
-- Muestra las rutinas junto con su entrenador
-- ==========================================================

CREATE OR ALTER VIEW dbo.Vista_RutinasEntrenadores
AS
    SELECT
        R.RutinaId,
        R.Nombre AS NombreRutina,
        R.Objetivo,
        R.NivelDificultad,
        R.DuracionEstimadaMinutos,
        E.EntrenadorId,
        E.Nombre AS NombreEntrenador,
        E.Apellido AS ApellidoEntrenador,
        E.Especialidad
    FROM dbo.Rutinas R
        LEFT JOIN dbo.Entrenadores E
        ON R.EntrenadorId = E.EntrenadorId;
GO


-- ==========================================================
-- VISTA 2: Vista_MiembrosOrdenados
-- Muestra los miembros ordenados por nombre y apellido
-- Utiliza ORDER BY dentro de la vista
-- En SQL Server una vista no puede garantizar el orden por sí sola
-- ==========================================================

CREATE OR ALTER VIEW dbo.Vista_MiembrosOrdenados
AS
    SELECT TOP 100 PERCENT
        MiembroId,
        Cedula,
        Nombre,
        Apellido,
        Telefono,
        Correo,
        FechaRegistro,
        Estado
    FROM dbo.Miembros
    ORDER BY Nombre, Apellido;
GO


-- ==========================================================
-- VISTA 3: Vista_MiembrosYEntrenadores
-- Une miembros y entrenadores en una sola lista
-- Utiliza dos SELECT y el operador UNION
-- ==========================================================

CREATE OR ALTER VIEW dbo.Vista_MiembrosYEntrenadores
AS
            SELECT
            Nombre,
            Apellido,
            Telefono,
            Correo,
            Estado,
            'Miembro' AS TipoPersona
        FROM dbo.Miembros

    UNION

        SELECT
            Nombre,
            Apellido,
            Telefono,
            Correo,
            Estado,
            'Entrenador' AS TipoPersona
        FROM dbo.Entrenadores;
GO


-- ==========================================================
-- CONSULTAS PARA PROBAR LAS VISTAS
-- ==========================================================

SELECT *
FROM dbo.Vista_RutinasEntrenadores;
GO

SELECT *
FROM dbo.Vista_MiembrosOrdenados
ORDER BY Nombre, Apellido;
GO

SELECT *
FROM dbo.Vista_MiembrosYEntrenadores;
GO
