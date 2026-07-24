USE GymDB;
GO

-- =====================================================
-- SEED DE DATOS PARA GYMDB
-- Inserta datos de prueba respetando las relaciones
-- =====================================================


-- =====================================================
-- 1. MIEMBROS
-- =====================================================

INSERT INTO dbo.Miembros
(
    Cedula,
    Nombre,
    Apellido,
    Telefono,
    Correo,
    FechaRegistro,
    Estado
)
VALUES
('00112345678', 'Carlos', 'Martínez', '809-555-1001', 'carlos.martinez@email.com', '2026-01-10', 1),
('00123456789', 'Laura', 'Gómez', '829-555-1002', 'laura.gomez@email.com', '2026-02-15', 1),
('00134567890', 'Miguel', 'Rodríguez', '849-555-1003', 'miguel.rodriguez@email.com', '2026-03-05', 1),
('00145678901', 'Ana', 'Fernández', '809-555-1004', 'ana.fernandez@email.com', '2026-04-20', 1),
('00156789012', 'José', 'Ramírez', '829-555-1005', 'jose.ramirez@email.com', '2026-05-12', 1),
('00167890123', 'Sofía', 'Castillo', '849-555-1006', 'sofia.castillo@email.com', '2026-06-01', 1);
GO


-- =====================================================
-- 2. PERFILES MÉDICOS
-- Relación uno a uno con Miembros
-- =====================================================

INSERT INTO dbo.PerfilesMedicos
(
    MiembroId,
    TipoSangre,
    AptoEntrenamiento,
    ObservacionesMedicas,
    ContactoEmergencia,
    TelefonoEmergencia,
    Estado
)
VALUES
(1, 'O+', 1, 'Sin observaciones relevantes.', 'María Martínez', '809-555-2001', 1),
(2, 'A+', 1, 'Alergia leve al polvo.', 'Pedro Gómez', '829-555-2002', 1),
(3, 'B+', 1, 'Antecedente de lesión en rodilla derecha.', 'Lucía Rodríguez', '849-555-2003', 1),
(4, 'O-', 1, 'Sin observaciones relevantes.', 'Juan Fernández', '809-555-2004', 1),
(5, 'A-', 0, 'Requiere autorización médica antes de entrenar.', 'Rosa Ramírez', '829-555-2005', 1),
(6, 'AB+', 1, 'Asma controlada.', 'Daniel Castillo', '849-555-2006', 1);
GO


-- =====================================================
-- 3. ENTRENADORES
-- =====================================================

INSERT INTO dbo.Entrenadores
(
    Cedula,
    Nombre,
    Apellido,
    Correo,
    Telefono,
    Especialidad,
    Estado
)
VALUES
('00212345678', 'Andrés', 'Pérez', 'andres.perez@gymdb.com', '809-555-3001', 'Fuerza y musculación', 1),
('00223456789', 'Mariana', 'López', 'mariana.lopez@gymdb.com', '829-555-3002', 'Pérdida de peso', 1),
('00234567890', 'Ricardo', 'Santos', 'ricardo.santos@gymdb.com', '849-555-3003', 'Acondicionamiento físico', 1),
('00245678901', 'Patricia', 'Díaz', 'patricia.diaz@gymdb.com', '809-555-3004', 'Movilidad y recuperación', 1);
GO


-- =====================================================
-- 4. RUTINAS
-- Relación uno a muchos con Entrenadores
-- =====================================================

INSERT INTO dbo.Rutinas
(
    EntrenadorId,
    Nombre,
    Objetivo,
    NivelDificultad,
    DuracionEstimadaMinutos,
    Descripcion,
    FechaCreacion,
    Estado
)
VALUES
(1, 'Fuerza inicial', 'Mejorar fuerza general', 'Principiante', 50, 'Rutina de cuerpo completo para nuevos miembros.', '2026-01-15', 1),
(2, 'Pérdida de grasa', 'Reducir grasa corporal', 'Intermedio', 60, 'Combina ejercicios de fuerza y trabajo cardiovascular.', '2026-02-20', 1),
(3, 'Resistencia general', 'Mejorar capacidad cardiovascular', 'Intermedio', 45, 'Rutina enfocada en resistencia y condición física.', '2026-03-10', 1),
(4, 'Movilidad básica', 'Mejorar movilidad y flexibilidad', 'Principiante', 35, 'Rutina de movilidad para articulaciones principales.', '2026-04-05', 1),
(NULL, 'Rutina libre de adaptación', 'Adaptación al gimnasio', 'Principiante', 30, 'Rutina general disponible sin entrenador asignado.', '2026-05-01', 1);
GO


-- =====================================================
-- 5. EJERCICIOS
-- =====================================================

