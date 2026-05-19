USE [master]
GO

CREATE DATABASE [ConstelacionLibros] CONTAINMENT = NONE
    WITH CATALOG_COLLATION = DATABASE_DEFAULT,
        LEDGER = OFF
GO

ALTER DATABASE [ConstelacionLibros]
SET COMPATIBILITY_LEVEL = 160
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
BEGIN
    EXEC [ConstelacionLibros].[dbo].[sp_fulltext_database] @action = 'enable'
END
GO

ALTER DATABASE [ConstelacionLibros]
SET ANSI_NULL_DEFAULT OFF
GO

ALTER DATABASE [ConstelacionLibros]
SET ANSI_NULLS OFF
GO

ALTER DATABASE [ConstelacionLibros]
SET ANSI_PADDING OFF
GO

ALTER DATABASE [ConstelacionLibros]
SET ANSI_WARNINGS OFF
GO

ALTER DATABASE [ConstelacionLibros]
SET ARITHABORT OFF
GO

ALTER DATABASE [ConstelacionLibros]
SET AUTO_CLOSE OFF
GO

ALTER DATABASE [ConstelacionLibros]
SET AUTO_SHRINK OFF
GO

ALTER DATABASE [ConstelacionLibros]
SET AUTO_UPDATE_STATISTICS ON
GO

ALTER DATABASE [ConstelacionLibros]
SET CURSOR_CLOSE_ON_COMMIT OFF
GO

ALTER DATABASE [ConstelacionLibros]
SET CURSOR_DEFAULT GLOBAL
GO

ALTER DATABASE [ConstelacionLibros]
SET CONCAT_NULL_YIELDS_NULL OFF
GO

ALTER DATABASE [ConstelacionLibros]
SET NUMERIC_ROUNDABORT OFF
GO

ALTER DATABASE [ConstelacionLibros]
SET QUOTED_IDENTIFIER OFF
GO

ALTER DATABASE [ConstelacionLibros]
SET RECURSIVE_TRIGGERS OFF
GO

ALTER DATABASE [ConstelacionLibros]
SET ENABLE_BROKER
GO

ALTER DATABASE [ConstelacionLibros]
SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO

ALTER DATABASE [ConstelacionLibros]
SET DATE_CORRELATION_OPTIMIZATION OFF
GO

ALTER DATABASE [ConstelacionLibros]
SET TRUSTWORTHY OFF
GO

ALTER DATABASE [ConstelacionLibros]
SET ALLOW_SNAPSHOT_ISOLATION OFF
GO

ALTER DATABASE [ConstelacionLibros]
SET PARAMETERIZATION SIMPLE
GO

ALTER DATABASE [ConstelacionLibros]
SET READ_COMMITTED_SNAPSHOT OFF
GO

ALTER DATABASE [ConstelacionLibros]
SET HONOR_BROKER_PRIORITY OFF
GO

ALTER DATABASE [ConstelacionLibros]
SET RECOVERY FULL
GO

ALTER DATABASE [ConstelacionLibros]
SET MULTI_USER
GO

ALTER DATABASE [ConstelacionLibros]
SET PAGE_VERIFY CHECKSUM
GO

ALTER DATABASE [ConstelacionLibros]
SET DB_CHAINING OFF
GO

ALTER DATABASE [ConstelacionLibros]
SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF)
GO

ALTER DATABASE [ConstelacionLibros]
SET TARGET_RECOVERY_TIME = 60 SECONDS
GO

ALTER DATABASE [ConstelacionLibros]
SET DELAYED_DURABILITY = DISABLED
GO

ALTER DATABASE [ConstelacionLibros]
SET ACCELERATED_DATABASE_RECOVERY = OFF
GO

EXEC sys.sp_db_vardecimal_storage_format
    N'ConstelacionLibros',
    N'ON'
GO

ALTER DATABASE [ConstelacionLibros]
SET QUERY_STORE = ON
GO

ALTER DATABASE [ConstelacionLibros]
SET QUERY_STORE(
    OPERATION_MODE = READ_WRITE,
    CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30),
    DATA_FLUSH_INTERVAL_SECONDS = 900,
    INTERVAL_LENGTH_MINUTES = 60,
    MAX_STORAGE_SIZE_MB = 1000,
    QUERY_CAPTURE_MODE = AUTO,
    SIZE_BASED_CLEANUP_MODE = AUTO,
    MAX_PLANS_PER_QUERY = 200,
    WAIT_STATS_CAPTURE_MODE = ON
)
GO

USE [ConstelacionLibros]
GO

CREATE SEQUENCE [dbo].[sq_Autor_ID] AS [int] START
    WITH 1 INCREMENT
    BY 1
    MINVALUE -2147483648
    MAXVALUE 2147483647
    CACHE
GO

CREATE SEQUENCE [dbo].[sq_Categoria_ID] AS [int] START
    WITH 1 INCREMENT
    BY 1
    MINVALUE -2147483648
    MAXVALUE 2147483647
    CACHE
GO

CREATE SEQUENCE [dbo].[sq_Cliente_ID] AS [int] START
    WITH 102 INCREMENT
    BY 1
    MINVALUE -2147483648
    MAXVALUE 2147483647
    CACHE
GO

