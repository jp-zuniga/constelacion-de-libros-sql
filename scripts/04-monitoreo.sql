-- ============================================================
-- DIRECTORIO PARA EXTENDED EVENTS
-- ============================================================

IF (SELECT host_platform FROM sys.dm_os_host_info) = 'Windows'
BEGIN
    EXEC sp_configure 'show advanced options', 1; RECONFIGURE;
    EXEC sp_configure 'xp_cmdshell', 1;          RECONFIGURE;

    EXEC xp_cmdshell 'mkdir "C:\XEvents" 2>nul';

    EXEC sp_configure 'xp_cmdshell', 0;          RECONFIGURE;
    EXEC sp_configure 'show advanced options', 0; RECONFIGURE;
END
GO

-- ============================================================
-- SESION DE EXTENDED EVENTS
-- ============================================================

IF EXISTS (SELECT 1 FROM sys.server_event_sessions WHERE name = 'XE_ConstelacionLibros_Monitor')
BEGIN
    ALTER EVENT SESSION [XE_ConstelacionLibros_Monitor] ON SERVER STATE = STOP;
    DROP  EVENT SESSION [XE_ConstelacionLibros_Monitor] ON SERVER;
END
GO

DECLARE @ruta_xe NVARCHAR(300);
IF (SELECT host_platform FROM sys.dm_os_host_info) = 'Linux'
    SET @ruta_xe = N'/var/opt/mssql/xevents/ConstelacionLibros_Monitor.xel';
ELSE
    SET @ruta_xe = N'C:\XEvents\ConstelacionLibros_Monitor.xel';

DECLARE @sql_xe NVARCHAR(MAX) = N'
CREATE EVENT SESSION [XE_ConstelacionLibros_Monitor] ON SERVER
ADD EVENT sqlserver.sql_statement_completed (
    ACTION (sqlserver.database_name, sqlserver.sql_text, sqlserver.username, sqlserver.client_hostname, sqlserver.plan_handle)
    WHERE (sqlserver.database_name = N''ConstelacionLibros'' AND duration > 3000000)
),
ADD EVENT sqlserver.error_reported (
    ACTION (sqlserver.sql_text, sqlserver.username, sqlserver.client_hostname, sqlserver.server_instance_name)
    WHERE (error_number = 18456 OR error_number = 229 OR error_number = 230)
),
ADD EVENT sqlserver.xml_deadlock_report (
    ACTION (sqlserver.database_name, sqlserver.server_instance_name)
),
ADD EVENT sqlserver.sql_batch_completed (
    ACTION (sqlserver.database_name, sqlserver.username, sqlserver.client_hostname)
    WHERE (sqlserver.database_name = N''ConstelacionLibros'' AND duration > 1000000)
)
ADD TARGET package0.event_file (
    SET filename = N''' + @ruta_xe + ''',
        max_file_size = 50,
        max_rollover_files = 5
),
ADD TARGET package0.ring_buffer (
    SET max_memory = 51200
)
WITH (MAX_DISPATCH_LATENCY = 30 SECONDS, TRACK_CAUSALITY = ON);
';

EXEC sp_executesql @sql_xe;
GO

ALTER EVENT SESSION [XE_ConstelacionLibros_Monitor] ON SERVER STATE = START;
GO

SELECT
    s.name          AS sesion,
    s.create_time,
    t.target_name   AS destino,
    t.execution_count AS eventos_capturados
FROM sys.dm_xe_sessions        s
JOIN sys.dm_xe_session_targets t ON s.address = t.event_session_address
WHERE s.name = 'XE_ConstelacionLibros_Monitor';
GO

-- ============================================================
-- TABLA Y PROCEDIMIENTO DE MONITOREO PROACTIVO
-- ============================================================

USE [ConstelacionLibros];
GO

