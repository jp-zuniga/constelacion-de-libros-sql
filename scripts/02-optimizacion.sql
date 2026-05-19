USE [ConstelacionLibros];
GO

-- ============================================================
-- NUEVOS INDICES
-- ============================================================

IF NOT EXISTS (SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID('dbo.tbl_Prestamo') AND name = 'IX_Prestamo_Cliente_Estado')
BEGIN
    CREATE NONCLUSTERED INDEX [IX_Prestamo_Cliente_Estado]
    ON [dbo].[tbl_Prestamo] ([id_cliente] ASC, [estado] ASC)
    INCLUDE ([id_ejemplar], [fecha_salida], [fecha_compromiso], [fecha_devolucion]);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID('dbo.tbl_Ejemplar') AND name = 'IX_Ejemplar_EstadoLibro')
BEGIN
    CREATE NONCLUSTERED INDEX [IX_Ejemplar_EstadoLibro]
    ON [dbo].[tbl_Ejemplar] ([id_estado] ASC, [id_libro] ASC)
    INCLUDE ([codigo_barra], [id_ubicacion]);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID('dbo.tbl_Reserva') AND name = 'IX_Reserva_Cliente_Estado_Fecha')
BEGIN
    CREATE NONCLUSTERED INDEX [IX_Reserva_Cliente_Estado_Fecha]
    ON [dbo].[tbl_Reserva] ([id_cliente] ASC, [id_estado] ASC, [fecha_reserva] DESC)
    INCLUDE ([id_libro], [id_ejemplar]);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID('dbo.tbl_Deuda') AND name = 'IX_Deuda_Cliente_Estado')
BEGIN
    CREATE NONCLUSTERED INDEX [IX_Deuda_Cliente_Estado]
    ON [dbo].[tbl_Deuda] ([id_cliente] ASC, [estado] ASC)
    INCLUDE ([monto], [saldo], [fecha_emision]);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID('dbo.tbl_Multa') AND name = 'IX_Multa_Estado_Prestamo')
BEGIN
    CREATE NONCLUSTERED INDEX [IX_Multa_Estado_Prestamo]
    ON [dbo].[tbl_Multa] ([id_estado] ASC, [id_prestamo] ASC)
    INCLUDE ([monto], [motivo]);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID('dbo.tbl_Prestamo') AND name = 'IX_Prestamo_Compromiso_Devolucion')
BEGIN
    CREATE NONCLUSTERED INDEX [IX_Prestamo_Compromiso_Devolucion]
    ON [dbo].[tbl_Prestamo] ([fecha_compromiso] ASC, [fecha_devolucion] ASC, [estado] ASC)
    INCLUDE ([id_cliente], [id_ejemplar]);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID('dbo.tbl_Inventario') AND name = 'IX_Inventario_Libro_Tipo_Fecha')
BEGIN
    CREATE NONCLUSTERED INDEX [IX_Inventario_Libro_Tipo_Fecha]
    ON [dbo].[tbl_Inventario] ([id_libro] ASC, [id_tipo_mov] ASC, [fecha] DESC)
    INCLUDE ([cantidad], [observacion]);
END
GO

-- ============================================================
-- VISTAS OPTIMIZADAS
-- ============================================================

CREATE OR ALTER VIEW [dbo].[vw_Prestamos_Activos] AS
SELECT
    P.id_prestamo,
    C.identificacion                             AS CedulaCliente,
    C.nombres + ' ' + C.apellidos                AS NombreCliente,
    L.titulo                                     AS TituloLibro,
    E.codigo_barra                               AS CodigoEjemplar,
    P.fecha_salida                               AS FechaSalida,
    P.fecha_compromiso                           AS FechaLimite,
    DATEDIFF(DAY, GETDATE(), P.fecha_compromiso) AS DiasRestantes
FROM [dbo].[tbl_Prestamo] P
INNER JOIN [dbo].[tbl_Cliente]  C ON P.id_cliente  = C.id_cliente
INNER JOIN [dbo].[tbl_Ejemplar] E ON P.id_ejemplar = E.id_ejemplar
INNER JOIN [dbo].[tbl_Libro]    L ON E.id_libro    = L.id_libro
WHERE P.estado = 1 AND P.fecha_devolucion IS NULL;
GO