CREATE SEQUENCE [dbo].[sq_Columna_ID] AS [int] START
    WITH 900 INCREMENT
    BY 1
    MINVALUE -2147483648
    MAXVALUE 2147483647
    CACHE
GO

CREATE SEQUENCE [dbo].[sq_Deuda_ID] AS [int] START
    WITH 48 INCREMENT
    BY 1
    MINVALUE -2147483648
    MAXVALUE 2147483647
    CACHE
GO

CREATE SEQUENCE [dbo].[sq_Editorial_ID] AS [int] START
    WITH 1 INCREMENT
    BY 1
    MINVALUE -2147483648
    MAXVALUE 2147483647
    CACHE
GO

CREATE SEQUENCE [dbo].[sq_Ejemplar_ID] AS [int] START
    WITH 2954 INCREMENT
    BY 1
    MINVALUE -2147483648
    MAXVALUE 2147483647
    CACHE
GO

CREATE SEQUENCE [dbo].[sq_Empleado_ID] AS [int] START
    WITH 11 INCREMENT
    BY 1
    MINVALUE -2147483648
    MAXVALUE 2147483647
    CACHE
GO

CREATE SEQUENCE [dbo].[sq_Estado_Ejemplar_ID] AS [int] START
    WITH 6 INCREMENT BY 1 MINVALUE - 2147483648 MAXVALUE 2147483647 CACHE
GO

CREATE SEQUENCE [dbo].[sq_Estado_Multa_ID] AS [int] START
    WITH 6 INCREMENT
    BY 1
    MINVALUE -2147483648
    MAXVALUE 2147483647
    CACHE
GO

CREATE SEQUENCE [dbo].[sq_Estado_Reserva_ID] AS [int] START
    WITH 6 INCREMENT
    BY 1
    MINVALUE -2147483648
    MAXVALUE 2147483647
    CACHE
GO

CREATE SEQUENCE [dbo].[sq_Estante_ID] AS [int] START
    WITH 151 INCREMENT
    BY 1
    MINVALUE -2147483648
    MAXVALUE 2147483647
    CACHE
GO

CREATE SEQUENCE [dbo].[sq_Fila_ID] AS [int] START
    WITH 899 INCREMENT
    BY 1
    MINVALUE -2147483648
    MAXVALUE 2147483647
    CACHE
GO

CREATE SEQUENCE [dbo].[sq_Inventario_ID] AS [int] START
    WITH 1 INCREMENT
    BY 1
    MINVALUE -2147483648
    MAXVALUE 2147483647
    CACHE
GO

CREATE SEQUENCE [dbo].[sq_Libro_ID] AS [int] START
    WITH 1003 INCREMENT
    BY 1
    MINVALUE -2147483648
    MAXVALUE 2147483647
    CACHE
GO

CREATE SEQUENCE [dbo].[sq_Metodo_Pago_ID] AS [int] START
    WITH 4 INCREMENT
    BY 1
    MINVALUE -2147483648
    MAXVALUE 2147483647
    CACHE
GO

CREATE SEQUENCE [dbo].[sq_Multa_ID] AS [int] START
    WITH 44 INCREMENT
    BY 1
    MINVALUE -2147483648
    MAXVALUE 2147483647
    CACHE
GO

CREATE SEQUENCE [dbo].[sq_Pago_Aplicacion_ID] AS [int] START
    WITH 16 INCREMENT
    BY 1
    MINVALUE -2147483648
    MAXVALUE 2147483647
    CACHE
GO

CREATE SEQUENCE [dbo].[sq_Pago_Detalle_ID] AS [int] START
    WITH 17 INCREMENT
    BY 1
    MINVALUE -2147483648
    MAXVALUE 2147483647
    CACHE
GO

CREATE SEQUENCE [dbo].[sq_Pago_ID] AS [int] START
    WITH 16 INCREMENT
    BY 1
    MINVALUE -2147483648
    MAXVALUE 2147483647
    CACHE
GO

CREATE SEQUENCE [dbo].[sq_Prestamo_ID] AS [int] START
    WITH 209 INCREMENT
    BY 1
    MINVALUE -2147483648
    MAXVALUE 2147483647
    CACHE
GO

CREATE SEQUENCE [dbo].[sq_Reserva_ID] AS [int] START
    WITH 199 INCREMENT
    BY 1
    MINVALUE -2147483648
    MAXVALUE 2147483647
    CACHE
GO

CREATE SEQUENCE [dbo].[sq_Tipo_Movimiento_ID] AS [int] START
    WITH 4 INCREMENT
    BY 1
    MINVALUE -2147483648
    MAXVALUE 2147483647
    CACHE
GO