IF OBJECT_ID('dbo.tbl_Monitoreo_BD', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[tbl_Monitoreo_BD] (
        [id_monitoreo]       INT            IDENTITY(1,1) PRIMARY KEY,
        [fecha_captura]      DATETIME2      NOT NULL DEFAULT SYSDATETIME(),
        [conexiones_activas] INT            NULL,
        [espacio_datos_mb]   DECIMAL(10,2)  NULL,
        [espacio_log_mb]     DECIMAL(10,2)  NULL,
        [pct_log_usado]      DECIMAL(5,2)   NULL,
        [prestamos_vencidos] INT            NULL,
        [deudas_activas]     INT            NULL,
        [observacion]        VARCHAR(300)   NULL
    );
END
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Monitoreo_Salud_BD]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
        @conexiones      INT,
        @espacio_datos   DECIMAL(10,2),
        @espacio_log     DECIMAL(10,2),
        @pct_log         DECIMAL(5,2),
        @prestamos_venc  INT,
        @deudas_activas  INT,
        @obs             VARCHAR(300) = '';

    SELECT @conexiones = COUNT(*)
    FROM sys.dm_exec_sessions
    WHERE database_id = DB_ID('ConstelacionLibros') AND is_user_process = 1;

    SELECT
        @espacio_datos = SUM(CASE WHEN type_desc = 'ROWS' THEN size * 8.0 / 1024 ELSE 0 END),
        @espacio_log   = SUM(CASE WHEN type_desc = 'LOG'  THEN size * 8.0 / 1024 ELSE 0 END)
    FROM sys.master_files
    WHERE database_id = DB_ID('ConstelacionLibros');

    SELECT @pct_log =
        CAST(FILEPROPERTY('ConstelacionLibros_log', 'SpaceUsed') AS FLOAT) /
        NULLIF(CAST(FILEPROPERTY('ConstelacionLibros_log', 'Size') AS FLOAT), 0) * 100;

    SELECT @prestamos_venc = COUNT(*) FROM [dbo].[vw_Prestamos_Vencidos];

    SELECT @deudas_activas = COUNT(*)
    FROM [dbo].[tbl_Deuda] WHERE estado = 1 AND saldo > 0;

    IF @prestamos_venc > 0
        SET @obs += 'ALERTA: ' + CAST(@prestamos_venc AS VARCHAR) + ' prestamos vencidos. ';
    IF ISNULL(@pct_log, 0) > 75
        SET @obs += 'ALERTA: Log al ' + CAST(ROUND(@pct_log,1) AS VARCHAR) + '%. ';
    IF @conexiones > 50
        SET @obs += 'ALERTA: ' + CAST(@conexiones AS VARCHAR) + ' conexiones activas. ';
    IF @obs = '' SET @obs = 'Sistema en estado normal.';

    INSERT INTO [dbo].[tbl_Monitoreo_BD]
        (conexiones_activas, espacio_datos_mb, espacio_log_mb,
         pct_log_usado, prestamos_vencidos, deudas_activas, observacion)
    VALUES
        (@conexiones, @espacio_datos, @espacio_log,
         @pct_log, @prestamos_venc, @deudas_activas, @obs);

    SELECT
        SYSDATETIME()    AS fecha_captura,
        @conexiones      AS conexiones_activas,
        @espacio_datos   AS espacio_datos_mb,
        @espacio_log     AS espacio_log_mb,
        @pct_log         AS pct_log_usado,
        @prestamos_venc  AS prestamos_vencidos,
        @deudas_activas  AS deudas_activas,
        @obs             AS observacion;
END;
GO

-- ============================================================
-- GENERACION AUTOMATICA DE MULTAS
-- ============================================================

CREATE OR ALTER PROCEDURE [dbo].[sp_Generar_Multas_Automaticas]
    @monto_por_dia DECIMAL(10,2) = 0.50
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @multas_generadas INT = 0;
    DECLARE @id_estado_abierta INT;

    SELECT TOP 1 @id_estado_abierta = id_estado
    FROM [dbo].[tbl_Estado_Multa]
    WHERE LOWER(nombre) LIKE '%abierta%' OR LOWER(nombre) LIKE '%pendiente%';

    IF @id_estado_abierta IS NULL SET @id_estado_abierta = 1;

    INSERT INTO [dbo].[tbl_Multa] (id_prestamo, id_estado, monto, motivo)
    SELECT
        P.id_prestamo,
        @id_estado_abierta,
        DATEDIFF(DAY, P.fecha_compromiso, CAST(GETDATE() AS DATE)) * @monto_por_dia,
        'Retraso de ' + CAST(DATEDIFF(DAY, P.fecha_compromiso,
            CAST(GETDATE() AS DATE)) AS VARCHAR) + ' dias en devolucion'
    FROM [dbo].[tbl_Prestamo] P
    WHERE P.estado = 1
      AND P.fecha_devolucion IS NULL
      AND P.fecha_compromiso < CAST(GETDATE() AS DATE)
      AND NOT EXISTS (
          SELECT 1 FROM [dbo].[tbl_Multa] M
          WHERE M.id_prestamo = P.id_prestamo
      );

    SET @multas_generadas = @@ROWCOUNT;

    INSERT INTO [dbo].[tbl_Auditoria]
        (tabla_afectada, operacion, usuario_bd, login_servidor, detalle)
    VALUES ('tbl_Multa','INSERT_AUTO', USER_NAME(), SUSER_SNAME(),
            'Multas automaticas generadas: ' + CAST(@multas_generadas AS VARCHAR));

    SELECT @multas_generadas AS multas_generadas;