INSERT INTO dbo.Ejercicios
(
    CodigoEjercicio,
    Nombre,
    GrupoMuscular,
    TipoEjercicio,
    Descripcion,
    Estado
)
VALUES
('EJ-001', 'Sentadilla', 'Piernas', 'Fuerza', 'Ejercicio compuesto para piernas y glúteos.', 1),
('EJ-002', 'Press de banca', 'Pecho', 'Fuerza', 'Ejercicio de empuje para pecho y tríceps.', 1),
('EJ-003', 'Remo con mancuerna', 'Espalda', 'Fuerza', 'Ejercicio de tracción para espalda.', 1),
('EJ-004', 'Plancha', 'Core', 'Isométrico', 'Ejercicio de estabilidad abdominal.', 1),
('EJ-005', 'Caminadora', 'Cardiovascular', 'Cardio', 'Trabajo cardiovascular en caminadora.', 1),
('EJ-006', 'Peso muerto rumano', 'Piernas', 'Fuerza', 'Ejercicio para femorales y glúteos.', 1),
('EJ-007', 'Press militar', 'Hombros', 'Fuerza', 'Ejercicio de empuje vertical.', 1),
('EJ-008', 'Bicicleta estática', 'Cardiovascular', 'Cardio', 'Trabajo cardiovascular de bajo impacto.', 1),
('EJ-009', 'Estiramiento de cadera', 'Movilidad', 'Movilidad', 'Ejercicio para mejorar movilidad de cadera.', 1),
('EJ-010', 'Rotación de hombros', 'Movilidad', 'Movilidad', 'Ejercicio para mejorar movilidad de hombros.', 1);
GO


-- =====================================================
-- 6. RUTINA EJERCICIO
-- Relación muchos a muchos entre Rutinas y Ejercicios
-- =====================================================

INSERT INTO dbo.RutinaEjercicio
(
    RutinaId,
    EjercicioId,
    DiaSemana,
    OrdenEjercicio,
    Series,
    Repeticiones,
    DuracionEjercicioSegundos,
    PesoSugerido,
    DescansoSegundos,
    Indicaciones,
    Estado
)
VALUES
(1, 1, 'Lunes', 1, 3, 12, NULL, 20.00, 90, 'Mantener la espalda recta.', 1),
(1, 2, 'Lunes', 2, 3, 10, NULL, 15.00, 90, 'Usar un peso controlable.', 1),
(1, 3, 'Lunes', 3, 3, 12, NULL, 10.00, 60, 'Evitar girar el torso.', 1),
(1, 4, 'Lunes', 4, 3, NULL, 30, NULL, 45, 'Mantener el abdomen contraído.', 1),

(2, 1, 'Martes', 1, 4, 15, NULL, 15.00, 60, 'Realizar con ritmo constante.', 1),
(2, 5, 'Martes', 2, 1, NULL, 1200, NULL, 60, 'Mantener intensidad moderada.', 1),
(2, 4, 'Jueves', 1, 4, NULL, 40, NULL, 45, 'No arquear la espalda.', 1),
(2, 8, 'Jueves', 2, 1, NULL, 900, NULL, 60, 'Mantener cadencia estable.', 1),

(3, 5, 'Miércoles', 1, 1, NULL, 1500, NULL, 60, 'Incrementar velocidad progresivamente.', 1),
(3, 8, 'Viernes', 1, 1, NULL, 1200, NULL, 60, 'Trabajar a intensidad media.', 1),
(3, 4, 'Viernes', 2, 3, NULL, 45, NULL, 45, 'Respirar de forma controlada.', 1),

(4, 9, 'Lunes', 1, 3, NULL, 40, NULL, 20, 'Movimiento lento y controlado.', 1),
(4, 10, 'Lunes', 2, 3, NULL, 30, NULL, 20, 'No forzar la articulación.', 1),

(5, 1, 'Sábado', 1, 2, 12, NULL, NULL, 60, 'Usar solo el peso corporal.', 1),
(5, 4, 'Sábado', 2, 2, NULL, 20, NULL, 30, 'Mantener una postura estable.', 1),
(5, 5, 'Sábado', 3, 1, NULL, 600, NULL, 60, 'Caminar a ritmo cómodo.', 1);
GO


-- =====================================================
-- 7. ASIGNACIONES DE RUTINA
-- Relación muchos a muchos entre Miembros y Rutinas
-- =====================================================

INSERT INTO dbo.AsignacionesRutina
(
    MiembroId,
    RutinaId,
    FechaInicio,
    FechaFin,
    Observaciones,
    Estado
)
VALUES
(1, 1, '2026-01-20', '2026-03-20', 'Primera rutina del miembro.', 1),
(2, 2, '2026-02-25', '2026-05-25', 'Revisar progreso mensualmente.', 1),
(3, 4, '2026-03-15', '2026-04-15', 'Adaptar ejercicios por lesión de rodilla.', 1),
(4, 3, '2026-04-25', '2026-07-25', 'Aumentar intensidad gradualmente.', 1),
(6, 5, '2026-06-05', NULL, 'Rutina inicial de adaptación.', 1),
(1, 3, '2026-04-01', NULL, 'Segunda rutina asignada al miembro.', 1);
GO


-- =====================================================
-- CONSULTAS DE VERIFICACIÓN
-- =====================================================

SELECT * FROM dbo.Miembros;
SELECT * FROM dbo.PerfilesMedicos;
SELECT * FROM dbo.Entrenadores;
SELECT * FROM dbo.Rutinas;
SELECT * FROM dbo.Ejercicios;
SELECT * FROM dbo.RutinaEjercicio;
SELECT * FROM dbo.AsignacionesRutina;
GO