CREATE SEQUENCE [dbo].[sq_Ubicacion_ID] AS [int] START
    WITH 3000 INCREMENT
    BY 1
    MINVALUE -2147483648
    MAXVALUE 2147483647
    CACHE
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_Cliente] (
    [id_cliente] [int] NOT NULL,
    [identificacion] [varchar](30) NOT NULL,
    [nombres] [varchar](80) NOT NULL,
    [apellidos] [varchar](80) NOT NULL,
    [email] [varchar](120) NOT NULL,
    [telefono] [varchar](20) NULL,
    [estado] [bit] NOT NULL,
    CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED ([id_cliente] ASC) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY],
        CONSTRAINT [UNQ_cliente_email] UNIQUE NONCLUSTERED ([email] ASC) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY],
        CONSTRAINT [UNQ_cliente_identificacion] UNIQUE NONCLUSTERED (
            [identificacion] ASC,
            [nombres] ASC,
            [apellidos] ASC
            ) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_Ejemplar] (
    [id_ejemplar] [int] NOT NULL,
    [id_libro] [int] NOT NULL,
    [id_ubicacion] [int] NOT NULL,
    [id_estado] [int] NOT NULL,
    [codigo_barra] [varchar](40) NOT NULL,
    CONSTRAINT [PK_Ejemplar] PRIMARY KEY CLUSTERED ([id_ejemplar] ASC) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY],
        CONSTRAINT [UNQ_ejemplar_codigo] UNIQUE NONCLUSTERED ([codigo_barra] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_Libro] (
    [id_libro] [int] NOT NULL,
    [id_categoria] [int] NOT NULL,
    [id_editorial] [int] NOT NULL,
    [titulo] [varchar](200) NOT NULL,
    [isbn] [varchar](50) NOT NULL,
    [anio_publicacion] [int] NOT NULL,
    [estado] [bit] NOT NULL,
    CONSTRAINT [PK_Libro] PRIMARY KEY CLUSTERED ([id_libro] ASC) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY],
        CONSTRAINT [UNQ_libro_isbn] UNIQUE NONCLUSTERED ([isbn] ASC) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_Prestamo] (
    [id_prestamo] [int] NOT NULL,
    [id_ejemplar] [int] NOT NULL,
    [id_empleado] [int] NOT NULL,
    [id_cliente] [int] NOT NULL,
    [fecha_salida] [date] NOT NULL,
    [fecha_compromiso] [date] NOT NULL,
    [fecha_devolucion] [date] NULL,
    [estado] [bit] NOT NULL,
    CONSTRAINT [PK_Prestamo] PRIMARY KEY CLUSTERED ([id_prestamo] ASC) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_Prestamos_Activos]
AS
SELECT P.id_prestamo AS NumeroPrestamo,
    C.identificacion AS CedulaCliente,
    C.nombres + ' ' + C.apellidos AS NombreCliente,
    L.titulo AS TituloLibro,
    E.codigo_barra AS CodigoEjemplar,
    P.fecha_salida AS FechaSalida,
    P.fecha_compromiso AS FechaLimite,
    DATEDIFF(DAY, GETDATE(), P.fecha_compromiso) AS DiasRestantes
FROM tbl_Prestamo P
INNER JOIN tbl_Cliente C
    ON P.id_cliente = C.id_cliente
INNER JOIN tbl_Ejemplar E
    ON P.id_ejemplar = E.id_ejemplar
INNER JOIN tbl_Libro L
    ON E.id_libro = L.id_libro