END;
GO

-- ============================================================
-- SQL SERVER AGENT JOBS
-- ============================================================

USE [msdb];
GO

IF NOT EXISTS (SELECT 1 FROM msdb.dbo.sysjobs WHERE name = 'CL - Respaldo Completo Semanal')
BEGIN
    EXEC msdb.dbo.sp_add_job
        @job_name         = N'CL - Respaldo Completo Semanal',
        @description      = N'Respaldo FULL de ConstelacionLibros. Sabados 11:00 PM.',
        @category_name    = N'Database Maintenance',
        @owner_login_name = N'sa';

    EXEC msdb.dbo.sp_add_jobstep
        @job_name          = N'CL - Respaldo Completo Semanal',
        @step_name         = N'Ejecutar Respaldo FULL',
        @command           = N'EXEC master.dbo.sp_Ejecutar_Respaldo @tipo_respaldo = ''FULL'';',
        @database_name     = N'master',
        @on_success_action = 1,
        @on_fail_action    = 2;

    EXEC msdb.dbo.sp_add_schedule
        @schedule_name          = N'Sched_FullBackup_Sabado',
        @freq_type              = 8,      -- Semanal
        @freq_interval          = 64,     -- Sabado
        @freq_recurrence_factor = 1,      -- Cada 1 semana
        @freq_subday_type       = 1,      -- Una vez al dia
        @freq_subday_interval   = 0,
        @active_start_time      = 230000; -- 23:00

    EXEC msdb.dbo.sp_attach_schedule
        @job_name      = N'CL - Respaldo Completo Semanal',
        @schedule_name = N'Sched_FullBackup_Sabado';

    EXEC msdb.dbo.sp_add_jobserver @job_name = N'CL - Respaldo Completo Semanal';
END
GO

IF NOT EXISTS (SELECT 1 FROM msdb.dbo.sysjobs WHERE name = 'CL - Respaldo Diferencial')
BEGIN
    EXEC msdb.dbo.sp_add_job
        @job_name         = N'CL - Respaldo Diferencial',
        @description      = N'Respaldo DIFF. Mar/Jue/Sab/Dom 1:00 PM.',
        @category_name    = N'Database Maintenance',
        @owner_login_name = N'sa';

    EXEC msdb.dbo.sp_add_jobstep
        @job_name          = N'CL - Respaldo Diferencial',
        @step_name         = N'Ejecutar Respaldo DIFF',
        @command           = N'EXEC master.dbo.sp_Ejecutar_Respaldo @tipo_respaldo = ''DIFF'';',
        @database_name     = N'master',
        @on_success_action = 1,
        @on_fail_action    = 2;

    EXEC msdb.dbo.sp_add_schedule
        @schedule_name          = N'Sched_DiffBackup_MarJueSabDom',
        @freq_type              = 8,
        @freq_interval          = 85,     -- Dom(1) + Mar(4) + Jue(16) + Sab(64)
        @freq_recurrence_factor = 1,
        @freq_subday_type       = 1,
        @freq_subday_interval   = 0,
        @active_start_time      = 130000; -- 13:00

    EXEC msdb.dbo.sp_attach_schedule
        @job_name      = N'CL - Respaldo Diferencial',
        @schedule_name = N'Sched_DiffBackup_MarJueSabDom';

    EXEC msdb.dbo.sp_add_jobserver @job_name = N'CL - Respaldo Diferencial';
END
GO

