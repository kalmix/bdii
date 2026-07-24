USE GymDB;
GO
-- =====================================================
-- 1. FUNCIÓN ESCALAR
-- Cuenta la cantidad de miembros según su estado
-- Recibe 1 para miembros activos y 0 para inactivos
-- =====================================================

CREATE OR ALTER FUNCTION dbo.fn_ContarMiembrosPorEstado
(
    @Estado BIT
)
RETURNS INT
AS
BEGIN
    DECLARE @CantidadMiembros INT;

    SELECT @CantidadMiembros = COUNT(*)
    FROM dbo.Miembros
    WHERE Estado = @Estado;

    RETURN @CantidadMiembros;
END;
GO


-- Ejemplo de uso:
SELECT dbo.fn_ContarMiembrosPorEstado(1) AS MiembrosActivos;
GO


-- =====================================================
-- 2. FUNCIÓN INLINE TABLE
-- Relaciona Rutinas, Entrenadores, RutinaEjercicio
-- y Ejercicios
-- Muestra los ejercicios que forman parte de cada rutina
-- =====================================================

CREATE OR ALTER FUNCTION dbo.fn_DetalleRutinas()
RETURNS TABLE
AS
RETURN
(
    SELECT
    r.RutinaId,
    r.Nombre AS NombreRutina,
    r.Objetivo,
    r.NivelDificultad,
    r.DuracionEstimadaMinutos,

    e.EntrenadorId,
    CONCAT(e.Nombre, ' ', e.Apellido) AS Entrenador,

    re.RutinaEjercicioId,
    re.DiaSemana,
    re.OrdenEjercicio,
    re.Series,
    re.Repeticiones,
    re.DuracionEjercicioSegundos,
    re.PesoSugerido,
    re.DescansoSegundos,

    ej.EjercicioId,
    ej.CodigoEjercicio,
    ej.Nombre AS NombreEjercicio,
    ej.GrupoMuscular,
    ej.TipoEjercicio
FROM dbo.Rutinas r
    LEFT JOIN dbo.Entrenadores e
    ON r.EntrenadorId = e.EntrenadorId
    INNER JOIN dbo.RutinaEjercicio re
    ON r.RutinaId = re.RutinaId
    INNER JOIN dbo.Ejercicios ej
    ON re.EjercicioId = ej.EjercicioId
);
GO


-- Ejemplo de uso:
SELECT *
FROM dbo.fn_DetalleRutinas();
GO


-- =====================================================
-- 3. FUNCIÓN INLINE TABLE CON PARÁMETRO
-- Relaciona Miembros, AsignacionesRutina y Rutinas
-- Filtra las rutinas asignadas a un miembro específico
-- =====================================================

CREATE OR ALTER FUNCTION dbo.fn_RutinasPorMiembro
(
    @MiembroId INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT
    m.MiembroId,
    m.Cedula,
    CONCAT(m.Nombre, ' ', m.Apellido) AS Miembro,

    ar.AsignacionId,
    ar.FechaInicio,
    ar.FechaFin,
    ar.Observaciones,
    ar.Estado AS EstadoAsignacion,

    r.RutinaId,
    r.Nombre AS NombreRutina,
    r.Objetivo,
    r.NivelDificultad,
    r.DuracionEstimadaMinutos
FROM dbo.Miembros m
    INNER JOIN dbo.AsignacionesRutina ar
    ON m.MiembroId = ar.MiembroId
    INNER JOIN dbo.Rutinas r
    ON ar.RutinaId = r.RutinaId
WHERE m.MiembroId = @MiembroId
);
GO


-- Ejemplo de uso:
SELECT *
FROM dbo.fn_RutinasPorMiembro(1);
GO
