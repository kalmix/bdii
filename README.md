# GymDB - Práctica de Base de Datos II

Base de datos relacional en SQL Server para la gestión de un gimnasio.

## Estructura de archivos

```
bdii/
├── docs/
│   ├── Diagrama-ER.png
│   └── Documentacion_GymDB.pdf
├── clean.sql
├── functions.sql
├── instalar.sql
├── login.sql
├── procedures.sql
├── script.sql
├── seed.sql
├── triggers.sql
├── views.sql
└── README.md
```

## Instalación

### Opción 1: Desde la consola (SQLCMD)
```bash
sqlcmd -S localhost -E -C -i instalar.sql
```

### Opción 2: Desde SSMS (SQL Server Management Studio)
1. Abrir `instalar.sql`.
2. Activar el **Modo SQLCMD** (Menú *Consulta* > *Modo SQLCMD*).
3. Ejecutar.