CREATE OR ALTER VIEW [dbo].[vw_Prestamos_Vencidos] AS
SELECT
    P.id_prestamo,
    C.identificacion                                     AS CedulaCliente,
    C.nombres + ' ' + C.apellidos                        AS NombreCliente,
    C.email                                              AS EmailCliente,
    L.titulo                                             AS TituloLibro,
    E.codigo_barra                                       AS CodigoEjemplar,
    P.fecha_salida                                       AS FechaSalida,
    P.fecha_compromiso                                   AS FechaLimite,
    DATEDIFF(DAY, P.fecha_compromiso, GETDATE())         AS DiasDeRetraso,
    DATEDIFF(DAY, P.fecha_compromiso, GETDATE()) * 0.50 AS MultaEstimada
FROM [dbo].[tbl_Prestamo] P
INNER JOIN [dbo].[tbl_Cliente]  C ON P.id_cliente  = C.id_cliente
INNER JOIN [dbo].[tbl_Ejemplar] E ON P.id_ejemplar = E.id_ejemplar
INNER JOIN [dbo].[tbl_Libro]    L ON E.id_libro    = L.id_libro
WHERE P.estado = 1
  AND P.fecha_devolucion IS NULL
  AND P.fecha_compromiso < CAST(GETDATE() AS DATE);
GO

CREATE OR ALTER VIEW [dbo].[vw_Stock_Por_Libro] AS
SELECT
    L.id_libro,
    L.titulo,
    COUNT(E.id_ejemplar)                                           AS total_ejemplares,
    SUM(CASE WHEN EE.nombre = 'Disponible' THEN 1 ELSE 0 END)    AS disponibles,
    SUM(CASE WHEN EE.nombre = 'Prestado'   THEN 1 ELSE 0 END)    AS prestados,
    SUM(CASE WHEN EE.nombre = 'Reparacion' THEN 1 ELSE 0 END)    AS en_reparacion,
    SUM(CASE WHEN EE.nombre NOT IN
        ('Disponible','Prestado','Reparacion') THEN 1 ELSE 0 END) AS otros_estados
FROM [dbo].[tbl_Libro] L
LEFT JOIN [dbo].[tbl_Ejemplar]        E  ON L.id_libro  = E.id_libro
LEFT JOIN [dbo].[tbl_Estado_Ejemplar] EE ON E.id_estado = EE.id_estado
WHERE L.estado = 1
GROUP BY L.id_libro, L.titulo;
GO

CREATE OR ALTER VIEW [dbo].[vw_Estado_Financiero_Cliente] AS
SELECT
    C.id_cliente,
    C.identificacion,
    C.nombres + ' ' + C.apellidos      AS nombre_completo,
    COUNT(DISTINCT D.id_deuda)         AS total_deudas,
    ISNULL(SUM(DISTINCT D.saldo), 0)  AS saldo_pendiente,
    COUNT(DISTINCT M.id_multa)         AS total_multas,
    MAX(PR.fecha_compromiso)           AS ultimo_vencimiento
FROM [dbo].[tbl_Cliente]  C
LEFT JOIN [dbo].[tbl_Deuda]    D  ON C.id_cliente   = D.id_cliente    AND D.estado = 1
LEFT JOIN [dbo].[tbl_Prestamo] PR ON C.id_cliente   = PR.id_cliente
LEFT JOIN [dbo].[tbl_Multa]    M  ON PR.id_prestamo = M.id_prestamo
GROUP BY C.id_cliente, C.identificacion, C.nombres, C.apellidos;
GO

-- ============================================================
-- CONFIGURACIONES
-- ============================================================

EXEC sp_configure 'show advanced options', 1;           RECONFIGURE;
EXEC sp_configure 'optimize for ad hoc workloads', 1;  RECONFIGURE;
EXEC sp_configure 'fill factor (%)', 85;               RECONFIGURE;
EXEC sp_configure 'show advanced options', 0;           RECONFIGURE;
GO

-- ============================================================
-- PROCEDIMIENTO DE MANTENIMIENTO PREVENTIVO
-- ============================================================

