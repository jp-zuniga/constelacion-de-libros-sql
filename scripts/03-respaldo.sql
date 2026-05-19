USE [master];
GO

-- ============================================================
-- MODO DE RECUPERACION
-- ============================================================

ALTER DATABASE [ConstelacionLibros] SET RECOVERY FULL;
GO

-- ============================================================
-- DIRECTORIOS DE RESPALDO
-- ============================================================

IF (SELECT host_platform FROM sys.dm_os_host_info) = 'Windows'
BEGIN
    EXEC sp_configure 'show advanced options', 1; RECONFIGURE;
    EXEC sp_configure 'xp_cmdshell', 1;           RECONFIGURE;

    EXEC xp_cmdshell 'mkdir "C:\Backups\ConstelacionLibros\Full" 2>nul & mkdir "C:\Backups\ConstelacionLibros\Diff" 2>nul & mkdir "C:\Backups\ConstelacionLibros\Log" 2>nul';

    EXEC sp_configure 'xp_cmdshell', 0;           RECONFIGURE;
    EXEC sp_configure 'show advanced options', 0; RECONFIGURE;
END
GO

-- ============================================================
-- RESPALDO COMPLETO
-- ============================================================

DECLARE @ruta_full  VARCHAR(300);
DECLARE @fecha_str  VARCHAR(20) = FORMAT(GETDATE(), 'yyyyMMdd_HHmmss');

IF (SELECT host_platform FROM sys.dm_os_host_info) = 'Linux'
    SET @ruta_full = '/var/opt/mssql/backups/ConstelacionLibros/Full/ConstelacionLibros_FULL_' + @fecha_str + '.bak';
ELSE
    SET @ruta_full = 'C:\Backups\ConstelacionLibros\Full\ConstelacionLibros_FULL_' + @fecha_str + '.bak';

BACKUP DATABASE [ConstelacionLibros]
    TO DISK = @ruta_full
    WITH FORMAT, INIT,
         NAME        = 'ConstelacionLibros - Respaldo Completo',
         DESCRIPTION = 'Respaldo completo semanal',
         COMPRESSION,
         CHECKSUM,
         STATS = 10;

-- ============================================================
-- RESPALDO DIFERENCIAL
-- ============================================================

DECLARE @ruta_diff  VARCHAR(300);
DECLARE @fecha_str2 VARCHAR(20) = FORMAT(GETDATE(), 'yyyyMMdd_HHmmss');

IF (SELECT host_platform FROM sys.dm_os_host_info) = 'Linux'
    SET @ruta_diff = '/var/opt/mssql/backups/ConstelacionLibros/Diff/ConstelacionLibros_DIFF_' + @fecha_str2 + '.bak';
ELSE
    SET @ruta_diff = 'C:\Backups\ConstelacionLibros\Diff\ConstelacionLibros_DIFF_' + @fecha_str2 + '.bak';

BACKUP DATABASE [ConstelacionLibros]
    TO DISK = @ruta_diff
    WITH DIFFERENTIAL,
         NAME        = 'ConstelacionLibros - Diferencial',
         DESCRIPTION = 'Respaldo diferencial',
         COMPRESSION,
         CHECKSUM,
         STATS = 10;

-- ============================================================
-- RESPALDO DE LOG
-- ============================================================

DECLARE @ruta_log   VARCHAR(300);
DECLARE @fecha_str3 VARCHAR(20) = FORMAT(GETDATE(), 'yyyyMMdd_HHmmss');

IF (SELECT host_platform FROM sys.dm_os_host_info) = 'Linux'
    SET @ruta_log = '/var/opt/mssql/backups/ConstelacionLibros/Log/ConstelacionLibros_LOG_' + @fecha_str3 + '.trn';
ELSE
    SET @ruta_log = 'C:\Backups\ConstelacionLibros\Log\ConstelacionLibros_LOG_' + @fecha_str3 + '.trn';

BACKUP LOG [ConstelacionLibros]
    TO DISK = @ruta_log
    WITH NAME        = 'ConstelacionLibros - Log',
         DESCRIPTION = 'Respaldo de log de transacciones',
         COMPRESSION,
         CHECKSUM,
         STATS = 10;

-- ============================================================
-- PROCEDIMIENTO AUTOMATICO DE RESPALDO
-- ============================================================

