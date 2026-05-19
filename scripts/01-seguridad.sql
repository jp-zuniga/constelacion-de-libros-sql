USE [ConstelacionLibros];
GO

-- ============================================================
-- LOGINS
-- ============================================================

IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'login_admin_constelacion')
BEGIN
    CREATE LOGIN [login_admin_constelacion]
        WITH PASSWORD = 'Admin@Constelacion2025!',
             DEFAULT_DATABASE = [ConstelacionLibros],
             CHECK_EXPIRATION = ON,
             CHECK_POLICY = ON;
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'login_bibliotecario')
BEGIN
    CREATE LOGIN [login_bibliotecario]
        WITH PASSWORD = 'Biblio@Constelacion2025!',
             DEFAULT_DATABASE = [ConstelacionLibros],
             CHECK_EXPIRATION = ON,
             CHECK_POLICY = ON;
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'login_cliente_app')
BEGIN
    CREATE LOGIN [login_cliente_app]
        WITH PASSWORD = 'Cliente@Constelacion2025!',
             DEFAULT_DATABASE = [ConstelacionLibros],
             CHECK_EXPIRATION = ON,
             CHECK_POLICY = ON;
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'login_soporte_ti')
BEGIN
    CREATE LOGIN [login_soporte_ti]
        WITH PASSWORD = 'Soporte@Constelacion2025!',
             DEFAULT_DATABASE = [ConstelacionLibros],
             CHECK_EXPIRATION = ON,
             CHECK_POLICY = ON;
END
GO

-- ============================================================
-- USUARIOS
-- ============================================================

USE [ConstelacionLibros];
GO

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'usr_admin')
BEGIN
    CREATE USER [usr_admin] FOR LOGIN [login_admin_constelacion];
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'usr_bibliotecario')
BEGIN
    CREATE USER [usr_bibliotecario] FOR LOGIN [login_bibliotecario];
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'usr_cliente')
BEGIN
    CREATE USER [usr_cliente] FOR LOGIN [login_cliente_app];
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'usr_soporte')
BEGIN
    CREATE USER [usr_soporte] FOR LOGIN [login_soporte_ti];
END
GO

-- ============================================================
-- ROLES
-- ============================================================

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'rol_administrador' AND type = 'R')
BEGIN
    CREATE ROLE [rol_administrador];
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'rol_bibliotecario' AND type = 'R')
BEGIN
    CREATE ROLE [rol_bibliotecario];
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'rol_cliente' AND type = 'R')
BEGIN
    CREATE ROLE [rol_cliente];
END
GO

-- ============================================================
-- PERMISOS ADMIN
-- ============================================================

GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[tbl_Autor]           TO [rol_administrador];
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[tbl_Editorial]       TO [rol_administrador];
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[tbl_Categoria]       TO [rol_administrador];
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[tbl_Libro]           TO [rol_administrador];
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[tbl_Libro_Autor]     TO [rol_administrador];
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[tbl_Estante]         TO [rol_administrador];
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[tbl_Fila]            TO [rol_administrador];
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[tbl_Columna]         TO [rol_administrador];
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[tbl_Ubicacion]       TO [rol_administrador];
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[tbl_Estado_Ejemplar] TO [rol_administrador];
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[tbl_Ejemplar]        TO [rol_administrador];
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[tbl_Cliente]         TO [rol_administrador];
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[tbl_Empleado]        TO [rol_administrador];
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[tbl_Prestamo]        TO [rol_administrador];
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[tbl_Reserva]         TO [rol_administrador];
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[tbl_Estado_Reserva]  TO [rol_administrador];
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[tbl_Multa]           TO [rol_administrador];
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[tbl_Estado_Multa]    TO [rol_administrador];
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[tbl_Inventario]      TO [rol_administrador];
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[tbl_Tipo_Movimiento] TO [rol_administrador];
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[tbl_Deuda]           TO [rol_administrador];
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[tbl_Metodo_Pago]     TO [rol_administrador];
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[tbl_Pago]            TO [rol_administrador];
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[tbl_Pago_Detalle]    TO [rol_administrador];
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[tbl_Pago_Aplicacion] TO [rol_administrador];
GRANT SELECT ON [dbo].[vw_Prestamos_Activos]                        TO [rol_administrador];