WHERE P.estado = 1
    AND P.fecha_devolucion IS NULL;
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_Autor] (
    [id_autor] [int] NOT NULL,
    [nombres] [varchar](80) NOT NULL,
    [apellidos] [varchar](80) NOT NULL,
    [estado] [bit] NOT NULL,
    CONSTRAINT [PK_Autor] PRIMARY KEY CLUSTERED ([id_autor] ASC) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_Categoria] (
    [id_categoria] [int] NOT NULL,
    [nombre] [varchar](60) NOT NULL,
    [estado] [bit] NOT NULL,
    CONSTRAINT [PK_Categoria] PRIMARY KEY CLUSTERED ([id_categoria] ASC) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY],
        CONSTRAINT [UNQ_categoria_nombre] UNIQUE NONCLUSTERED ([nombre] ASC) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_Columna] (
    [id_columna] [int] NOT NULL,
    [id_fila] [int] NOT NULL,
    [numero] [int] NOT NULL,
    [estado] [bit] NOT NULL,
    CONSTRAINT [PK_Columna] PRIMARY KEY CLUSTERED ([id_columna] ASC) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY],
        CONSTRAINT [UNQ_columna_ubicacion] UNIQUE NONCLUSTERED (
            [id_fila] ASC,
            [numero] ASC
            ) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_Deuda] (
    [id_deuda] [int] NOT NULL,
    [id_cliente] [int] NOT NULL,
    [concepto] [varchar](50) NOT NULL,
    [monto] [decimal](10, 2) NOT NULL,
    [saldo] [decimal](10, 2) NOT NULL,
    [fecha_emision] [date] NOT NULL,
    [estado] [bit] NOT NULL,
    CONSTRAINT [PK_Deuda] PRIMARY KEY CLUSTERED ([id_deuda] ASC) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_Editorial] (
    [id_editorial] [int] NOT NULL,
    [nombre] [varchar](100) NOT NULL,
    [estado] [bit] NOT NULL,
    CONSTRAINT [PK_Editorial] PRIMARY KEY CLUSTERED ([id_editorial] ASC) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY],
        CONSTRAINT [UNQ_editorial_nombre] UNIQUE NONCLUSTERED ([nombre] ASC) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_Empleado] (
    [id_empleado] [int] NOT NULL,
    [nombres] [varchar](80) NOT NULL,
    [apellidos] [varchar](80) NOT NULL,
    [email] [varchar](120) NOT NULL,
    [telefono] [varchar](20) NULL,
    [estado] [bit] NOT NULL,
    CONSTRAINT [PK_Empleado] PRIMARY KEY CLUSTERED ([id_empleado] ASC) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY],
        CONSTRAINT [UNQ_empleado_email] UNIQUE NONCLUSTERED ([email] ASC) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_Estado_Ejemplar] (
    [id_estado] [int] NOT NULL,
    [nombre] [varchar](30) NOT NULL,
    [descripcion] [varchar](120) NULL,
    [activo] [bit] NOT NULL,
    CONSTRAINT [PK_Estado_Ejemplar] PRIMARY KEY CLUSTERED ([id_estado] ASC) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY],
        CONSTRAINT [UNQ_estado_ejemplar_nombre] UNIQUE NONCLUSTERED ([nombre] ASC
            ) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_Estado_Multa] (
    [id_estado] [int] NOT NULL,
    [nombre] [varchar](50) NOT NULL,
    [descripcion] [varchar](120) NULL,
    [activo] [bit] NOT NULL,
    CONSTRAINT [PK_Estado_Multa] PRIMARY KEY CLUSTERED ([id_estado] ASC) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY],
        CONSTRAINT [UNQ_estado_multa_nombre] UNIQUE NONCLUSTERED ([nombre] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_Estado_Reserva] (
    [id_estado] [int] NOT NULL,
    [nombre] [varchar](30) NOT NULL,
    [descripcion] [varchar](120) NULL,
    [activo] [bit] NOT NULL,
    CONSTRAINT [PK_Estado_Reserva] PRIMARY KEY CLUSTERED ([id_estado] ASC) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY],
        CONSTRAINT [UNQ_estado_reserva_nombre] UNIQUE NONCLUSTERED ([nombre] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_Estante] (
    [id_estante] [int] NOT NULL,
    [nombre] [varchar](50) NOT NULL,
    [sala] [varchar](50) NOT NULL,
    [seccion] [varchar](50) NOT NULL,
    [estado] [bit] NOT NULL,
    CONSTRAINT [PK_Estante] PRIMARY KEY CLUSTERED ([id_estante] ASC) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY],
        CONSTRAINT [UNQ_estante_ubicacion] UNIQUE NONCLUSTERED (
            [nombre] ASC,
            [sala] ASC,
            [seccion] ASC
            ) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_Fila] (
    [id_fila] [int] NOT NULL,
    [id_estante] [int] NOT NULL,
    [numero] [int] NOT NULL,
    [estado] [bit] NOT NULL,
    CONSTRAINT [PK_Fila] PRIMARY KEY CLUSTERED ([id_fila] ASC) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY],
        CONSTRAINT [UNQ_fila_ubicacion] UNIQUE NONCLUSTERED (
            [id_estante] ASC,
            [numero] ASC
            ) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_Inventario] (
    [id_movimiento] [int] NOT NULL,
    [id_libro] [int] NULL,
    [id_ejemplar] [int] NULL,
    [id_tipo_mov] [int] NOT NULL,
    [cantidad] [int] NOT NULL,
    [fecha] [datetime] NOT NULL,
    [observacion] [varchar](200) NULL,
    CONSTRAINT [PK_Inventario] PRIMARY KEY CLUSTERED ([id_movimiento] ASC) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_Libro_Autor] (
    [id_libro] [int] NOT NULL,
    [id_autor] [int] NOT NULL,
    CONSTRAINT [PK_Libro_Autor] PRIMARY KEY CLUSTERED (
        [id_libro] ASC,
        [id_autor] ASC
        ) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_Metodo_Pago] (
    [id_metodo_pago] [int] NOT NULL,
    [nombre] [varchar](100) NOT NULL,
    [descripcion] [varchar](200) NULL,
    [activo] [bit] NOT NULL,
    CONSTRAINT [PK_Metodo_Pago] PRIMARY KEY CLUSTERED ([id_metodo_pago] ASC) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY],
        CONSTRAINT [UNQ_metodo_pago_nombre] UNIQUE NONCLUSTERED ([nombre] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_Multa] (
    [id_multa] [int] NOT NULL,
    [id_prestamo] [int] NOT NULL,
    [id_estado] [int] NOT NULL,
    [monto] [decimal](10, 2) NOT NULL,
    [motivo] [varchar](100) NOT NULL,
    CONSTRAINT [PK_Multa] PRIMARY KEY CLUSTERED ([id_multa] ASC) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_Pago] (
    [id_pago] [int] NOT NULL,
    [id_cliente] [int] NOT NULL,
    [id_metodo_pago] [int] NOT NULL,
    [fecha_pago] [date] NOT NULL,
    [monto_total] [decimal](10, 2) NOT NULL,
    [referencia_externa] [varchar](60) NOT NULL,
    [estado] [bit] NOT NULL,
    CONSTRAINT [PK_Pago] PRIMARY KEY CLUSTERED ([id_pago] ASC) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_Pago_Aplicacion] (
    [id_aplicacion] [int] NOT NULL,
    [id_pago] [int] NOT NULL,
    [id_deuda] [int] NOT NULL,
    [monto_aplicado] [decimal](10, 2) NOT NULL,
    [fecha_aplicacion] [date] NOT NULL,
    [observacion] [varchar](200) NULL,
    CONSTRAINT [PK_Pago_Aplicacion] PRIMARY KEY CLUSTERED ([id_aplicacion] ASC) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_Pago_Detalle] (
    [id_pago_detalle] [int] NOT NULL,
    [id_pago] [int] NOT NULL,
    [id_metodo_pago] [int] NOT NULL,
    [monto] [decimal](10, 2) NOT NULL,
    [referencia] [varchar](60) NOT NULL,
    CONSTRAINT [PK_Pago_Detalle] PRIMARY KEY CLUSTERED ([id_pago_detalle] ASC) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_Reserva] (
    [id_reserva] [int] NOT NULL,
    [id_cliente] [int] NOT NULL,
    [id_libro] [int] NULL,
    [id_ejemplar] [int] NULL,
    [id_estado] [int] NOT NULL,
    [fecha_reserva] [date] NOT NULL,
    CONSTRAINT [PK_Reserva] PRIMARY KEY CLUSTERED ([id_reserva] ASC) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_Tipo_Movimiento] (
    [id_tipo_mov] [int] NOT NULL,
    [nombre] [varchar](30) NOT NULL,
    [signo] [bit] NOT NULL,
    [descripcion] [varchar](120) NULL,
    [activo] [bit] NOT NULL,
    CONSTRAINT [PK_Tipo_Movimiento] PRIMARY KEY CLUSTERED ([id_tipo_mov] ASC) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY],
        CONSTRAINT [UNQ_tipo_movimiento_nombre] UNIQUE NONCLUSTERED ([nombre] ASC
            ) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbl_Ubicacion] (
    [id_ubicacion] [int] NOT NULL,
    [id_columna] [int] NOT NULL,
    [observacion] [varchar](200) NULL,
    CONSTRAINT [PK_Ubicacion] PRIMARY KEY CLUSTERED ([id_ubicacion] ASC) WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        IGNORE_DUP_KEY = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    )
    ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_PADDING ON
