# GymDB - Práctica de Base de Datos II

Base de datos relacional en SQL Server para la gestión de un gimnasio.

## Estructura de archivos

- `script.sql`: Creación de la base de datos, tablas y relaciones (PK, FK, UNIQUE).
- `seed.sql`: Datos de prueba.
- `views.sql`: Vistas.
- `functions.sql`: Funciones escalares y de tabla en línea.
- `triggers.sql`: Triggers de borrado lógico y auditoría.
- `procedures.sql`: Procedimientos almacenados (CRUD de miembros).
- `login.sql`: Logins, usuarios y permisos.
- `instalar.sql`: Script maestro para ejecutar todo el proyecto en orden.
- `clean.sql`: Elimina la base de datos GymDB si se requiere reinstalar.
- `docs/`: Contiene el diagrama ER (`Diagrama-ER.png`) y el documento PDF (`Documentacion_GymDB.pdf`).

## Instalación

### Opción 1: Desde la consola (SQLCMD)
```bash
sqlcmd -S localhost -E -C -i instalar.sql
```

### Opción 2: Desde SSMS (SQL Server Management Studio)
1. Abrir `instalar.sql`.
2. Activar el **Modo SQLCMD** (Menú *Consulta* > *Modo SQLCMD*).
3. Ejecutar.