IF NOT EXISTS (SELECT 1 FROM msdb.dbo.sysjobs WHERE name = 'CL - Respaldo Log Transacciones')
BEGIN
    EXEC msdb.dbo.sp_add_job
        @job_name         = N'CL - Respaldo Log Transacciones',
        @description      = N'Respaldo LOG diario. 9 AM, 1 PM y 5 PM.',
        @category_name    = N'Database Maintenance',
        @owner_login_name = N'sa';

    EXEC msdb.dbo.sp_add_jobstep
        @job_name          = N'CL - Respaldo Log Transacciones',
        @step_name         = N'Ejecutar Respaldo LOG',
        @command           = N'EXEC master.dbo.sp_Ejecutar_Respaldo @tipo_respaldo = ''LOG'';',
        @database_name     = N'master',
        @on_success_action = 1,
        @on_fail_action    = 2;

    EXEC msdb.dbo.sp_add_schedule
        @schedule_name          = N'Sched_LogBackup_3xDia',
        @freq_type              = 4,      -- Diario
        @freq_interval          = 1,
        @freq_recurrence_factor = 0,
        @freq_subday_type       = 8,      -- Cada N horas
        @freq_subday_interval   = 8,      -- Cada 8 horas
        @active_start_time      = 090000, -- Empieza 9:00 AM
        @active_end_time        = 170000; -- Termina 5:00 PM

    EXEC msdb.dbo.sp_attach_schedule
        @job_name      = N'CL - Respaldo Log Transacciones',
        @schedule_name = N'Sched_LogBackup_3xDia';

    EXEC msdb.dbo.sp_add_jobserver @job_name = N'CL - Respaldo Log Transacciones';
END
GO

IF NOT EXISTS (SELECT 1 FROM msdb.dbo.sysjobs WHERE name = 'CL - Mantenimiento de Indices')
BEGIN
    EXEC msdb.dbo.sp_add_job
        @job_name         = N'CL - Mantenimiento de Indices',
        @description      = N'Rebuild/Reorganize + estadisticas. Domingos 2:00 AM.',
        @category_name    = N'Database Maintenance',
        @owner_login_name = N'sa';

    EXEC msdb.dbo.sp_add_jobstep
        @job_name          = N'CL - Mantenimiento de Indices',
        @step_name         = N'Ejecutar Mantenimiento',
        @command           = N'USE ConstelacionLibros; EXEC dbo.sp_Mantenimiento_Indices;',
        @database_name     = N'ConstelacionLibros',
        @on_success_action = 1,
        @on_fail_action    = 2;

    EXEC msdb.dbo.sp_add_schedule
        @schedule_name          = N'Sched_Mantenimiento_Domingo',
        @freq_type              = 8,
        @freq_interval          = 1,      -- Domingo
        @freq_recurrence_factor = 1,      -- Cada 1 semana
        @freq_subday_type       = 1,
        @freq_subday_interval   = 0,
        @active_start_time      = 020000; -- 02:00 AM

    EXEC msdb.dbo.sp_attach_schedule
        @job_name      = N'CL - Mantenimiento de Indices',
        @schedule_name = N'Sched_Mantenimiento_Domingo';

    EXEC msdb.dbo.sp_add_jobserver @job_name = N'CL - Mantenimiento de Indices';
END
GO

IF NOT EXISTS (SELECT 1 FROM msdb.dbo.sysjobs WHERE name = 'CL - Generacion Multas Automaticas')
BEGIN
    EXEC msdb.dbo.sp_add_job
        @job_name         = N'CL - Generacion Multas Automaticas',
        @description      = N'Genera multas por prestamos vencidos. Diario 6:00 AM.',
        @category_name    = N'Database Maintenance',
        @owner_login_name = N'sa';

    EXEC msdb.dbo.sp_add_jobstep
        @job_name          = N'CL - Generacion Multas Automaticas',
        @step_name         = N'Generar Multas',
        @command           = N'USE ConstelacionLibros; EXEC dbo.sp_Generar_Multas_Automaticas;',
        @database_name     = N'ConstelacionLibros',
        @on_success_action = 1,
        @on_fail_action    = 2;

    EXEC msdb.dbo.sp_add_schedule
        @schedule_name          = N'Sched_Multas_Diario',
        @freq_type              = 4,
        @freq_interval          = 1,
        @freq_recurrence_factor = 0,
        @freq_subday_type       = 1,
        @freq_subday_interval   = 0,
        @active_start_time      = 060000; -- 06:00 AM

    EXEC msdb.dbo.sp_attach_schedule
        @job_name      = N'CL - Generacion Multas Automaticas',
        @schedule_name = N'Sched_Multas_Diario';

    EXEC msdb.dbo.sp_add_jobserver @job_name = N'CL - Generacion Multas Automaticas';
END
GO