CREATE OR ALTER PROCEDURE [dbo].[sp_Mantenimiento_Indices]
    @umbral_reorganizar FLOAT = 10.0,
    @umbral_reconstruir FLOAT = 30.0
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @tabla  SYSNAME;
    DECLARE @indice SYSNAME;
    DECLARE @frag   FLOAT;
    DECLARE @sql    NVARCHAR(MAX);
    DECLARE @msg    VARCHAR(300);

    INSERT INTO [dbo].[tbl_Auditoria]
        (tabla_afectada, operacion, usuario_bd, login_servidor, detalle)
    VALUES ('SISTEMA','MANTENIMIENTO', USER_NAME(), SUSER_SNAME(),
            'Inicio mantenimiento de indices');

    DECLARE cur_indices CURSOR FOR
    SELECT
        OBJECT_NAME(ips.object_id),
        i.name,
        ips.avg_fragmentation_in_percent
    FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') ips
    JOIN sys.indexes i
        ON ips.object_id = i.object_id AND ips.index_id = i.index_id
    WHERE ips.page_count > 100
      AND i.name IS NOT NULL
      AND OBJECTPROPERTY(ips.object_id, 'IsUserTable') = 1
      AND ips.avg_fragmentation_in_percent > @umbral_reorganizar;

    OPEN cur_indices;
    FETCH NEXT FROM cur_indices INTO @tabla, @indice, @frag;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF @frag >= @umbral_reconstruir
        BEGIN
            SET @sql = N'ALTER INDEX [' + @indice + N'] ON [dbo].['
                     + @tabla + N'] REBUILD WITH (ONLINE = OFF, FILLFACTOR = 85)';
            SET @msg = 'REBUILD ' + @indice + ' (' + CAST(ROUND(@frag,1) AS VARCHAR) + '%)';
        END
        ELSE
        BEGIN
            SET @sql = N'ALTER INDEX [' + @indice + N'] ON [dbo].['
                     + @tabla + N'] REORGANIZE';
            SET @msg = 'REORGANIZE ' + @indice + ' (' + CAST(ROUND(@frag,1) AS VARCHAR) + '%)';
        END

        BEGIN TRY
            EXEC sp_executesql @sql;
            INSERT INTO [dbo].[tbl_Auditoria]
                (tabla_afectada, operacion, usuario_bd, login_servidor, detalle)
            VALUES (@tabla,'MANTENIMIENTO', USER_NAME(), SUSER_SNAME(), @msg);
        END TRY
        BEGIN CATCH
            INSERT INTO [dbo].[tbl_Auditoria]
                (tabla_afectada, operacion, usuario_bd, login_servidor, detalle)
            VALUES (@tabla,'ERROR', USER_NAME(), SUSER_SNAME(),
                    'Error en ' + @indice + ': ' + ERROR_MESSAGE());
        END CATCH

        FETCH NEXT FROM cur_indices INTO @tabla, @indice, @frag;
    END

    CLOSE cur_indices;
    DEALLOCATE cur_indices;

    EXEC sp_updatestats;

    INSERT INTO [dbo].[tbl_Auditoria]
        (tabla_afectada, operacion, usuario_bd, login_servidor, detalle)
    VALUES ('SISTEMA','MANTENIMIENTO', USER_NAME(), SUSER_SNAME(),
            'Mantenimiento de indices completado');
END;
GO

-- ============================================================
-- VERIFICACIONES
-- ============================================================

SELECT name, value_in_use, description
FROM sys.configurations
WHERE name IN ('optimize for ad hoc workloads', 'fill factor (%)');
GO

SELECT name, is_auto_update_stats_on
FROM sys.databases WHERE name = 'ConstelacionLibros';
GO

SELECT
    OBJECT_NAME(i.object_id) AS tabla,
    i.name                    AS indice,
    i.type_desc,
    i.fill_factor
FROM sys.indexes i
WHERE OBJECTPROPERTY(i.object_id, 'IsUserTable') = 1
  AND i.name IS NOT NULL
ORDER BY OBJECT_NAME(i.object_id), i.name;
GO

SELECT 'vw_Prestamos_Activos'         AS vista, COUNT(*) AS registros FROM [dbo].[vw_Prestamos_Activos]
UNION ALL SELECT 'vw_Prestamos_Vencidos',       COUNT(*) FROM [dbo].[vw_Prestamos_Vencidos]
UNION ALL SELECT 'vw_Stock_Por_Libro',          COUNT(*) FROM [dbo].[vw_Stock_Por_Libro]
UNION ALL SELECT 'vw_Estado_Financiero_Cliente',COUNT(*) FROM [dbo].[vw_Estado_Financiero_Cliente];
GO
