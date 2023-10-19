USE [master]
GO
/****** Object:  Database [LucianoGym]    Script Date: 19/10/2023 05:07:50 am ******/
CREATE DATABASE [LucianoGym]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LucianoGym', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\LucianoGym.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'LucianoGym_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\LucianoGym_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [LucianoGym] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LucianoGym].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LucianoGym] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LucianoGym] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LucianoGym] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LucianoGym] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LucianoGym] SET ARITHABORT OFF 
GO
ALTER DATABASE [LucianoGym] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [LucianoGym] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LucianoGym] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LucianoGym] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LucianoGym] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LucianoGym] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LucianoGym] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LucianoGym] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LucianoGym] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LucianoGym] SET  ENABLE_BROKER 
GO
ALTER DATABASE [LucianoGym] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LucianoGym] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LucianoGym] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LucianoGym] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LucianoGym] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LucianoGym] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LucianoGym] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LucianoGym] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [LucianoGym] SET  MULTI_USER 
GO
ALTER DATABASE [LucianoGym] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LucianoGym] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LucianoGym] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LucianoGym] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LucianoGym] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [LucianoGym] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [LucianoGym] SET QUERY_STORE = ON
GO
ALTER DATABASE [LucianoGym] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [LucianoGym]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 19/10/2023 05:07:50 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[codigo] [int] IDENTITY(100,1) NOT NULL,
	[DNI] [int] NULL,
	[Nombres] [varchar](100) NULL,
	[Apellidos] [varchar](100) NULL,
	[Telefono] [int] NULL,
	[FechaNacimiento] [date] NULL,
	[Foto] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HistorialSocio]    Script Date: 19/10/2023 05:07:50 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HistorialSocio](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClienteID] [int] NULL,
	[PrecioMembresia] [decimal](10, 2) NULL,
	[MontoPagado] [decimal](10, 2) NULL,
	[FechaInicio] [date] NULL,
	[FechaFin] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VistaHistorialSocio]    Script Date: 19/10/2023 05:07:50 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VistaHistorialSocio] AS