IF NOT EXISTS (SELECT 1 FROM msdb.dbo.sysjobs WHERE name = 'CL - Monitoreo de Salud BD')
BEGIN
    EXEC msdb.dbo.sp_add_job
        @job_name         = N'CL - Monitoreo de Salud BD',
        @description      = N'Captura metricas de salud cada hora.',
        @category_name    = N'Database Maintenance',
        @owner_login_name = N'sa';

    EXEC msdb.dbo.sp_add_jobstep
        @job_name          = N'CL - Monitoreo de Salud BD',
        @step_name         = N'Capturar Metricas',
        @command           = N'USE ConstelacionLibros; EXEC dbo.sp_Monitoreo_Salud_BD;',
        @database_name     = N'ConstelacionLibros',
        @on_success_action = 1,
        @on_fail_action    = 2;

    EXEC msdb.dbo.sp_add_schedule
        @schedule_name          = N'Sched_Monitoreo_Horario',
        @freq_type              = 4,
        @freq_interval          = 1,
        @freq_recurrence_factor = 0,
        @freq_subday_type       = 8,      -- Cada N horas
        @freq_subday_interval   = 1,      -- Cada 1 hora
        @active_start_time      = 000000,
        @active_end_time        = 235959;

    EXEC msdb.dbo.sp_attach_schedule
        @job_name      = N'CL - Monitoreo de Salud BD',
        @schedule_name = N'Sched_Monitoreo_Horario';

    EXEC msdb.dbo.sp_add_jobserver @job_name = N'CL - Monitoreo de Salud BD';
END
GO

-- ============================================================
-- ALERTAS DE SQL SERVER AGENT
-- ============================================================

IF NOT EXISTS (SELECT 1 FROM msdb.dbo.sysalerts WHERE name = 'CL - Severidad 17 Recursos')
BEGIN
    EXEC msdb.dbo.sp_add_alert
        @name                        = N'CL - Severidad 17 Recursos',
        @severity                    = 17,
        @enabled                     = 1,
        @delay_between_responses     = 3600,
        @include_event_description_in= 1,
        @database_name               = N'ConstelacionLibros';
END
GO

IF NOT EXISTS (SELECT 1 FROM msdb.dbo.sysalerts WHERE name = 'CL - Error Fatal Severidad 19+')
BEGIN
    EXEC msdb.dbo.sp_add_alert
        @name                        = N'CL - Error Fatal Severidad 19+',
        @severity                    = 19,
        @enabled                     = 1,
        @delay_between_responses     = 60,
        @include_event_description_in= 1,
        @database_name               = N'ConstelacionLibros';
END
GO

-- ============================================================
-- CONSULTAS DE MONITOREO EN TIEMPO REAL
-- ============================================================

USE [ConstelacionLibros];
GO

SELECT
    s.session_id,
    s.login_name,
    s.host_name,
    s.program_name,
    s.status,
    s.cpu_time,
    s.total_elapsed_time / 1000 AS elapsed_seg,
    s.logical_reads,
    DB_NAME(s.database_id)      AS base_datos
FROM sys.dm_exec_sessions s
WHERE s.database_id = DB_ID('ConstelacionLibros')
  AND s.is_user_process = 1
ORDER BY s.total_elapsed_time DESC;
GO

SELECT
    r.session_id,
    r.status,
    r.blocking_session_id,
    r.wait_type,
    r.wait_time / 1000           AS espera_seg,
    r.total_elapsed_time / 1000  AS duracion_seg,
    SUBSTRING(qt.text,
        (r.statement_start_offset/2)+1,
        ((CASE r.statement_end_offset
            WHEN -1 THEN DATALENGTH(qt.text)
            ELSE r.statement_end_offset
          END - r.statement_start_offset)/2)+1) AS sql_actual
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) qt
WHERE r.blocking_session_id > 0;
GO

-- ============================================================
-- VERIFICACIONES
-- ============================================================

SELECT
    j.name                AS job_nombre,
    j.enabled             AS habilitado,
    s.name                AS schedule_nombre,
    CASE s.freq_type
        WHEN 4 THEN 'Diario'
        WHEN 8 THEN 'Semanal'
    END                   AS frecuencia,
    s.active_start_time   AS hora_HHMMSS
FROM msdb.dbo.sysjobs         j
JOIN msdb.dbo.sysjobschedules js ON j.job_id      = js.job_id
JOIN msdb.dbo.sysschedules    s  ON js.schedule_id = s.schedule_id
WHERE j.name LIKE 'CL -%'
ORDER BY j.name;
GO

SELECT
    s.name          AS sesion,
    s.create_time,
    t.target_name   AS destino,
    t.execution_count AS eventos_capturados
FROM sys.dm_xe_sessions        s
JOIN sys.dm_xe_session_targets t ON s.address = t.event_session_address
WHERE s.name = 'XE_ConstelacionLibros_Monitor';
GO