-- ============================================================
-- PERMISOS BIBLIOTECARIO
-- ============================================================

GRANT SELECT ON [dbo].[tbl_Autor]           TO [rol_bibliotecario];
GRANT SELECT ON [dbo].[tbl_Editorial]       TO [rol_bibliotecario];
GRANT SELECT ON [dbo].[tbl_Categoria]       TO [rol_bibliotecario];
GRANT SELECT ON [dbo].[tbl_Estado_Ejemplar] TO [rol_bibliotecario];
GRANT SELECT ON [dbo].[tbl_Estado_Reserva]  TO [rol_bibliotecario];
GRANT SELECT ON [dbo].[tbl_Estado_Multa]    TO [rol_bibliotecario];
GRANT SELECT ON [dbo].[tbl_Tipo_Movimiento] TO [rol_bibliotecario];
GRANT SELECT ON [dbo].[tbl_Metodo_Pago]     TO [rol_bibliotecario];
GRANT SELECT ON [dbo].[tbl_Estante]         TO [rol_bibliotecario];
GRANT SELECT ON [dbo].[tbl_Fila]            TO [rol_bibliotecario];
GRANT SELECT ON [dbo].[tbl_Columna]         TO [rol_bibliotecario];
GRANT SELECT ON [dbo].[tbl_Ubicacion]       TO [rol_bibliotecario];

GRANT SELECT, UPDATE ON [dbo].[tbl_Libro]       TO [rol_bibliotecario];
GRANT SELECT         ON [dbo].[tbl_Libro_Autor] TO [rol_bibliotecario];

GRANT SELECT, UPDATE ON [dbo].[tbl_Ejemplar] TO [rol_bibliotecario];

GRANT SELECT, INSERT, UPDATE ON [dbo].[tbl_Cliente] TO [rol_bibliotecario];

GRANT SELECT, INSERT, UPDATE ON [dbo].[tbl_Prestamo] TO [rol_bibliotecario];

GRANT SELECT, INSERT, UPDATE ON [dbo].[tbl_Reserva] TO [rol_bibliotecario];

GRANT SELECT, INSERT, UPDATE ON [dbo].[tbl_Multa] TO [rol_bibliotecario];

GRANT SELECT, INSERT ON [dbo].[tbl_Inventario] TO [rol_bibliotecario];

GRANT SELECT, INSERT, UPDATE ON [dbo].[tbl_Deuda]           TO [rol_bibliotecario];
GRANT SELECT, INSERT         ON [dbo].[tbl_Pago]            TO [rol_bibliotecario];
GRANT SELECT, INSERT         ON [dbo].[tbl_Pago_Detalle]    TO [rol_bibliotecario];
GRANT SELECT, INSERT         ON [dbo].[tbl_Pago_Aplicacion] TO [rol_bibliotecario];

GRANT SELECT ON [dbo].[vw_Prestamos_Activos] TO [rol_bibliotecario];

-- ============================================================
-- PERMISOS CLIENTE
-- ============================================================

GRANT SELECT ON [dbo].[tbl_Libro]           TO [rol_cliente];
GRANT SELECT ON [dbo].[tbl_Autor]           TO [rol_cliente];
GRANT SELECT ON [dbo].[tbl_Libro_Autor]     TO [rol_cliente];
GRANT SELECT ON [dbo].[tbl_Editorial]       TO [rol_cliente];
GRANT SELECT ON [dbo].[tbl_Categoria]       TO [rol_cliente];
GRANT SELECT ON [dbo].[tbl_Ejemplar]        TO [rol_cliente];
GRANT SELECT ON [dbo].[tbl_Estado_Ejemplar] TO [rol_cliente];

