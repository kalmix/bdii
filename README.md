# GymDB - Sistema de Gestión de Gimnasio 🏋️‍♂️

Base de Datos relacional desarrollada en **Microsoft SQL Server** para la práctica de Base de Datos II.

---

## 📌 Descripción del Proyecto

`GymDB` es un sistema de base de datos diseñado para gestionar la operativa central de un gimnasio, abarcando la administración de miembros, fichas médicas, entrenadores, rutinas de entrenamiento, ejercicios disponibles, asignaciones y logs de auditoría.

> [!NOTE]
> Esta base de datos cumple al 100% con los requerimientos académicos: más de 6 tablas, relaciones 1:1, 1:N y N:M, vistas avanzadas, funciones escalares e inline table, triggers de borrado lógico y auditoría, procedimientos almacenados y roles/usuarios con permisos específicos.

---

## 🗂️ Estructura de Tablas y Relaciones

La base de datos consta de **8 tablas**:
1. **`Miembros`**: Registro de clientes del gimnasio. *(Clave única en `Cedula`)*.
2. **`PerfilesMedicos`**: Información médica de cada miembro *(Relación 1:1 con `Miembros`)*.
3. **`Entrenadores`**: Personal capacitado *(Relación 1:N con `Rutinas`)*.
4. **`Rutinas`**: Planes de entrenamiento creados por entrenadores.
5. **`Ejercicios`**: Catálogo de ejercicios disponibles *(Clave única en `CodigoEjercicio`)*.
6. **`RutinaEjercicio`**: Tabla intermedia que relaciona rutinas y ejercicios *(Relación N:M)*.
7. **`AsignacionesRutina`**: Tabla intermedia entre miembros y rutinas asignadas *(Relación N:M)*.
8. **`Auditoria`**: Registro histórico de cambios en tablas auditadas (Guarda tabla, campo, valor anterior, valor actual, fecha y usuario).

---

## ⚡ Estructura del Repositorio

| Archivo / Carpeta | Descripción |
| :--- | :--- |
| `script.sql` | Creación de la base de datos `GymDB`, tablas, claves primarias, foráneas y únicas. |
| `seed.sql` | Inserción de datos iniciales de prueba para todas las tablas. |
| `views.sql` | Creación de las 3 Vistas requeridas (JOIN, ORDER BY con TOP, UNION). |
| `functions.sql` | Funciones escalares y funciones inline table (parametrizadas y multitabla). |
| `triggers.sql` | Triggers de borrado lógico (`INSTEAD OF DELETE`) y triggers de auditoría (`AFTER UPDATE`). |
| `procedures.sql` | Procedimientos almacenados CRUD para la gestión de Miembros. |
| `login.sql` | Creación de logins, usuarios y asignación granular de permisos en SQL Server. |
| `instalar.sql` | Script maestro de instalación mediante `SQLCMD`. |
| `clean.sql` | Script de limpieza / eliminación segura de la base de datos `GymDB`. |
| `docs/` | Contiene el Diagrama Entidad-Relación (`Diagrama-ER.png`) y la documentación (`Documentacion_GymDB.pdf`). |

---

## 🚀 Instalación y Despliegue

### Opción 1: Mediante la CLI de `sqlcmd`
Ejecutar desde la terminal en el directorio raíz del proyecto:
```bash
sqlcmd -S localhost -E -i instalar.sql
```
*(Para drivers ODBC 18+, agregar el parámetro `-C` para confiar en el certificado del servidor).*

### Opción 2: Desde SQL Server Management Studio (SSMS)
1. Abrir el archivo `instalar.sql` en SSMS.
2. Ir al menú **Consulta (Query)** -> Activar **Modo SQLCMD (SQLCMD Mode)**.
3. Hacer clic en **Ejecutar (Execute / F5)**.

---

## 🔐 Usuarios y Permisos Configurados

1. **`LoginAdminServidor`**: Administrador del servidor de base de datos (`sysadmin`).
2. **`UsuarioAdminGymDB`**: Administrador exclusivo de `GymDB` (`db_owner`).
3. **`UsuarioSoloLectura`**: Acceso exclusivo de consulta (`db_datareader`).
4. **`UsuarioAdminEjercicios`**: Permiso total (`GRANT CONTROL`) únicamente en la tabla `dbo.Ejercicios`.
5. **`UsuarioConsultaMiembros`**: Permiso restringido en `dbo.Miembros` (Se niega `UPDATE` y se niega `SELECT` en la columna `Cedula`).
