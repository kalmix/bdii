USE GymDB;
GO

-- =====================================================
-- PROCEDIMIENTOS CRUD DE LA TABLA MIEMBROS
-- =====================================================

-- INSERTAR
CREATE OR ALTER PROCEDURE dbo.AgregarMiembro
    @Cedula VARCHAR(13),
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @Telefono VARCHAR(20) = NULL,
    @Correo VARCHAR(100) = NULL,
    @Estado BIT = 1
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Miembros
        (
        Cedula,
        Nombre,
        Apellido,
        Telefono,
        Correo,
        Estado
        )
    VALUES
        (
            @Cedula,
            @Nombre,
            @Apellido,
            @Telefono,
            @Correo,
            @Estado
    );

    SELECT CAST(SCOPE_IDENTITY() AS INT) AS MiembroIdCreado;
END;
GO

-- MODIFICAR
CREATE OR ALTER PROCEDURE dbo.ActualizarMiembro
    @MiembroId INT,
    @Cedula VARCHAR(13),
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @Telefono VARCHAR(20) = NULL,
    @Correo VARCHAR(100) = NULL,
    @Estado BIT = 1
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.Miembros
    SET
        Cedula = @Cedula,
        Nombre = @Nombre,
        Apellido = @Apellido,
        Telefono = @Telefono,
        Correo = @Correo,
        Estado = @Estado
    WHERE MiembroId = @MiembroId;

    SELECT @@ROWCOUNT AS RegistrosModificados;
END;
GO

-- ELIMINAR
-- El DELETE activa TR_Miembros_EliminacionLogica.
-- El registro no se borra físicamente: el trigger cambia Estado a 0.
CREATE OR ALTER PROCEDURE dbo.EliminarMiembro
    @MiembroId INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM dbo.Miembros
    WHERE MiembroId = @MiembroId;

    SELECT @@ROWCOUNT AS RegistrosProcesados;
END;
GO

-- CONSULTAR
CREATE OR ALTER PROCEDURE dbo.MostrarMiembros
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
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
END;
GO

-- =====================================================
-- EJEMPLOS DE USO
-- Se dejan comentados para no modificar los datos al instalar.
-- =====================================================
/*
EXEC dbo.AgregarMiembro
    @Cedula = '00199999999',
    @Nombre = 'Miembro',
    @Apellido = 'Prueba',
    @Telefono = '809-555-9999',
    @Correo = 'prueba@gymdb.com';

EXEC dbo.ActualizarMiembro
    @MiembroId = 1,
    @Cedula = '00112345678',
    @Nombre = 'Carlos',
    @Apellido = 'Martínez',
    @Telefono = '809-555-1010',
    @Correo = 'carlos.martinez@email.com',
    @Estado = 1;

EXEC dbo.EliminarMiembro @MiembroId = 1;
EXEC dbo.MostrarMiembros;
*/
