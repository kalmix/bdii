-- =====================================================
-- USUARIOS Y PERMISOS DE GYMDB
-- Ejecutar con una cuenta que pertenezca a sysadmin
-- =====================================================


-- =====================================================
-- 1. ADMINISTRADOR DEL SERVIDOR
-- Tiene control total sobre la instancia de SQL Server
-- =====================================================

USE master;
GO

IF NOT EXISTS
(
    SELECT 1
FROM sys.server_principals
WHERE name = 'LoginAdminServidor'
)
BEGIN
    CREATE LOGIN LoginAdminServidor
    WITH PASSWORD = 'AdminServidor#2026',
         CHECK_POLICY = ON;
END;
GO

ALTER SERVER ROLE sysadmin
ADD MEMBER LoginAdminServidor;
GO


-- =====================================================
-- 2. ADMINISTRADOR DE LA BASE DE DATOS
-- Tiene control total únicamente dentro de GymDB
-- =====================================================

USE master;
GO

IF NOT EXISTS
(
    SELECT 1
FROM sys.server_principals
WHERE name = 'LoginAdminGymDB'
)
BEGIN
    CREATE LOGIN LoginAdminGymDB
    WITH PASSWORD = 'AdminGymDB#2026',
         CHECK_POLICY = ON;
END;
GO

USE GymDB;
GO

IF NOT EXISTS
(
    SELECT 1
FROM sys.database_principals
WHERE name = 'UsuarioAdminGymDB'
)
BEGIN
    CREATE USER UsuarioAdminGymDB
    FOR LOGIN LoginAdminGymDB;
END;
GO

ALTER ROLE db_owner
ADD MEMBER UsuarioAdminGymDB;
GO


-- =====================================================
-- 3. USUARIO DE SOLO LECTURA
-- Puede ejecutar SELECT en todas las tablas y vistas
-- No puede insertar, actualizar ni eliminar registros
-- =====================================================

USE master;
GO

IF NOT EXISTS
(
    SELECT 1
FROM sys.server_principals
WHERE name = 'LoginSoloLectura'
)
BEGIN
    CREATE LOGIN LoginSoloLectura
    WITH PASSWORD = 'SoloLectura#2026',
         CHECK_POLICY = ON;
END;
GO

USE GymDB;
GO

IF NOT EXISTS
(
    SELECT 1
FROM sys.database_principals
WHERE name = 'UsuarioSoloLectura'
)
BEGIN
    CREATE USER UsuarioSoloLectura
    FOR LOGIN LoginSoloLectura;
END;
GO

ALTER ROLE db_datareader
ADD MEMBER UsuarioSoloLectura;
GO


-- =====================================================
-- 4. USUARIO CON TODOS LOS PERMISOS EN UNA SOLA TABLA
-- Tiene control completo únicamente sobre Ejercicios
-- Puede consultar, insertar, actualizar y eliminar
-- =====================================================

USE master;
GO

IF NOT EXISTS
(
    SELECT 1
FROM sys.server_principals
WHERE name = 'LoginAdminEjercicios'
)
BEGIN
    CREATE LOGIN LoginAdminEjercicios
    WITH PASSWORD = 'AdminEjercicios#2026',
         CHECK_POLICY = ON;
END;
GO

USE GymDB;
GO

IF NOT EXISTS
(
    SELECT 1
FROM sys.database_principals
WHERE name = 'UsuarioAdminEjercicios'
)
BEGIN
    CREATE USER UsuarioAdminEjercicios
    FOR LOGIN LoginAdminEjercicios;
END;
GO

GRANT CONTROL
ON OBJECT::dbo.Ejercicios
TO UsuarioAdminEjercicios;
GO


-- =====================================================
-- 5. USUARIO CON PERMISOS RESTRINGIDOS
-- Puede consultar Miembros, excepto la columna Cedula
-- No puede actualizar ningún campo de Miembros
-- =====================================================

USE master;
GO

IF NOT EXISTS
(
    SELECT 1
FROM sys.server_principals
WHERE name = 'LoginConsultaMiembros'
)
BEGIN
    CREATE LOGIN LoginConsultaMiembros
    WITH PASSWORD = 'ConsultaMiembros#2026',
         CHECK_POLICY = ON;
END;
GO

USE GymDB;
GO

IF NOT EXISTS
(
    SELECT 1
FROM sys.database_principals
WHERE name = 'UsuarioConsultaMiembros'
)
BEGIN
    CREATE USER UsuarioConsultaMiembros
    FOR LOGIN LoginConsultaMiembros;
END;
GO

-- Permite consultar únicamente estas columnas.

GRANT SELECT
(
    MiembroId,
    Nombre,
    Apellido,
    Telefono,
    Correo,
    FechaRegistro,
    Estado
)
ON OBJECT::dbo.Miembros
TO UsuarioConsultaMiembros;
GO

-- Niega explícitamente la consulta de la cédula.

DENY SELECT (Cedula)
ON OBJECT::dbo.Miembros
TO UsuarioConsultaMiembros;
GO

-- Niega la actualización de toda la tabla Miembros.

DENY UPDATE
ON OBJECT::dbo.Miembros
TO UsuarioConsultaMiembros;
GO