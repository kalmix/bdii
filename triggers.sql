USE GymDB;
GO
-- =====================================================
-- TRIGGER DE ELIMINACIÓN LÓGICA DE MIEMBROS
-- En lugar de eliminar el miembro, cambia Estado a 0
-- =====================================================

CREATE OR ALTER TRIGGER dbo.TR_Miembros_EliminacionLogica
ON dbo.Miembros
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE M
    SET Estado = 0
    FROM dbo.Miembros M
        INNER JOIN deleted D
        ON M.MiembroId = D.MiembroId;
END;
GO


-- =====================================================
-- TRIGGER DE ELIMINACIÓN LÓGICA DE ENTRENADORES
-- En lugar de eliminar el entrenador, cambia Estado a 0
-- =====================================================

CREATE OR ALTER TRIGGER dbo.TR_Entrenadores_EliminacionLogica
ON dbo.Entrenadores
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE E
    SET Estado = 0
    FROM dbo.Entrenadores E
        INNER JOIN deleted D
        ON E.EntrenadorId = D.EntrenadorId;
END;
GO


-- =====================================================
-- TRIGGER DE ELIMINACIÓN LÓGICA DE EJERCICIOS
-- En lugar de eliminar el ejercicio, cambia Estado a 0
-- =====================================================

CREATE OR ALTER TRIGGER dbo.TR_Ejercicios_EliminacionLogica
ON dbo.Ejercicios
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE E
    SET Estado = 0
    FROM dbo.Ejercicios E
        INNER JOIN deleted D
        ON E.EjercicioId = D.EjercicioId;
END;
GO


-- =====================================================
-- TRIGGER DE ELIMINACIÓN LÓGICA DE RUTINAS
-- En lugar de eliminar la rutina, cambia Estado a 0
-- =====================================================

CREATE OR ALTER TRIGGER dbo.TR_Rutinas_EliminacionLogica
ON dbo.Rutinas
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE R
    SET Estado = 0
    FROM dbo.Rutinas R
        INNER JOIN deleted D
        ON R.RutinaId = D.RutinaId;
END;
GO


-- =====================================================
-- TRIGGER DE ELIMINACIÓN LÓGICA DE ASIGNACIONES
-- En lugar de eliminar la asignación, cambia Estado a 0
-- =====================================================

CREATE OR ALTER TRIGGER dbo.TR_AsignacionesRutina_EliminacionLogica
ON dbo.AsignacionesRutina
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE A
    SET Estado = 0
    FROM dbo.AsignacionesRutina A
        INNER JOIN deleted D
        ON A.AsignacionId = D.AsignacionId;
END;
GO

USE GymDB;
GO


-- =====================================================
-- TRIGGER DE AUDITORÍA DE MIEMBROS
-- Guarda valores anteriores y actuales de los cambios
-- =====================================================

CREATE OR ALTER TRIGGER dbo.TR_Miembros_Auditoria
ON dbo.Miembros
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Auditoria
        (
        NombreTabla,
        RegistroId,
        NombreCampo,
        ValorAnterior,
        ValorActual,
        Usuario
        )
    SELECT
        'Miembros',
        D.MiembroId,
        C.NombreCampo,
        C.ValorAnterior,
        C.ValorActual,
        SUSER_SNAME()
    FROM deleted D
        INNER JOIN inserted I
        ON D.MiembroId = I.MiembroId
    CROSS APPLY
    (
        VALUES
            ('Cedula', CONVERT(VARCHAR(500), D.Cedula), CONVERT(VARCHAR(500), I.Cedula)),
            ('Nombre', CONVERT(VARCHAR(500), D.Nombre), CONVERT(VARCHAR(500), I.Nombre)),
            ('Apellido', CONVERT(VARCHAR(500), D.Apellido), CONVERT(VARCHAR(500), I.Apellido)),
            ('Telefono', CONVERT(VARCHAR(500), D.Telefono), CONVERT(VARCHAR(500), I.Telefono)),
            ('Correo', CONVERT(VARCHAR(500), D.Correo), CONVERT(VARCHAR(500), I.Correo)),
            ('FechaRegistro', CONVERT(VARCHAR(500), D.FechaRegistro, 23), CONVERT(VARCHAR(500), I.FechaRegistro, 23)),
            ('Estado', CONVERT(VARCHAR(500), D.Estado), CONVERT(VARCHAR(500), I.Estado))
    ) C (NombreCampo, ValorAnterior, ValorActual)
    WHERE ISNULL(C.ValorAnterior, '<NULL>')
       <> ISNULL(C.ValorActual, '<NULL>');
END;
GO


-- =====================================================
-- TRIGGER DE AUDITORÍA DE ENTRENADORES
-- Guarda valores anteriores y actuales de los cambios
-- =====================================================

CREATE OR ALTER TRIGGER dbo.TR_Entrenadores_Auditoria
ON dbo.Entrenadores
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Auditoria
        (
        NombreTabla,
        RegistroId,
        NombreCampo,
        ValorAnterior,
        ValorActual,
        Usuario
        )
    SELECT
        'Entrenadores',
        D.EntrenadorId,
        C.NombreCampo,
        C.ValorAnterior,
        C.ValorActual,
        SUSER_SNAME()
    FROM deleted D
        INNER JOIN inserted I
        ON D.EntrenadorId = I.EntrenadorId
    CROSS APPLY
    (
        VALUES
            ('Cedula', CONVERT(VARCHAR(500), D.Cedula), CONVERT(VARCHAR(500), I.Cedula)),
            ('Nombre', CONVERT(VARCHAR(500), D.Nombre), CONVERT(VARCHAR(500), I.Nombre)),
            ('Apellido', CONVERT(VARCHAR(500), D.Apellido), CONVERT(VARCHAR(500), I.Apellido)),
            ('Correo', CONVERT(VARCHAR(500), D.Correo), CONVERT(VARCHAR(500), I.Correo)),
            ('Telefono', CONVERT(VARCHAR(500), D.Telefono), CONVERT(VARCHAR(500), I.Telefono)),
            ('Especialidad', CONVERT(VARCHAR(500), D.Especialidad), CONVERT(VARCHAR(500), I.Especialidad)),
            ('Estado', CONVERT(VARCHAR(500), D.Estado), CONVERT(VARCHAR(500), I.Estado))
    ) C (NombreCampo, ValorAnterior, ValorActual)
    WHERE ISNULL(C.ValorAnterior, '<NULL>')
       <> ISNULL(C.ValorActual, '<NULL>');
END;
GO