USE [master];
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Ejecutar_Respaldo]
    @tipo_respaldo VARCHAR(10),
    @ruta_base     VARCHAR(200) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF @ruta_base IS NULL
    BEGIN
        IF (SELECT host_platform FROM sys.dm_os_host_info) = 'Linux'
            SET @ruta_base = '/var/opt/mssql/backups/ConstelacionLibros/';
        ELSE
            SET @ruta_base = 'C:\Backups\ConstelacionLibros\';
    END

    DECLARE @sep CHAR(1) = IIF((SELECT host_platform FROM sys.dm_os_host_info) = 'Linux', '/', '\');
    DECLARE @ruta_archivo VARCHAR(300);
    DECLARE @nombre_arch  VARCHAR(200);
    DECLARE @fecha_str    VARCHAR(20);
    DECLARE @descripcion  VARCHAR(200);
    DECLARE @sql          NVARCHAR(MAX);

    SET @fecha_str = FORMAT(GETDATE(), 'yyyyMMdd_HHmmss');

    IF @tipo_respaldo = 'FULL'
    BEGIN
        SET @nombre_arch  = 'ConstelacionLibros_FULL_' + @fecha_str + '.bak';
        SET @ruta_archivo = @ruta_base + 'Full' + @sep + @nombre_arch;
        SET @descripcion  = 'Respaldo completo automatico';
        SET @sql = N'BACKUP DATABASE [ConstelacionLibros]
                     TO DISK = ''' + @ruta_archivo + '''
                     WITH FORMAT, INIT,
                          NAME = ''ConstelacionLibros FULL'',
                          DESCRIPTION = ''' + @descripcion + ''',
                          COMPRESSION, CHECKSUM, STATS = 10;';
    END
    ELSE IF @tipo_respaldo = 'DIFF'
    BEGIN
        SET @nombre_arch  = 'ConstelacionLibros_DIFF_' + @fecha_str + '.bak';
        SET @ruta_archivo = @ruta_base + 'Diff' + @sep + @nombre_arch;
        SET @descripcion  = 'Respaldo diferencial automatico';
        SET @sql = N'BACKUP DATABASE [ConstelacionLibros]
                     TO DISK = ''' + @ruta_archivo + '''
                     WITH DIFFERENTIAL,
                          NAME = ''ConstelacionLibros DIFF'',
                          DESCRIPTION = ''' + @descripcion + ''',
                          COMPRESSION, CHECKSUM, STATS = 10;';
    END
    ELSE IF @tipo_respaldo = 'LOG'
    BEGIN
        SET @nombre_arch  = 'ConstelacionLibros_LOG_' + @fecha_str + '.trn';
        SET @ruta_archivo = @ruta_base + 'Log' + @sep + @nombre_arch;
        SET @descripcion  = 'Respaldo de log automatico';
        SET @sql = N'BACKUP LOG [ConstelacionLibros]
                     TO DISK = ''' + @ruta_archivo + '''
                     WITH NAME = ''ConstelacionLibros LOG'',
                          DESCRIPTION = ''' + @descripcion + ''',
                          COMPRESSION, CHECKSUM, STATS = 10;';
    END
    ELSE
    BEGIN
        RAISERROR('Tipo invalido. Use: FULL, DIFF o LOG', 16, 1);
        RETURN;
    END

    BEGIN TRY
        EXEC sp_executesql @sql;

        INSERT INTO [ConstelacionLibros].[dbo].[tbl_Auditoria]
            (tabla_afectada, operacion, usuario_bd, login_servidor, detalle)
        VALUES ('SISTEMA', 'BACKUP_' + @tipo_respaldo, USER_NAME(), SUSER_SNAME(),
                'Respaldo ' + @tipo_respaldo + ' generado: ' + @nombre_arch);
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;
GO

-- ============================================================
-- PROCEDIMIENTO DE RESTAURACION
-- ============================================================

USE [master];
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Restaurar_ConstelacionLibros]
    @archivo_full VARCHAR(300),
    @archivo_diff VARCHAR(300) = NULL,
    @archivo_log  VARCHAR(300) = NULL,
    @modo_prueba  BIT          = 1      -- 1 = verifica; 0 = restaura
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @sql NVARCHAR(MAX);

    IF @modo_prueba = 1
    BEGIN
        SET @sql = N'RESTORE VERIFYONLY FROM DISK = ''' + @archivo_full + ''' WITH CHECKSUM;';
        EXEC sp_executesql @sql;

        IF @archivo_diff IS NOT NULL
        BEGIN
            SET @sql = N'RESTORE VERIFYONLY FROM DISK = ''' + @archivo_diff + ''' WITH CHECKSUM;';
            EXEC sp_executesql @sql;
        END

        IF @archivo_log IS NOT NULL
        BEGIN
            SET @sql = N'RESTORE VERIFYONLY FROM DISK = ''' + @archivo_log + ''' WITH CHECKSUM;';
            EXEC sp_executesql @sql;
        END

        RETURN;
    END

    SET @sql = N'ALTER DATABASE [ConstelacionLibros] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;';
    EXEC sp_executesql @sql;

    IF @archivo_diff IS NOT NULL OR @archivo_log IS NOT NULL
    BEGIN
        SET @sql = N'RESTORE DATABASE [ConstelacionLibros] FROM DISK = ''' + @archivo_full + '''
                     WITH NORECOVERY, REPLACE, CHECKSUM, STATS = 10;';
        EXEC sp_executesql @sql;
    END
    ELSE
    BEGIN
        SET @sql = N'RESTORE DATABASE [ConstelacionLibros] FROM DISK = ''' + @archivo_full + '''
                     WITH RECOVERY, REPLACE, CHECKSUM, STATS = 10;';
        EXEC sp_executesql @sql;
    END

    IF @archivo_diff IS NOT NULL
    BEGIN
        IF @archivo_log IS NOT NULL
            SET @sql = N'RESTORE DATABASE [ConstelacionLibros] FROM DISK = ''' + @archivo_diff + '''
                         WITH NORECOVERY, CHECKSUM, STATS = 10;';
        ELSE
            SET @sql = N'RESTORE DATABASE [ConstelacionLibros] FROM DISK = ''' + @archivo_diff + '''
                         WITH RECOVERY, CHECKSUM, STATS = 10;';

        EXEC sp_executesql @sql;
    END

    IF @archivo_log IS NOT NULL
    BEGIN
        SET @sql = N'RESTORE LOG [ConstelacionLibros] FROM DISK = ''' + @archivo_log + '''
                     WITH RECOVERY, CHECKSUM, STATS = 10;';
        EXEC sp_executesql @sql;
    END

    SET @sql = N'ALTER DATABASE [ConstelacionLibros] SET MULTI_USER;';
    EXEC sp_executesql @sql;
END;
GO

-- ============================================================
-- PROCEDIMIENTO DE LIMPIEZA DE RESPALDOS
-- ============================================================

USE [master];
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Limpiar_Respaldos_Antiguos]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @fecha_limite DATETIME = DATEADD(DAY, -30, GETDATE());

    EXEC [msdb].[dbo].[sp_delete_backuphistory]
        @oldest_date = @fecha_limite;

    INSERT INTO [ConstelacionLibros].[dbo].[tbl_Auditoria]
        (tabla_afectada, operacion, usuario_bd, login_servidor, detalle)
    VALUES ('SISTEMA','LIMPIEZA_BACKUP', USER_NAME(), SUSER_SNAME(),
            'Limpieza ejecutada. Fecha limite: ' + CONVERT(VARCHAR, @fecha_limite, 103));
END;
GO

-- ============================================================
-- VERIFICACIONES
-- ============================================================

SELECT name, recovery_model_desc, log_reuse_wait_desc, state_desc
FROM sys.databases
WHERE name = 'ConstelacionLibros';
GO

SELECT TOP 10
    CASE bs.type
        WHEN 'D' THEN 'FULL'
        WHEN 'I' THEN 'DIFFERENTIAL'
        WHEN 'L' THEN 'LOG'
        ELSE bs.type
    END                                                  AS tipo,
    bs.backup_start_date,
    bs.backup_finish_date,
    DATEDIFF(SECOND, bs.backup_start_date,
             bs.backup_finish_date)                      AS duracion_seg,
    ROUND(bs.compressed_backup_size / 1048576.0, 2)     AS tamano_mb,
    bmf.physical_device_name                             AS archivo
FROM [msdb].[dbo].[backupset]         bs
JOIN [msdb].[dbo].[backupmediafamily] bmf
    ON bs.media_set_id = bmf.media_set_id
WHERE bs.database_name = 'ConstelacionLibros'
ORDER BY bs.backup_start_date DESC;
GO
