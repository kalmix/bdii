-- INSTALACIÓN COMPLETA DE GYMDB
-- Ejecutar desde esta carpeta con SQLCMD o activar "SQLCMD Mode" en SSMS.
-- O ejecutar `sqlcmd -S localhost -E -i instalar.sql` desde la CLI

:ON ERROR EXIT
:r .\script.sql
:r .\seed.sql
:r .\views.sql
:r .\functions.sql
:r .\triggers.sql
:r .\procedures.sql
:r .\login.sql