SELECT h.ClienteID, u.Apellidos, u.Nombres, u.Telefono, h.FechaInicio, h.FechaFin
FROM HistorialSocio h
JOIN Usuarios u ON h.ClienteID = u.Codigo
WHERE CONVERT(DATE, h.FechaFin) = CONVERT(DATE, GETDATE());
GO
/****** Object:  View [dbo].[VistaHistorialSocioMañana]    Script Date: 19/10/2023 05:07:50 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VistaHistorialSocioMañana] AS
SELECT h.ClienteID,u.Apellidos,u.Nombres,u.Telefono, h.FechaInicio, h.FechaFin
                FROM HistorialSocio h
                join Usuarios u on h.ClienteID=u.codigo
                 WHERE FechaFin = CONVERT(DATE, DATEADD(DAY, 1, GETDATE()))
GO
/****** Object:  Table [dbo].[Categorias]    Script Date: 19/10/2023 05:07:50 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categorias](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 19/10/2023 05:07:50 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](255) NOT NULL,
	[Descripcion] [text] NULL,
	[CategoriaID] [int] NULL,
	[Precio] [decimal](10, 2) NOT NULL,
	[ImagenProducto] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StockPorUnidad]    Script Date: 19/10/2023 05:07:50 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockPorUnidad](
	[ProductoID] [int] NOT NULL,
	[CantidadEnStock] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VistaProductosConStock]    Script Date: 19/10/2023 05:07:50 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VistaProductosConStock] AS
SELECT
    P.ID AS ProductoID,
    P.Nombre AS NombreProducto,
    P.Descripcion AS DescripcionProducto,
    C.Nombre AS NombreCategoria,
    P.Precio AS PrecioProducto,
    SU.CantidadEnStock AS StockUnidad,
    P.ImagenProducto 
FROM Productos AS P
LEFT JOIN Categorias AS C ON P.CategoriaID = C.ID
LEFT JOIN StockPorUnidad AS SU ON P.ID = SU.ProductoID
WHERE EXISTS (
    SELECT 1
    FROM StockPorUnidad AS SU2
    WHERE SU2.ProductoID = P.ID
);
GO
/****** Object:  Table [dbo].[StockPorPorcion]    Script Date: 19/10/2023 05:07:50 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockPorPorcion](
	[ProductoID] [int] NOT NULL,
	[CantidadEnStock] [int] NOT NULL,
	[ScoopsPorPote] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VistaProductosConStockPorPorcion]    Script Date: 19/10/2023 05:07:50 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VistaProductosConStockPorPorcion] AS
SELECT
    P.ID AS ProductoID,
    P.Nombre AS NombreProducto,
    P.Descripcion AS DescripcionProducto,
    C.Nombre AS NombreCategoria,
    P.Precio AS PrecioProducto,
    PP.CantidadEnStock AS Stock,
    PP.ScoopsPorPote,
    P.ImagenProducto 
FROM Productos AS P
LEFT JOIN Categorias AS C ON P.CategoriaID = C.ID
LEFT JOIN StockPorPorcion AS PP ON P.ID = PP.ProductoID
WHERE EXISTS (
    SELECT 1
    FROM StockPorPorcion AS PP2
    WHERE PP2.ProductoID = P.ID
);
GO
/****** Object:  Table [dbo].[DetalleVenta]    Script Date: 19/10/2023 05:07:50 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetalleVenta](
	[Id_detalleVenta] [int] IDENTITY(1,1) NOT NULL,
	[VentaID] [int] NULL,
	[ProductoID] [int] NULL,
	[CantidadVenta] [int] NULL,
	[PrecioUnitario] [decimal](10, 2) NULL,
	[SubTotal] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_detalleVenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LOGIN]    Script Date: 19/10/2023 05:07:50 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOGIN](
	[usuario] [varchar](255) NULL,
	[contraseña] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PagoMembresias]    Script Date: 19/10/2023 05:07:50 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PagoMembresias](
	[ID] [int] IDENTITY(100,2) NOT NULL,
	[ClienteID] [int] NULL,
	[PrecioMembresia] [decimal](10, 2) NULL,
	[MontoPagado] [decimal](10, 2) NULL,
	[MontoRestante] [decimal](10, 2) NULL,
	[FechaInicio] [date] NULL,
	[FechaFin] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsuarioAdmin]    Script Date: 19/10/2023 05:07:50 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsuarioAdmin](
	[Id_Usuario] [int] IDENTITY(1,1) NOT NULL,
	[Usuario] [nvarchar](50) NULL,
	[ContraseñaHash] [varbinary](max) NULL,
	[Sal] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Venta]    Script Date: 19/10/2023 05:07:50 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Venta](
	[ID_Venta] [int] IDENTITY(1,1) NOT NULL,
	[FechaVenta] [date] NULL,
	[TotalVenta] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Venta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DetalleVenta]  WITH CHECK ADD FOREIGN KEY([VentaID])
REFERENCES [dbo].[Venta] ([ID_Venta])
GO
ALTER TABLE [dbo].[HistorialSocio]  WITH CHECK ADD  CONSTRAINT [FK_ClienteHistorial] FOREIGN KEY([ClienteID])
REFERENCES [dbo].[Usuarios] ([codigo])
GO
ALTER TABLE [dbo].[HistorialSocio] CHECK CONSTRAINT [FK_ClienteHistorial]
GO
ALTER TABLE [dbo].[PagoMembresias]  WITH CHECK ADD  CONSTRAINT [FK_ClientePago] FOREIGN KEY([ClienteID])
REFERENCES [dbo].[Usuarios] ([codigo])
GO
ALTER TABLE [dbo].[PagoMembresias] CHECK CONSTRAINT [FK_ClientePago]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD FOREIGN KEY([CategoriaID])
REFERENCES [dbo].[Categorias] ([ID])
GO
ALTER TABLE [dbo].[StockPorPorcion]  WITH CHECK ADD FOREIGN KEY([ProductoID])
REFERENCES [dbo].[Productos] ([ID])
GO
ALTER TABLE [dbo].[StockPorUnidad]  WITH CHECK ADD FOREIGN KEY([ProductoID])
REFERENCES [dbo].[Productos] ([ID])
GO
/****** Object:  StoredProcedure [dbo].[ActualizarProducto]    Script Date: 19/10/2023 05:07:50 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarProducto]

    @precio DECIMAL(10, 2),
    @stock INT,
    @fotoProducto VARBINARY(MAX),
    @productoID INT
AS
BEGIN
    -- Actualizar StockPorUnidad
    UPDATE StockPorUnidad
    SET CantidadEnStock = @stock
    WHERE ProductoID = @productoID;

    -- Actualizar Productos
    UPDATE Productos
    SET 
        Precio = @precio,
        ImagenProducto = @fotoProducto
    WHERE ID = @productoID;
END
GO
/****** Object:  StoredProcedure [dbo].[ActualizarStockYProductoPor]    Script Date: 19/10/2023 05:07:50 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ActualizarStockYProductoPor]
    @cantidadEnStock INT,
    @scoopsPorPote INT,
    @precio DECIMAL(10, 2),
    @imagenProducto VARBINARY(MAX),
    @productoID INT
AS
BEGIN
    -- Actualiza StockPorPorcion
    UPDATE StockPorPorcion
    SET CantidadEnStock = @cantidadEnStock,
        ScoopsPorPote = @scoopsPorPote
    WHERE ProductoID = @productoID;

    -- Actualiza Productos
    UPDATE Productos
    SET Precio = @precio,
        ImagenProducto = @imagenProducto
    WHERE ID = @productoID;
END
GO
/****** Object:  StoredProcedure [dbo].[BuscarProductosPorNombrePor]    Script Date: 19/10/2023 05:07:50 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BuscarProductosPorNombrePor]
    @nombreProducto NVARCHAR(255)
AS
BEGIN
    SELECT P.ID, P.Nombre, P.Descripcion, P.CategoriaID, P.Precio, SP.CantidadEnStock,SP.ScoopsPorPote
    FROM Productos P
    INNER JOIN StockPorPorcion SP ON P.ID = SP.ProductoID
    WHERE P.Nombre LIKE @nombreProducto + '%';
END;
GO
/****** Object:  StoredProcedure [dbo].[BuscarProductosPorNombreUnit]    Script Date: 19/10/2023 05:07:50 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BuscarProductosPorNombreUnit]
    @nombreProducto NVARCHAR(255)
AS
BEGIN
    SELECT P.ID, P.Nombre, P.Descripcion, P.CategoriaID, P.Precio, SP.CantidadEnStock
    FROM Productos P
    INNER JOIN StockPorUnidad SP ON P.ID = SP.ProductoID
    WHERE P.Nombre LIKE @nombreProducto + '%';
END;
GO
/****** Object:  StoredProcedure [dbo].[BuscarUsuariosPorApellidos]    Script Date: 19/10/2023 05:07:50 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BuscarUsuariosPorApellidos]
    @Valor NVARCHAR(100)
AS
BEGIN
    SELECT e.Codigo, e.DNI, e.Nombres, e.Apellidos, e.Telefono, e.FechaNacimiento
    FROM Usuarios e
    WHERE Apellidos LIKE @Valor + '%';
END
GO
/****** Object:  StoredProcedure [dbo].[EliminarUsuarioYRelacionados]    Script Date: 19/10/2023 05:07:50 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminarUsuarioYRelacionados]
    @codigo INT
AS
BEGIN
    

    -- Elimina registros de la tabla PagoMembresias relacionados con el ClienteID
    DELETE FROM PagoMembresias WHERE ClienteID = @codigo;

    -- Elimina registros de la tabla HistorialSocio relacionados con el ClienteID
    DELETE FROM HistorialSocio WHERE ClienteID = @codigo;
	-- Elimina registros de la tabla Usuarios
    DELETE FROM Usuarios WHERE codigo = @codigo;
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertarCliente]    Script Date: 19/10/2023 05:07:50 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertarCliente]
    @clienteDNI INT,
    @clienteNombres VARCHAR(100),
    @clienteApellidos VARCHAR(100),
    @clienteTelefono INT,
    @clienteFechaNacimiento DATE,
	@Foto VARBINARY(MAX) ,
    @precioMembresia DECIMAL(10, 2),
    @montoPagado DECIMAL(10, 2),
    @clienteFechaInicio DATE,
    @clienteFechaFin DATE
AS
BEGIN
    DECLARE @clienteID INT;
    DECLARE @montoRestante DECIMAL(10, 2);
    
    -- Insertar el cliente en Usuarios
    INSERT INTO Usuarios (DNI, Nombres, Apellidos, Telefono, FechaNacimiento,Foto)
    VALUES (@clienteDNI, @clienteNombres, @clienteApellidos, @clienteTelefono, @clienteFechaNacimiento,@Foto);
    
    -- Obtener el ID del cliente recién insertado
    SET @clienteID = SCOPE_IDENTITY();
    
    -- Calcular el monto restante
    SET @montoRestante = @precioMembresia - @montoPagado;
    
    -- Verificar el monto restante y decidir dónde insertar
    IF @montoRestante = 0
    BEGIN
        -- Insertar en HistorialSocio
        INSERT INTO HistorialSocio (ClienteID, PrecioMembresia, MontoPagado, FechaInicio, FechaFin)
        VALUES (@clienteID, @precioMembresia, @montoPagado, @clienteFechaInicio, @clienteFechaFin);
    END
    ELSE
    BEGIN
        -- Insertar en PagoMembresias
        INSERT INTO PagoMembresias (ClienteID, PrecioMembresia, MontoPagado, MontoRestante, FechaInicio, FechaFin)
        VALUES (@clienteID, @precioMembresia, @montoPagado, @montoRestante, @clienteFechaInicio, @clienteFechaFin);
    END;
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertarCliente1]    Script Date: 19/10/2023 05:07:50 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertarCliente1]
    @clienteDNI INT,
    @clienteNombres VARCHAR(100),
    @clienteApellidos VARCHAR(100),
    @clienteTelefono INT,
    @clienteFechaNacimiento DATE,
	@Foto VARBINARY(MAX),
    @precioMembresia DECIMAL(10, 2),
    @montoPagado DECIMAL(10, 2),
    @clienteFechaInicio DATE,
    @clienteFechaFin DATE
AS
BEGIN
    DECLARE @clienteID INT;
    DECLARE @montoRestante DECIMAL(10, 2);
    
    -- Insertar el cliente en Usuarios
    INSERT INTO Usuarios (DNI, Nombres, Apellidos, Telefono, FechaNacimiento, Foto)
    VALUES (@clienteDNI, @clienteNombres, @clienteApellidos, @clienteTelefono, @clienteFechaNacimiento, @Foto);
    
    -- Obtener el ID del cliente recién insertado
    SET @clienteID = SCOPE_IDENTITY();
    
    -- Calcular el monto restante
    SET @montoRestante = @precioMembresia - @montoPagado;
    
    -- Insertar en HistorialSocio
    INSERT INTO HistorialSocio (ClienteID, PrecioMembresia, MontoPagado, FechaInicio, FechaFin)
    VALUES (@clienteID, @precioMembresia, @montoPagado, @clienteFechaInicio, @clienteFechaFin);
    
    -- Insertar en PagoMembresias solo si el monto restante es mayor a 0
    IF @montoRestante > 0
    BEGIN
        INSERT INTO PagoMembresias (ClienteID, PrecioMembresia, MontoPagado, MontoRestante, FechaInicio, FechaFin)
        VALUES (@clienteID, @precioMembresia, @montoPagado, @montoRestante, @clienteFechaInicio, @clienteFechaFin);
    END;
END;

GO
/****** Object:  StoredProcedure [dbo].[MoverAPagoAHistorial]    Script Date: 19/10/2023 05:07:50 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MoverAPagoAHistorial]
    @ClienteID INT,
    @NuevoMontoPagado DECIMAL(10, 2)
AS
BEGIN
    -- Actualiza el registro en PagoMembresias
    UPDATE PagoMembresias
    SET MontoPagado = MontoPagado + @NuevoMontoPagado,
        MontoRestante = PrecioMembresia - (MontoPagado + @NuevoMontoPagado)
    WHERE ClienteID = @ClienteID;

    -- Verifica si el monto restante es igual o menor que cero
    IF (SELECT MontoRestante FROM PagoMembresias WHERE ClienteID = @ClienteID) <= 0
    BEGIN
        -- Inserta el registro en HistorialSocio
        INSERT INTO HistorialSocio (ClienteID, PrecioMembresia, MontoPagado, FechaInicio, FechaFin)
        SELECT ClienteID, PrecioMembresia, MontoPagado, FechaInicio, FechaFin
        FROM PagoMembresias
        WHERE ClienteID = @ClienteID;

        -- Elimina el registro de PagoMembresias
        DELETE FROM PagoMembresias WHERE ClienteID = @ClienteID;
    END
END;

GO
/****** Object:  StoredProcedure [dbo].[MoverAPagoAHistorial1]    Script Date: 19/10/2023 05:07:50 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MoverAPagoAHistorial1]
    @ClienteID INT,
    @NuevoMontoPagado DECIMAL(10, 2)
AS
BEGIN
    -- Obtén el MontoPagado actual y el PrecioMembresia del cliente
    DECLARE @MontoPagadoActual DECIMAL(10, 2);
    DECLARE @PrecioMembresia DECIMAL(10, 2);

    SELECT @MontoPagadoActual = MontoPagado, @PrecioMembresia = PrecioMembresia
    FROM PagoMembresias
    WHERE ClienteID = @ClienteID;

    -- Calcula el nuevo MontoPagado
    SET @NuevoMontoPagado = @MontoPagadoActual + @NuevoMontoPagado;

    -- Calcula el MontoRestante
    DECLARE @NuevoMontoRestante DECIMAL(10, 2);
    SET @NuevoMontoRestante = @PrecioMembresia - @NuevoMontoPagado;

    -- Actualiza el registro en PagoMembresias
    UPDATE PagoMembresias
    SET MontoPagado = @NuevoMontoPagado,
        MontoRestante = @NuevoMontoRestante
    WHERE ClienteID = @ClienteID;

    -- Actualiza el monto pagado en el historial socio
    UPDATE HistorialSocio
    SET MontoPagado = @NuevoMontoPagado
    WHERE ClienteID = @ClienteID;

    -- Verifica si el MontoRestante es igual o menor que cero
    IF @NuevoMontoRestante <= 0
    BEGIN
         DELETE FROM PagoMembresias WHERE ClienteID = @ClienteID;

    END
END;
GO
/****** Object:  StoredProcedure [dbo].[newMembresia]    Script Date: 19/10/2023 05:07:50 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[newMembresia]
@clienteID INT,  
    @precioMembresia DECIMAL(10, 2),
    @montoPagado DECIMAL(10, 2),
    @clienteFechaInicio DATE,
    @clienteFechaFin DATE
AS
BEGIN
    DECLARE @montoRestante DECIMAL(10, 2);
    
    
    -- Calcular el monto restante
    SET @montoRestante = @precioMembresia - @montoPagado;
    
    -- Insertar en HistorialSocio
    INSERT INTO HistorialSocio (ClienteID, PrecioMembresia, MontoPagado, FechaInicio, FechaFin)
    VALUES (@clienteID, @precioMembresia, @montoPagado, @clienteFechaInicio, @clienteFechaFin);
    
    -- Insertar en PagoMembresias solo si el monto restante es mayor a 0
    IF @montoRestante > 0
    BEGIN
        INSERT INTO PagoMembresias (ClienteID, PrecioMembresia, MontoPagado, MontoRestante, FechaInicio, FechaFin)
        VALUES (@clienteID, @precioMembresia, @montoPagado, @montoRestante, @clienteFechaInicio, @clienteFechaFin);
    END;
END;


GO
/****** Object:  StoredProcedure [dbo].[ps_ObtenerClientesDeuda]    Script Date: 19/10/2023 05:07:50 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ps_ObtenerClientesDeuda]
    @ClienteID INT
AS
BEGIN
    SELECT COUNT(*) AS PaymentCount
    FROM PagoMembresias
    WHERE ClienteID = @ClienteID;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateUser]    Script Date: 19/10/2023 05:07:50 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpdateUser]
    @DNI INT,
    @Nombres NVARCHAR(255),
    @Apellidos NVARCHAR(255),
    @FechaNacimiento DATE,
    @Telefono INT,
    @Foto VARBINARY(MAX),
    @Codigo INT
AS
BEGIN
    UPDATE Usuarios
    SET DNI = @DNI,
        Nombres = @Nombres,
        Apellidos = @Apellidos,
        FechaNacimiento = @FechaNacimiento,
        Telefono = @Telefono,
        Foto = @Foto
    WHERE codigo = @Codigo;
END
GO
/****** Object:  StoredProcedure [dbo].[spInsertarProducto]    Script Date: 19/10/2023 05:07:50 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spInsertarProducto]
    @Nombre NVARCHAR(255),
    @Descripcion NVARCHAR(MAX),
    @CategoriaID INT,
    @Precio DECIMAL(18, 2),
    @ImagenProducto VARBINARY(MAX)
AS
BEGIN
    INSERT INTO Productos (Nombre, Descripcion, CategoriaID, Precio, ImagenProducto)
    VALUES (@Nombre, @Descripcion, @CategoriaID, @Precio, @ImagenProducto);
END
GO
/****** Object:  StoredProcedure [dbo].[spInsertarProductoPoryStockPor]    Script Date: 19/10/2023 05:07:50 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spInsertarProductoPoryStockPor]
    @idProducto INT,
    @nombre VARCHAR(255),
    @descripcion VARCHAR(255),
	@Precio DECIMAL(10,2),
    @categoria INT,
    @imagenProducto VARBINARY(MAX),
    @stock INT,
	@totalScoops INT
AS
BEGIN


        -- Inserta el producto en la tabla Productos
        INSERT INTO Productos ( Nombre, Descripcion, CategoriaID,Precio, ImagenProducto)
        VALUES ( @nombre, @descripcion, @categoria,@Precio, @imagenProducto);

        -- Inserta el producto en la tabla StockPorUnidad
        INSERT INTO StockPorPorcion (ProductoID, CantidadEnStock,ScoopsPorPote)
        VALUES (@idProducto, @stock,@totalScoops);

END
GO
/****** Object:  StoredProcedure [dbo].[spInsertarProductoUnitYStockUnit]    Script Date: 19/10/2023 05:07:50 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spInsertarProductoUnitYStockUnit]
    @idProducto INT,
    @nombre VARCHAR(255),
    @descripcion VARCHAR(255),
	@Precio DECIMAL(10,2),
    @categoria INT,
    @imagenProducto VARBINARY(MAX),
    @stock INT
AS
BEGIN


        -- Inserta el producto en la tabla Productos
        INSERT INTO Productos ( Nombre, Descripcion, CategoriaID,Precio, ImagenProducto)
        VALUES ( @nombre, @descripcion, @categoria,@Precio, @imagenProducto);

        -- Inserta el producto en la tabla StockPorUnidad
        INSERT INTO StockPorUnidad (ProductoID, CantidadEnStock)
        VALUES (@idProducto, @stock);

END
GO
/****** Object:  StoredProcedure [dbo].[ValidarNuevaMembresia]    Script Date: 19/10/2023 05:07:50 am ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ValidarNuevaMembresia]
    @ClienteID INT
AS
BEGIN
    SELECT ClienteID
    FROM HistorialSocio h
    WHERE ClienteID = @ClienteID AND
        (
            FechaFin < GETDATE() AND
            NOT EXISTS (
                SELECT 1
                FROM HistorialSocio hs
                WHERE hs.ClienteID = h.ClienteID
                AND hs.FechaFin > GETDATE()
            ) AND
            NOT EXISTS (
                SELECT 1
                FROM pagoMembresias p
                WHERE p.ClienteID = h.ClienteID
                AND p.MontoRestante > 0
            )
        );
END;

GO
USE [master]
GO
ALTER DATABASE [LucianoGym] SET  READ_WRITE 
GO