GRANT SELECT, INSERT, UPDATE ON [dbo].[tbl_Reserva]      TO [rol_cliente];
GRANT SELECT                 ON [dbo].[tbl_Estado_Reserva] TO [rol_cliente];

GRANT SELECT ON [dbo].[tbl_Prestamo] TO [rol_cliente];
GRANT SELECT ON [dbo].[tbl_Multa]    TO [rol_cliente];
GRANT SELECT ON [dbo].[tbl_Deuda]    TO [rol_cliente];

-- ============================================================
-- ROLES DE USUARIOS
-- ============================================================

ALTER ROLE [rol_administrador] ADD MEMBER [usr_admin];
ALTER ROLE [rol_administrador] ADD MEMBER [usr_soporte];
ALTER ROLE [rol_bibliotecario] ADD MEMBER [usr_bibliotecario];
ALTER ROLE [rol_cliente]       ADD MEMBER [usr_cliente];

-- ============================================================
-- AUDITORIA
-- ============================================================

IF OBJECT_ID('dbo.tbl_Auditoria', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[tbl_Auditoria] (
        [id_auditoria]    INT           IDENTITY(1,1) NOT NULL,
        [tabla_afectada]  VARCHAR(60)   NOT NULL,
        [operacion]       VARCHAR(10)   NOT NULL,
        [usuario_bd]      VARCHAR(128)  NOT NULL,
        [login_servidor]  VARCHAR(128)  NOT NULL,
        [fecha_hora]      DATETIME2     NOT NULL DEFAULT SYSDATETIME(),
        [id_registro]     INT           NULL,
        [detalle]         VARCHAR(500)  NULL,
        CONSTRAINT [PK_Auditoria] PRIMARY KEY CLUSTERED ([id_auditoria] ASC)
    );
END
GO

-- ============================================================
-- TRIGGERS DE AUDITORIA
-- ============================================================

CREATE OR ALTER TRIGGER [dbo].[trg_Auditoria_Prestamo]
ON [dbo].[tbl_Prestamo]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @operacion VARCHAR(10);

    IF EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted)
        SET @operacion = 'UPDATE';
    ELSE IF EXISTS (SELECT 1 FROM inserted)
        SET @operacion = 'INSERT';
    ELSE
        SET @operacion = 'DELETE';

    INSERT INTO [dbo].[tbl_Auditoria] (tabla_afectada, operacion, usuario_bd, login_servidor, id_registro, detalle)
    SELECT
        'tbl_Prestamo',
        @operacion,
        USER_NAME(),
        SUSER_SNAME(),
        COALESCE(i.id_prestamo, d.id_prestamo),
        'Cliente: ' + CAST(COALESCE(i.id_cliente, d.id_cliente) AS VARCHAR)
        + ' | Ejemplar: ' + CAST(COALESCE(i.id_ejemplar, d.id_ejemplar) AS VARCHAR)
        + ' | Estado: ' + CAST(COALESCE(i.estado, d.estado) AS VARCHAR)
    FROM inserted i
    FULL OUTER JOIN deleted d ON i.id_prestamo = d.id_prestamo;
END;
GO

CREATE OR ALTER TRIGGER [dbo].[trg_Auditoria_Multa]
ON [dbo].[tbl_Multa]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @operacion VARCHAR(10);

    IF EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted)
        SET @operacion = 'UPDATE';
    ELSE IF EXISTS (SELECT 1 FROM inserted)
        SET @operacion = 'INSERT';
    ELSE
        SET @operacion = 'DELETE';

    INSERT INTO [dbo].[tbl_Auditoria] (tabla_afectada, operacion, usuario_bd, login_servidor, id_registro, detalle)
    SELECT
        'tbl_Multa',
        @operacion,
        USER_NAME(),
        SUSER_SNAME(),
        COALESCE(i.id_multa, d.id_multa),
        'Prestamo: ' + CAST(COALESCE(i.id_prestamo, d.id_prestamo) AS VARCHAR)
        + ' | Monto: ' + CAST(COALESCE(i.monto, d.monto) AS VARCHAR)
        + ' | Motivo: ' + COALESCE(i.motivo, d.motivo)
    FROM inserted i
    FULL OUTER JOIN deleted d ON i.id_multa = d.id_multa;