GO

CREATE NONCLUSTERED INDEX [IX_tblCliente_Identificacion]
    ON [dbo].[tbl_Cliente] ([identificacion] ASC)
    INCLUDE ([nombres], [apellidos])
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IXFK_Columna_Fila]
    ON [dbo].[tbl_Columna] ([id_fila] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IXFK_Deuda_Cliente]
    ON [dbo].[tbl_Deuda] ([id_cliente] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IXFK_Ejemplar_Estado_Ejemplar]
    ON [dbo].[tbl_Ejemplar] ([id_estado] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IXFK_Ejemplar_Ubicacion]
    ON [dbo].[tbl_Ejemplar] ([id_ubicacion] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IXFK_Fila_Estante]
    ON [dbo].[tbl_Fila] ([id_estante] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IXFK_Inventario_Ejemplar]
    ON [dbo].[tbl_Inventario] ([id_ejemplar] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IXFK_Inventario_Libro]
    ON [dbo].[tbl_Inventario] ([id_libro] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IXFK_Inventario_Tipo_Movimiento]
    ON [dbo].[tbl_Inventario] ([id_tipo_mov] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
GO

SET ANSI_PADDING ON
GO

CREATE NONCLUSTERED INDEX [IX_tblLibros_Titulo]
    ON [dbo].[tbl_Libro] ([titulo] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IXFK_Libro_Categoria]
    ON [dbo].[tbl_Libro] ([id_categoria] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IXFK_Libro_Editorial]
    ON [dbo].[tbl_Libro] ([id_editorial] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IXFK_Libro_Autor_Autor]
    ON [dbo].[tbl_Libro_Autor] ([id_autor] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IXFK_Libro_Autor_Libro]
    ON [dbo].[tbl_Libro_Autor] ([id_libro] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IXFK_Multa_Estado_Multa]
    ON [dbo].[tbl_Multa] ([id_estado] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IXFK_Multa_Prestamo]
    ON [dbo].[tbl_Multa] ([id_prestamo] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IXFK_Pago_Cliente]
    ON [dbo].[tbl_Pago] ([id_cliente] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IXFK_Pago_Metodo_Pago]
    ON [dbo].[tbl_Pago] ([id_metodo_pago] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IXFK_Pago_Aplicacion_Deuda]
    ON [dbo].[tbl_Pago_Aplicacion] ([id_deuda] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IXFK_Pago_Aplicacion_Pago]
    ON [dbo].[tbl_Pago_Aplicacion] ([id_pago] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IXFK_Pago_Detalle_Metodo_Pago]
    ON [dbo].[tbl_Pago_Detalle] ([id_metodo_pago] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IXFK_Pago_Detalle_Pago]
    ON [dbo].[tbl_Pago_Detalle] ([id_pago] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IX_tblPrestamo_Estado_Fecha]
    ON [dbo].[tbl_Prestamo] ([estado] ASC, [fecha_salida] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IXFK_Prestamo_Cliente]
    ON [dbo].[tbl_Prestamo] ([id_cliente] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IXFK_Prestamo_Ejemplar]
    ON [dbo].[tbl_Prestamo] ([id_ejemplar] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IXFK_Prestamo_Empleado]
    ON [dbo].[tbl_Prestamo] ([id_empleado] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IXFK_Reserva_Cliente]
    ON [dbo].[tbl_Reserva] ([id_cliente] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IXFK_Reserva_Ejemplar]
    ON [dbo].[tbl_Reserva] ([id_ejemplar] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IXFK_Reserva_Estado_Reserva]
    ON [dbo].[tbl_Reserva] ([id_estado] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IXFK_Reserva_Libro]
    ON [dbo].[tbl_Reserva] ([id_libro] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IXFK_Ubicacion_Columna]
    ON [dbo].[tbl_Ubicacion] ([id_columna] ASC)
    WITH (
        PAD_INDEX = OFF,
        STATISTICS_NORECOMPUTE = OFF,
        SORT_IN_TEMPDB = OFF,
        DROP_EXISTING = OFF,
        ONLINE = OFF,
        ALLOW_ROW_LOCKS = ON,
        ALLOW_PAGE_LOCKS = ON,
        OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
    ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tbl_Autor] ADD DEFAULT((1))
FOR [estado]
GO

ALTER TABLE [dbo].[tbl_Categoria] ADD DEFAULT((1))
FOR [estado]
GO

ALTER TABLE [dbo].[tbl_Cliente] ADD DEFAULT((1))
FOR [estado]
GO

ALTER TABLE [dbo].[tbl_Columna] ADD DEFAULT((1))
FOR [estado]
GO

ALTER TABLE [dbo].[tbl_Deuda] ADD DEFAULT((1))
FOR [estado]
GO

ALTER TABLE [dbo].[tbl_Editorial] ADD DEFAULT((1))
FOR [estado]
GO

ALTER TABLE [dbo].[tbl_Empleado] ADD DEFAULT((1))
FOR [estado]
GO

ALTER TABLE [dbo].[tbl_Estado_Ejemplar] ADD DEFAULT((1))
FOR [activo]
GO

ALTER TABLE [dbo].[tbl_Estado_Multa] ADD DEFAULT((1))
FOR [activo]
GO

ALTER TABLE [dbo].[tbl_Estado_Reserva] ADD DEFAULT((1))
FOR [activo]
GO

ALTER TABLE [dbo].[tbl_Estante] ADD DEFAULT((1))
FOR [estado]
GO

ALTER TABLE [dbo].[tbl_Fila] ADD DEFAULT((1))
FOR [estado]
GO

ALTER TABLE [dbo].[tbl_Libro] ADD DEFAULT((1))
FOR [estado]
GO

ALTER TABLE [dbo].[tbl_Metodo_Pago] ADD DEFAULT((1))
FOR [activo]
GO

ALTER TABLE [dbo].[tbl_Pago] ADD DEFAULT((1))
FOR [estado]
GO

ALTER TABLE [dbo].[tbl_Prestamo] ADD CONSTRAINT [DF_Prestamo_ID] DEFAULT(NEXT VALUE FOR
        [sq_Prestamo_ID])
FOR [id_prestamo]
GO

ALTER TABLE [dbo].[tbl_Prestamo] ADD DEFAULT((1))
FOR [estado]
GO

ALTER TABLE [dbo].[tbl_Tipo_Movimiento] ADD DEFAULT((1))
FOR [activo]
GO

ALTER TABLE [dbo].[tbl_Columna]
    WITH CHECK ADD CONSTRAINT [FK_Columna_Fila] FOREIGN KEY ([id_fila]) REFERENCES
        [dbo].[tbl_Fila]([id_fila])
GO

ALTER TABLE [dbo].[tbl_Columna] CHECK CONSTRAINT [FK_Columna_Fila]
GO

ALTER TABLE [dbo].[tbl_Deuda]
    WITH CHECK ADD CONSTRAINT [FK_Deuda_Cliente] FOREIGN KEY ([id_cliente])
        REFERENCES [dbo].[tbl_Cliente]([id_cliente])
GO

ALTER TABLE [dbo].[tbl_Deuda] CHECK CONSTRAINT [FK_Deuda_Cliente]
GO

ALTER TABLE [dbo].[tbl_Ejemplar]
    WITH CHECK ADD CONSTRAINT [FK_Ejemplar_Estado_Ejemplar] FOREIGN KEY ([id_estado]
            ) REFERENCES [dbo].[tbl_Estado_Ejemplar]([id_estado])
GO

ALTER TABLE [dbo].[tbl_Ejemplar] CHECK CONSTRAINT [FK_Ejemplar_Estado_Ejemplar]
GO

ALTER TABLE [dbo].[tbl_Ejemplar]
    WITH CHECK ADD CONSTRAINT [FK_Ejemplar_Ubicacion] FOREIGN KEY ([id_ubicacion])
        REFERENCES [dbo].[tbl_Ubicacion]([id_ubicacion])
GO

ALTER TABLE [dbo].[tbl_Ejemplar] CHECK CONSTRAINT [FK_Ejemplar_Ubicacion]
GO

ALTER TABLE [dbo].[tbl_Fila]
    WITH CHECK ADD CONSTRAINT [FK_Fila_Estante] FOREIGN KEY ([id_estante])
        REFERENCES [dbo].[tbl_Estante]([id_estante])
GO

ALTER TABLE [dbo].[tbl_Fila] CHECK CONSTRAINT [FK_Fila_Estante]
GO

ALTER TABLE [dbo].[tbl_Inventario]
    WITH CHECK ADD CONSTRAINT [FK_Inventario_Ejemplar] FOREIGN KEY ([id_ejemplar])
        REFERENCES [dbo].[tbl_Ejemplar]([id_ejemplar])
GO

ALTER TABLE [dbo].[tbl_Inventario] CHECK CONSTRAINT [FK_Inventario_Ejemplar]
GO

ALTER TABLE [dbo].[tbl_Inventario]
    WITH CHECK ADD CONSTRAINT [FK_Inventario_Libro] FOREIGN KEY ([id_libro])
        REFERENCES [dbo].[tbl_Libro]([id_libro])
GO

ALTER TABLE [dbo].[tbl_Inventario] CHECK CONSTRAINT [FK_Inventario_Libro]
GO

ALTER TABLE [dbo].[tbl_Inventario]
    WITH CHECK ADD CONSTRAINT [FK_Inventario_Tipo_Movimiento] FOREIGN KEY ([id_tipo_mov]
            ) REFERENCES [dbo].[tbl_Tipo_Movimiento]([id_tipo_mov])
GO

ALTER TABLE [dbo].[tbl_Inventario] CHECK CONSTRAINT [FK_Inventario_Tipo_Movimiento]
GO

ALTER TABLE [dbo].[tbl_Libro]
    WITH CHECK ADD CONSTRAINT [FK_Libro_Categoria] FOREIGN KEY ([id_categoria])
        REFERENCES [dbo].[tbl_Categoria]([id_categoria])
GO

ALTER TABLE [dbo].[tbl_Libro] CHECK CONSTRAINT [FK_Libro_Categoria]
GO

ALTER TABLE [dbo].[tbl_Libro]
    WITH CHECK ADD CONSTRAINT [FK_Libro_Editorial] FOREIGN KEY ([id_editorial])
        REFERENCES [dbo].[tbl_Editorial]([id_editorial])
GO

ALTER TABLE [dbo].[tbl_Libro] CHECK CONSTRAINT [FK_Libro_Editorial]
GO

ALTER TABLE [dbo].[tbl_Libro_Autor]
    WITH CHECK ADD CONSTRAINT [FK_Libro_Autor_Autor] FOREIGN KEY ([id_autor])
        REFERENCES [dbo].[tbl_Autor]([id_autor])
GO

ALTER TABLE [dbo].[tbl_Libro_Autor] CHECK CONSTRAINT [FK_Libro_Autor_Autor]
GO

ALTER TABLE [dbo].[tbl_Libro_Autor]
    WITH CHECK ADD CONSTRAINT [FK_Libro_Autor_Libro] FOREIGN KEY ([id_libro])
        REFERENCES [dbo].[tbl_Libro]([id_libro])
GO

ALTER TABLE [dbo].[tbl_Libro_Autor] CHECK CONSTRAINT [FK_Libro_Autor_Libro]
GO

ALTER TABLE [dbo].[tbl_Multa]
    WITH CHECK ADD CONSTRAINT [FK_Multa_Estado_Multa] FOREIGN KEY ([id_estado])
        REFERENCES [dbo].[tbl_Estado_Multa]([id_estado])
GO

ALTER TABLE [dbo].[tbl_Multa] CHECK CONSTRAINT [FK_Multa_Estado_Multa]
GO

ALTER TABLE [dbo].[tbl_Multa]
    WITH CHECK ADD CONSTRAINT [FK_Multa_Prestamo] FOREIGN KEY ([id_prestamo])
        REFERENCES [dbo].[tbl_Prestamo]([id_prestamo])
GO

ALTER TABLE [dbo].[tbl_Multa] CHECK CONSTRAINT [FK_Multa_Prestamo]
GO

ALTER TABLE [dbo].[tbl_Pago]
    WITH CHECK ADD CONSTRAINT [FK_Pago_Cliente] FOREIGN KEY ([id_cliente])
        REFERENCES [dbo].[tbl_Cliente]([id_cliente])
GO

ALTER TABLE [dbo].[tbl_Pago] CHECK CONSTRAINT [FK_Pago_Cliente]
GO

ALTER TABLE [dbo].[tbl_Pago]
    WITH CHECK ADD CONSTRAINT [FK_Pago_Metodo_Pago] FOREIGN KEY ([id_metodo_pago])
        REFERENCES [dbo].[tbl_Metodo_Pago]([id_metodo_pago])
GO

ALTER TABLE [dbo].[tbl_Pago] CHECK CONSTRAINT [FK_Pago_Metodo_Pago]
GO

ALTER TABLE [dbo].[tbl_Pago_Aplicacion]
    WITH CHECK ADD CONSTRAINT [FK_Pago_Aplicacion_Deuda] FOREIGN KEY ([id_deuda])
        REFERENCES [dbo].[tbl_Deuda]([id_deuda])
GO

ALTER TABLE [dbo].[tbl_Pago_Aplicacion] CHECK CONSTRAINT [FK_Pago_Aplicacion_Deuda]
GO

ALTER TABLE [dbo].[tbl_Pago_Aplicacion]
    WITH CHECK ADD CONSTRAINT [FK_Pago_Aplicacion_Pago] FOREIGN KEY ([id_pago])
        REFERENCES [dbo].[tbl_Pago]([id_pago])
GO

ALTER TABLE [dbo].[tbl_Pago_Aplicacion] CHECK CONSTRAINT [FK_Pago_Aplicacion_Pago]
GO

ALTER TABLE [dbo].[tbl_Pago_Detalle]
    WITH CHECK ADD CONSTRAINT [FK_Pago_Detalle_Metodo_Pago] FOREIGN KEY ([id_metodo_pago]
            ) REFERENCES [dbo].[tbl_Metodo_Pago]([id_metodo_pago])
GO

ALTER TABLE [dbo].[tbl_Pago_Detalle] CHECK CONSTRAINT [FK_Pago_Detalle_Metodo_Pago]
GO

ALTER TABLE [dbo].[tbl_Pago_Detalle]
    WITH CHECK ADD CONSTRAINT [FK_Pago_Detalle_Pago] FOREIGN KEY ([id_pago])
        REFERENCES [dbo].[tbl_Pago]([id_pago])
GO

ALTER TABLE [dbo].[tbl_Pago_Detalle] CHECK CONSTRAINT [FK_Pago_Detalle_Pago]
GO

ALTER TABLE [dbo].[tbl_Prestamo]
    WITH CHECK ADD CONSTRAINT [FK_Prestamo_Cliente] FOREIGN KEY ([id_cliente])
        REFERENCES [dbo].[tbl_Cliente]([id_cliente])
GO

ALTER TABLE [dbo].[tbl_Prestamo] CHECK CONSTRAINT [FK_Prestamo_Cliente]
GO

ALTER TABLE [dbo].[tbl_Prestamo]
    WITH CHECK ADD CONSTRAINT [FK_Prestamo_Ejemplar] FOREIGN KEY ([id_ejemplar])
        REFERENCES [dbo].[tbl_Ejemplar]([id_ejemplar])
GO

ALTER TABLE [dbo].[tbl_Prestamo] CHECK CONSTRAINT [FK_Prestamo_Ejemplar]
GO

ALTER TABLE [dbo].[tbl_Prestamo]
    WITH CHECK ADD CONSTRAINT [FK_Prestamo_Empleado] FOREIGN KEY ([id_empleado])
        REFERENCES [dbo].[tbl_Empleado]([id_empleado])
GO

ALTER TABLE [dbo].[tbl_Prestamo] CHECK CONSTRAINT [FK_Prestamo_Empleado]
GO

ALTER TABLE [dbo].[tbl_Reserva]
    WITH CHECK ADD CONSTRAINT [FK_Reserva_Cliente] FOREIGN KEY ([id_cliente])
        REFERENCES [dbo].[tbl_Cliente]([id_cliente])
GO

ALTER TABLE [dbo].[tbl_Reserva] CHECK CONSTRAINT [FK_Reserva_Cliente]
GO

ALTER TABLE [dbo].[tbl_Reserva]
    WITH CHECK ADD CONSTRAINT [FK_Reserva_Ejemplar] FOREIGN KEY ([id_ejemplar])
        REFERENCES [dbo].[tbl_Ejemplar]([id_ejemplar])
GO

ALTER TABLE [dbo].[tbl_Reserva] CHECK CONSTRAINT [FK_Reserva_Ejemplar]
GO

ALTER TABLE [dbo].[tbl_Reserva]
    WITH CHECK ADD CONSTRAINT [FK_Reserva_Estado_Reserva] FOREIGN KEY ([id_estado])
        REFERENCES [dbo].[tbl_Estado_Reserva]([id_estado])
GO

ALTER TABLE [dbo].[tbl_Reserva] CHECK CONSTRAINT [FK_Reserva_Estado_Reserva]
GO

ALTER TABLE [dbo].[tbl_Reserva]
    WITH CHECK ADD CONSTRAINT [FK_Reserva_Libro] FOREIGN KEY ([id_libro]) REFERENCES
        [dbo].[tbl_Libro]([id_libro])
GO

ALTER TABLE [dbo].[tbl_Reserva] CHECK CONSTRAINT [FK_Reserva_Libro]
GO

ALTER TABLE [dbo].[tbl_Ubicacion]
    WITH CHECK ADD CONSTRAINT [FK_Ubicacion_Columna] FOREIGN KEY ([id_columna])
        REFERENCES [dbo].[tbl_Columna]([id_columna])
GO

ALTER TABLE [dbo].[tbl_Ubicacion] CHECK CONSTRAINT [FK_Ubicacion_Columna]
GO

ALTER TABLE [dbo].[tbl_Libro]
    WITH CHECK ADD CONSTRAINT [CHK_anio_publicacion] CHECK (([anio_publicacion] <= (2025))
            )
GO

ALTER TABLE [dbo].[tbl_Libro] CHECK CONSTRAINT [CHK_anio_publicacion]
GO

ALTER TABLE [dbo].[tbl_Multa]
    WITH CHECK ADD CONSTRAINT [CHK_multa_monto] CHECK (([monto] > (0))
            )
GO

ALTER TABLE [dbo].[tbl_Multa] CHECK CONSTRAINT [CHK_multa_monto]
GO

USE [master]
GO

ALTER DATABASE [ConstelacionLibros]

SET READ_WRITE
GO