END;
GO

CREATE OR ALTER TRIGGER [dbo].[trg_Auditoria_Pago]
ON [dbo].[tbl_Pago]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @operacion VARCHAR(10);

    IF EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted)
        SET @operacion = 'UPDATE';
    ELSE IF EXISTS (SELECT 1 FROM inserted)
        SET @operacion = 'INSERT';
    ELSE
        SET @operacion = 'DELETE';

    INSERT INTO [dbo].[tbl_Auditoria] (tabla_afectada, operacion, usuario_bd, login_servidor, id_registro, detalle)
    SELECT
        'tbl_Pago',
        @operacion,
        USER_NAME(),
        SUSER_SNAME(),
        COALESCE(i.id_pago, d.id_pago),
        'Cliente: ' + CAST(COALESCE(i.id_cliente, d.id_cliente) AS VARCHAR)
        + ' | Monto: $' + CAST(COALESCE(i.monto_total, d.monto_total) AS VARCHAR)
        + ' | Metodo: ' + CAST(COALESCE(i.id_metodo_pago, d.id_metodo_pago) AS VARCHAR)
    FROM inserted i
    FULL OUTER JOIN deleted d ON i.id_pago = d.id_pago;
END;
GO

CREATE OR ALTER TRIGGER [dbo].[trg_Auditoria_Empleado]
ON [dbo].[tbl_Empleado]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @operacion VARCHAR(10);

    IF EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted)
        SET @operacion = 'UPDATE';
    ELSE IF EXISTS (SELECT 1 FROM inserted)
        SET @operacion = 'INSERT';
    ELSE
        SET @operacion = 'DELETE';

    INSERT INTO [dbo].[tbl_Auditoria] (tabla_afectada, operacion, usuario_bd, login_servidor, id_registro, detalle)
    SELECT
        'tbl_Empleado',
        @operacion,
        USER_NAME(),
        SUSER_SNAME(),
        COALESCE(i.id_empleado, d.id_empleado),
        'Empleado: ' + COALESCE(i.nombres, d.nombres) + ' ' + COALESCE(i.apellidos, d.apellidos)
        + ' | Email: ' + COALESCE(i.email, d.email)
    FROM inserted i
    FULL OUTER JOIN deleted d ON i.id_empleado = d.id_empleado;
END;
GO

-- ============================================================
-- MATAR SA
-- ============================================================

ALTER LOGIN [sa] DISABLE;

-- ============================================================
-- VERIFICACIONES
-- ============================================================

SELECT name AS usuario_sin_login
FROM sys.database_principals
WHERE type IN ('S','U')
  AND authentication_type = 0
  AND name NOT IN ('dbo','guest','INFORMATION_SCHEMA','sys');
GO

SELECT name, type_desc, is_disabled, create_date
FROM sys.server_principals
WHERE name LIKE '%constelacion%' OR name LIKE 'login_%'
ORDER BY create_date;
GO

SELECT dp.name AS usuario, dp.type_desc, sl.name AS login_asociado
FROM sys.database_principals dp
LEFT JOIN sys.server_principals sl ON dp.sid = sl.sid
WHERE dp.type IN ('S','U') AND dp.name NOT IN ('dbo','guest','INFORMATION_SCHEMA','sys');
GO

SELECT r.name AS rol, m.name AS miembro
FROM sys.database_role_members rm
JOIN sys.database_principals r ON rm.role_principal_id = r.principal_id
JOIN sys.database_principals m ON rm.member_principal_id = m.principal_id
ORDER BY r.name;
GO

SELECT TOP 50
    id_auditoria, tabla_afectada, operacion,
    usuario_bd, login_servidor, fecha_hora,
    id_registro, detalle
FROM [dbo].[tbl_Auditoria]
ORDER BY fecha_hora DESC;
GO
