SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPagregarUsuarios]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SPagregarUsuarios]
	(
	@tipoDocumento nvarchar(50),
	@nroDocumento nvarchar(10),
	@usuario nvarchar(50),
	@password nvarchar(50),
	@permisos nvarchar(50),
	@activo bit
	)
	
AS
		insert into Usuarios values (@usuario,@tipoDocumento,@nroDocumento,@password,@permisos,@activo)
	
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPactivarCuenta]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SPactivarCuenta]

	(
	@usuario nvarchar(50),
	@activo bit
	)
	
AS
	UPDATE       Usuarios
SET                activo = @activo
where usuario=@usuario
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Session]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Session](
	[nrocuenta] [nchar](10) NOT NULL,
	[fecha] [nchar](10) NOT NULL,
	[usuario] [nchar](10) NOT NULL,
 CONSTRAINT [PK_Session] PRIMARY KEY CLUSTERED 
(
	[nrocuenta] ASC,
	[fecha] ASC,
	[usuario] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Item]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Item](
	[nroItem] [int] NOT NULL,
	[item] [nvarchar](100) NULL,
	[grupo] [int] NULL,
 CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED 
(
	[nroItem] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GruposdeItems]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[GruposdeItems](
	[nrogrupo] [int] NOT NULL,
	[grupo] [nvarchar](50) NULL,
 CONSTRAINT [PK_GruposdeItems] PRIMARY KEY CLUSTERED 
(
	[nrogrupo] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPactualizarDJ]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SPactualizarDJ]
	
	(
	@nrocuenta nvarchar(50),
	@nroItem int,
	@Visado bit
	)
	
AS
	Update ElementosaVisar set visado=@Visado where nrocuenta=@nrocuenta and nroItem=@nroItem
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPagregarDJ]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SPagregarDJ]
	
	(
	@nrocuenta nvarchar(50),
	@nroItem int,
	@visado bit
	)
	
AS
	INSERT INTO ElementosaVisar
                         (nroCuenta, nroitem, visado)
VALUES        (@nrocuenta,@nroItem,0)
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ElementosaVisar]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ElementosaVisar](
	[nroCuenta] [nvarchar](50) NOT NULL,
	[nroitem] [int] NOT NULL,
	[visado] [bit] NULL,
 CONSTRAINT [PK_ElementosaVisar] PRIMARY KEY CLUSTERED 
(
	[nroCuenta] ASC,
	[nroitem] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Carpetas]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Carpetas](
	[idCarpeta] [nvarchar](50) NOT NULL,
	[Estado] [nvarchar](50) NOT NULL,
	[Observacion] [nvarchar](500) NULL,
	[fecha] [datetime] NOT NULL,
	[ip] [nvarchar](15) NULL,
 CONSTRAINT [PK_Carpetas] PRIMARY KEY CLUSTERED 
(
	[idCarpeta] ASC,
	[Estado] ASC,
	[fecha] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ordenanzaFiscal]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ordenanzaFiscal](
	[categoria] [varchar](6) NOT NULL,
	[vivienda] [int] NOT NULL,
	[comercio] [int] NOT NULL,
	[industria] [int] NULL,
 CONSTRAINT [PK_ordenanzaFiscal] PRIMARY KEY CLUSTERED 
(
	[categoria] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPEliminarFormularioDerechosConstruccion]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SPEliminarFormularioDerechosConstruccion]
	
	(
	@idLiquidacion int
	
	)
	
AS
	DELETE  from LiquidacionDerechosConstruccion where idLiquidacion=@idLiquidacion
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LiquidacionXCuenta]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LiquidacionXCuenta](
	[idLiquidacion] [int] NOT NULL,
	[nroCuenta] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_LiquidacionXCuenta] PRIMARY KEY CLUSTERED 
(
	[idLiquidacion] ASC,
	[nroCuenta] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPseleccionarLiquidacionDerechoConstruccion]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SPseleccionarLiquidacionDerechoConstruccion]
	
	(
	@nroCuenta nvarchar(50),
	@idLiquidacion int,
	@fecha datetime
	)
	
AS
	Select * from LiquidacionDerechosConstruccion where nroCuenta=@nroCuenta and idLiquidacion = @idLiquidacion 
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPSeleccionarNumeroArchivo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SPSeleccionarNumeroArchivo]
	(
	@nroDocumento nvarchar(10),
	@nrocuenta nvarchar(50),
	@fecha datetime,
	@oficinaDestino nvarchar(50),
	@subCarpeta nvarchar(50)
	)
	
AS
		Select count(nro_archivo) from registroArchivos where  
		(nroDocumentoProfesional=@nroDocumento and nrocuenta=@nrocuenta and oficinaDestino=@oficinaDestino and subCarpeta=@subCarpeta)
	
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[registroArchivos]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[registroArchivos](
	[nroDocumentoProfesional] [nvarchar](10) NOT NULL,
	[nrocuenta] [nvarchar](50) NOT NULL,
	[fecha] [datetime] NOT NULL,
	[oficinaDestino] [nvarchar](50) NULL,
	[subCarpeta] [nvarchar](50) NULL,
	[nro_archivo] [int] NULL,
	[nombreArchivo] [nvarchar](50) NULL,
	[ruta] [nvarchar](200) NULL,
	[ip] [nvarchar](15) NULL,
 CONSTRAINT [PK_registroArchivos] PRIMARY KEY CLUSTERED 
(
	[nroDocumentoProfesional] ASC,
	[nrocuenta] ASC,
	[fecha] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPactivarUsuario]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create PROCEDURE [dbo].[SPactivarUsuario]

	(
	@nroDocumento nchar(10),
	@activo bit
	)
	
AS
	UPDATE       Usuarios
SET                activo = @activo
where nrodocumento=@nroDocumento
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Estadistica]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Estadistica](
	[nrocuenta] [nvarchar](50) NOT NULL,
	[cantidadLocales] [int] NULL,
	[cantidadViviendas] [int] NULL,
	[cantidadDormitorios] [int] NULL,
	[cantidadBanos] [int] NULL,
	[destino] [int] NULL,
	[viviendaPropia] [int] NULL,
	[financiamientoPropio] [int] NULL,
	[distanciaTransporte] [int] NULL,
	[superficie] [float] NULL,
	[tipoObra] [nvarchar](30) NULL,
 CONSTRAINT [PK_Estadistica] PRIMARY KEY CLUSTERED 
(
	[nrocuenta] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Destino]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Destino](
	[id_destino] [int] NOT NULL,
	[destino] [nvarchar](50) NULL,
 CONSTRAINT [PK_Destino] PRIMARY KEY CLUSTERED 
(
	[id_destino] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[distanciaEnMetros]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[distanciaEnMetros](
	[id_distancia] [int] NOT NULL,
	[descripcion] [nvarchar](50) NULL,
 CONSTRAINT [PK_distanciaEnMetros] PRIMARY KEY CLUSTERED 
(
	[id_distancia] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MunicipalxCuenta]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MunicipalxCuenta](
	[nroDocumentoMunicipio] [nvarchar](10) NOT NULL,
	[nroCuenta] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_MunicipalxCuenta] PRIMARY KEY CLUSTERED 
(
	[nroDocumentoMunicipio] ASC,
	[nroCuenta] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[expedientesxCuenta]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[expedientesxCuenta](
	[nroCuenta] [nvarchar](50) NOT NULL,
	[matricula] [smallint] NOT NULL,
	[ejecicio] [smallint] NOT NULL,
	[numero] [int] NOT NULL,
	[letra] [varchar](3) NULL,
	[provincia] [smallint] NOT NULL,
	[tipo] [char](1) NOT NULL,
	[subNumero] [smallint] NOT NULL,
 CONSTRAINT [PK_expedientesxCuenta_1] PRIMARY KEY CLUSTERED 
(
	[nroCuenta] ASC,
	[matricula] ASC,
	[ejecicio] ASC,
	[numero] ASC,
	[provincia] ASC,
	[tipo] ASC,
	[subNumero] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LiquidacionDerechosConstruccion]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LiquidacionDerechosConstruccion](
	[idLiquidacion] [int] IDENTITY(1,1) NOT NULL,
	[categoria] [char](1) NULL,
	[tipoVivienda] [nvarchar](50) NULL,
	[valorCategoria] [float] NULL,
	[nuevaObranueva_Cub] [float] NULL,
	[nuevaObranueva_Scub] [float] NULL,
	[nuevaAmpliacion_Cub] [float] NULL,
	[nuevaAmpliacion_Scub] [float] NULL,
	[nuevaObranuevaCub_Valor] [float] NULL,
	[nuevaObranuevaScub_Valor] [float] NULL,
	[nuevaAmpliacionCub_Valor] [float] NULL,
	[nuevaAmpliacionScub_Valor] [float] NULL,
	[nuevaDemolicion_Valor] [float] NULL,
	[nuevaModificacionInterna_Valor] [float] NULL,
	[nuevaPileta_Valor] [float] NULL,
	[nuevaObranuevaCub_Importe] [float] NULL,
	[nuevaObranuevaScub_Importe] [float] NULL,
	[nuevaAmpliacionCub_Importe] [float] NULL,
	[nuevaAmpliacionScub_Importe] [float] NULL,
	[nuevaDemolicion_Importe] [float] NULL,
	[nuevaModificacionInterna_Importe] [float] NULL,
	[nuevaPileta_Importe] [float] NULL,
	[nuevaObranuevaCub_Subtotal] [float] NULL,
	[nuevaObranuevaScub_Subtotal] [float] NULL,
	[nuevaAmpliacionCub_Subtotal] [float] NULL,
	[nuevaAmpliacionScub_Subtotal] [float] NULL,
	[nuevaDemolicion_Subtotal] [float] NULL,
	[nuevaModificacionInterna_Subtotal] [float] NULL,
	[nuevaPileta_Subtotal] [float] NULL,
	[existenteSubsistencia_Cub] [float] NULL,
	[existenteSubsistencia_Scub] [float] NULL,
	[existenteConformeObra_Cub] [float] NULL,
	[existenteConformeObra_Scub] [float] NULL,
	[existenteSubsistenciaCub_Valor] [float] NULL,
	[existenteSubsistenciaScub_Valor] [float] NULL,
	[existenteConformeObraCub_Valor] [float] NULL,
	[existenteConformeObraScub_Valor] [float] NULL,
	[existenteDemolicion_Valor] [float] NULL,
	[existenteModificacionInterna_Valor] [float] NULL,
	[existentePileta_Valor] [float] NULL,
	[existenteSubsistenciaCub_Importe] [float] NULL,
	[existenteSubsistenciaScub_Importe] [float] NULL,
	[existenteConformeObraCub_Importe] [float] NULL,
	[existenteConformeObraScub_Importe] [float] NULL,
	[existenteDemolicion_Importe] [float] NULL,
	[existenteModificacionInterna_Importe] [float] NULL,
	[existentePileta_Importe] [float] NULL,
	[existenteSubsistenciaCub_Recargo] [float] NULL,
	[existenteSubsistenciaScub_Recargo] [float] NULL,
	[existenteConformeObraCub_Recargo] [float] NULL,
	[existenteConformeObraScub_Recargo] [float] NULL,
	[existenteDemolicion_Recargo] [float] NULL,
	[existenteModificacionInterna_Recargo] [float] NULL,
	[existentePileta_Recargo] [float] NULL,
	[existenteSubsistenciaCub_Subtotal] [float] NULL,
	[existenteSubsistenciaScub_Subtotal] [float] NULL,
	[existenteConformeObraCub_Subtotal] [float] NULL,
	[existenteConformeObraSCub_Subtotal] [float] NULL,
	[existenteDemolicion_Subtotal] [float] NULL,
	[existenteModificacionInterna_Subtotal] [float] NULL,
	[existentePileta_Subtotal] [float] NULL,
	[especialCubValor] [float] NULL,
	[especialScubValor] [float] NULL,
	[multifamiliarValor] [float] NULL,
	[galeriasValor] [float] NULL,
	[industriaValor] [float] NULL,
	[emprendimientosUrbanosValor] [float] NULL,
	[ambientalCubValor] [float] NULL,
	[ambientalScubValor] [float] NULL,
	[especialCubImporte] [float] NULL,
	[especialScubImporte] [float] NULL,
	[multifamiliarImporte] [float] NULL,
	[galeriasImporte] [float] NULL,
	[industriaImporte] [float] NULL,
	[emprendimientosUrbanosImporte] [float] NULL,
	[ambientalCubImporte] [float] NULL,
	[ambientalScubImporte] [float] NULL,
	[especialCubSubtotal] [float] NULL,
	[especialScubSubTotal] [float] NULL,
	[multifamiliarSubtotal] [float] NULL,
	[galeriasSubtotal] [float] NULL,
	[industriaSubtotal] [float] NULL,
	[emprendimientosUrbanosSubtotal] [float] NULL,
	[ambientalCubSubtotal] [float] NULL,
	[ambientalScubSubtotal] [float] NULL,
	[canchaTenis] [float] NULL,
	[canchaPaddle] [float] NULL,
	[canchaTenisValor] [float] NULL,
	[canchaPaddleValor] [float] NULL,
	[canchaTenisSubtotal] [float] NULL,
	[canchaPaddleSubtotal] [float] NULL,
	[totalPagar] [float] NULL,
	[fecha] [datetime] NOT NULL,
	[nrocuenta] [nvarchar](50) NOT NULL,
	[fechaActualizacion] [datetime] NULL,
 CONSTRAINT [PK_LiquidacionDerechosConstruccion] PRIMARY KEY CLUSTERED 
(
	[idLiquidacion] ASC,
	[fecha] ASC,
	[nrocuenta] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Usuarios]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Usuarios](
	[usuario] [nvarchar](50) NOT NULL,
	[tipoDocumento] [nvarchar](50) NULL,
	[nrodocumento] [nvarchar](10) NULL,
	[password] [nvarchar](50) NOT NULL,
	[permisos] [nvarchar](50) NULL,
	[activo] [bit] NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[usuario] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PedidoCopiaFiel]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PedidoCopiaFiel](
	[nroCuenta] [nvarchar](50) NOT NULL,
	[fechaPedido] [datetime] NOT NULL,
	[estado] [nvarchar](50) NULL,
	[nroPedido] [int] NULL,
	[tipo] [nvarchar](20) NULL,
 CONSTRAINT [PK_PedidoCopiaFiel] PRIMARY KEY CLUSTERED 
(
	[nroCuenta] ASC,
	[fechaPedido] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HistorialCorreo]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[HistorialCorreo](
	[nrocuenta] [nvarchar](50) NOT NULL,
	[origen] [nvarchar](50) NULL,
	[destino] [nvarchar](50) NULL,
	[asunto] [nvarchar](50) NULL,
	[mensaje] [nvarchar](2000) NULL,
	[fecha] [datetime] NOT NULL,
 CONSTRAINT [PK_HistorialCorreo] PRIMARY KEY CLUSTERED 
(
	[nrocuenta] ASC,
	[fecha] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[estadosMajor]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[estadosMajor](
	[codigo] [nvarchar](10) NOT NULL,
	[descripcion] [nvarchar](50) NULL,
	[agrupamiento] [nvarchar](50) NULL,
	[sidop] [nvarchar](50) NULL,
 CONSTRAINT [PK_estadosMajor] PRIMARY KEY CLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Personas]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Personas](
	[tipoDocumento] [nvarchar](50) NOT NULL,
	[nroDocumento] [nvarchar](10) NOT NULL,
	[nombre] [nvarchar](50) NULL,
	[apellido] [nvarchar](50) NULL,
	[mail] [nvarchar](50) NULL,
	[telefono] [nvarchar](20) NULL,
	[direccion] [nvarchar](100) NULL,
	[localidad] [nvarchar](100) NULL,
	[ciudad] [nvarchar](100) NULL,
	[tipo] [int] NULL,
 CONSTRAINT [PK_Personas] PRIMARY KEY CLUSTERED 
(
	[tipoDocumento] ASC,
	[nroDocumento] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PropietarioxCuenta]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PropietarioxCuenta](
	[nroCuenta] [nvarchar](50) NOT NULL,
	[nroDocumento] [nvarchar](10) NOT NULL,
	[nombre] [nvarchar](50) NULL,
	[apellido] [nvarchar](50) NULL,
	[mail] [nvarchar](50) NULL,
 CONSTRAINT [PK_PropietarioxCuenta] PRIMARY KEY CLUSTERED 
(
	[nroCuenta] ASC,
	[nroDocumento] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[ViewDemoraEstadisticaConUNPivot]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[ViewDemoraEstadisticaConUNPivot]
AS
SELECT        TipoCantidad AS Tipo, Cantidad AS cantidad
FROM            (SELECT        [Cantidad de verificados en menos de 15 dias], [Cantidad de verificados con demora entre 15 y 30 dias], 
                                                    [Cantidad de verificados con demora entre 30 y 45 dias], [Cantidad de verificados fuera de parametros], [Cantidad de registrados en menos de 15 dias], 
                                                    [Cantidad de registrados con demora entre 15 y 30 dias], [Cantidad de registrado con demora entre 30 y 45 dias], 
                                                    [Cantidad de registrados fuera de parametros]
                          FROM            ViewDemoraEstadistica) AS consulta UNPIVOT (Cantidad FOR TipoCantidad IN ([Cantidad de verificados en menos de 15 dias], 
                         [Cantidad de verificados con demora entre 15 y 30 dias], [Cantidad de verificados con demora entre 30 y 45 dias], [Cantidad de verificados fuera de parametros], 
                         [Cantidad de registrados en menos de 15 dias], [Cantidad de registrados con demora entre 15 y 30 dias], [Cantidad de registrado con demora entre 30 y 45 dias], 
                         [Cantidad de registrados fuera de parametros])) AS unpvt
' 
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane1' , N'SCHEMA',N'dbo', N'VIEW',N'ViewDemoraEstadisticaConUNPivot', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[18] 4[20] 2[35] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 4485
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewDemoraEstadisticaConUNPivot'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPaneCount' , N'SCHEMA',N'dbo', N'VIEW',N'ViewDemoraEstadisticaConUNPivot', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewDemoraEstadisticaConUNPivot'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[ViewTotalExpedientesXRegistrados]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[ViewTotalExpedientesXRegistrados]
AS
SELECT        COUNT(*) AS [Todas las cuentas en SiDOP], COUNT(CASE WHEN estado = ''REGISTRADO'' OR
                         estado = ''1316'' THEN 1 ELSE NULL END) AS [Todas las cuentas Registradas en SiDOP]
FROM            dbo.UltimoEstadoCuentas
WHERE        (idCarpeta <> ''88888888'')
' 
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane1' , N'SCHEMA',N'dbo', N'VIEW',N'ViewTotalExpedientesXRegistrados', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "UltimoEstadoCuentas"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 118
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewTotalExpedientesXRegistrados'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPaneCount' , N'SCHEMA',N'dbo', N'VIEW',N'ViewTotalExpedientesXRegistrados', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewTotalExpedientesXRegistrados'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[personasPrueba]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[personasPrueba](
	[mail] [nvarchar](50) NULL,
	[tipo] [int] NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Carpetas_copy]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Carpetas_copy](
	[idCarpeta] [nvarchar](50) NOT NULL,
	[Estado] [nvarchar](50) NOT NULL,
	[Observacion] [nvarchar](500) NULL,
	[fecha] [datetime] NOT NULL,
	[ip] [nvarchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[idCarpeta] ASC,
	[Estado] ASC,
	[fecha] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Profesionales]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Profesionales](
	[tipoDocumento] [nvarchar](50) NULL,
	[nroDocumento] [nvarchar](10) NOT NULL,
	[nroRegistroProfesional] [nvarchar](50) NOT NULL,
	[nroRegistroMunicipal] [nvarchar](50) NULL,
	[nroCuentaMunicipal] [nvarchar](50) NULL,
	[nro_cuit] [nvarchar](20) NULL,
	[tituloHabilitante] [nvarchar](50) NULL,
	[categoria] [nvarchar](50) NULL,
 CONSTRAINT [PK_Profesionales] PRIMARY KEY CLUSTERED 
(
	[nroDocumento] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cuentaXTasas]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[cuentaXTasas](
	[idCuenta] [nvarchar](50) NOT NULL,
	[estadoTasas] [nvarchar](10) NULL,
 CONSTRAINT [PK_cuentaXTasas] PRIMARY KEY CLUSTERED 
(
	[idCuenta] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProfesionalXcuenta]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ProfesionalXcuenta](
	[nroDocumentoProfesional] [nvarchar](10) NOT NULL,
	[nroCuenta] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ProfesionalXcuenta] PRIMARY KEY CLUSTERED 
(
	[nroDocumentoProfesional] ASC,
	[nroCuenta] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPseleccionarVisado]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SPseleccionarVisado]
	
	(
	@nroCuenta nvarchar(50)
	)
	
AS
	Select * from ElementosaVisar where nroCuenta=@nroCuenta
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[Inicio de Expediente]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[Inicio de Expediente]
AS
SELECT        idCarpeta, MIN(fecha) AS fecha
FROM            dbo.Carpetas AS c2
GROUP BY idCarpeta
HAVING        (MIN(fecha) BETWEEN ''2016-02-01 00:00'' AND ''2016-02-29 23:59'')
' 
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane1' , N'SCHEMA',N'dbo', N'VIEW',N'Inicio de Expediente', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "c2"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Inicio de Expediente'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPaneCount' , N'SCHEMA',N'dbo', N'VIEW',N'Inicio de Expediente', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Inicio de Expediente'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CalculodeDessidadTOTALES]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CalculodeDessidadTOTALES]
	/*
	(
	@parameter1 int = 5,
	@parameter2 datatype OUTPUT
	)
	*/
AS
	SELECT DISTINCT tigre.Cuenta, SUM(Estadistica.cantidadDormitorios * 2) * 10000 / SUM(tigre.Superficie_Terreno) AS totalDensidad, tigre.Nomenclatura_Completa
FROM            Bd_Munic1.dbo.WEBOP_V_AUT_Inmuebles AS tigre LEFT OUTER JOIN
                         expedientesxCuenta AS eCuenta ON tigre.Cuenta = eCuenta.nroCuenta INNER JOIN
                         Carpetas AS Carpetas_1 ON Carpetas_1.idCarpeta = tigre.Cuenta INNER JOIN
                         UltimoEstadoCuentas ON Carpetas_1.idCarpeta = UltimoEstadoCuentas.idCarpeta INNER JOIN
                         estadosMajor ON UltimoEstadoCuentas.estado = estadosMajor.codigo INNER JOIN
                         Estadistica ON Carpetas_1.idCarpeta = Estadistica.nrocuenta LEFT OUTER JOIN
                         ProfesionalXcuenta AS ProfesionalXcuenta_1 ON tigre.Cuenta = ProfesionalXcuenta_1.nroCuenta LEFT OUTER JOIN
                         MunicipalxCuenta ON tigre.Cuenta = MunicipalxCuenta.nroCuenta
GROUP BY tigre.Cuenta, tigre.Nomenclatura_Completa
ORDER BY tigre.Cuenta
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[Estadistica1]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[Estadistica1]
AS
SELECT DISTINCT TOP (100) PERCENT Car.idCarpeta AS C,
                             (SELECT        TOP (1) fecha
                               FROM            dbo.Carpetas
                               WHERE        (Estado = ''ACTIVO'' OR
                                                         Estado = ''1280'') AND (idCarpeta = Car.idCarpeta)
                               ORDER BY idCarpeta, fecha) AS [Fecha de alta en SiDOP],
                             (SELECT        TOP (1) fecha
                               FROM            dbo.Carpetas AS Carpetas_1
                               WHERE        (Estado = ''VERIFICADO'' OR
                                                         Estado = ''1287'') AND (idCarpeta = Car.idCarpeta)
                               ORDER BY idCarpeta, fecha) AS [Fecha de Verificacion en SiDOP], DATEDIFF(day,
                             (SELECT        TOP (1) fecha
                               FROM            dbo.Carpetas AS Carpetas_3
                               WHERE        (Estado = ''ACTIVO'' OR
                                                         Estado = ''1280'') AND (idCarpeta = Car.idCarpeta)
                               ORDER BY idCarpeta, fecha),
                             (SELECT        TOP (1) fecha
                               FROM            dbo.Carpetas AS Carpetas_1
                               WHERE        (Estado = ''VERIFICADO'' OR
                                                         Estado = ''1287'') AND (idCarpeta = Car.idCarpeta)
                               ORDER BY idCarpeta, fecha)) AS [Diferencia en dias a verificado],
                             (SELECT        TOP (1) fecha
                               FROM            dbo.Carpetas AS Carpetas_2
                               WHERE        (Estado = ''REGISTRADO'' OR
                                                         Estado = ''1316'') AND (idCarpeta = Car.idCarpeta)
                               ORDER BY idCarpeta, fecha) AS [Fecha de registro], DATEDIFF(day,
                             (SELECT        TOP (1) fecha
                               FROM            dbo.Carpetas AS Carpetas_1
                               WHERE        (Estado = ''VERIFICADO'' OR
                                                         Estado = ''1287'') AND (idCarpeta = Car.idCarpeta)
                               ORDER BY idCarpeta, fecha),
                             (SELECT        TOP (1) fecha
                               FROM            dbo.Carpetas AS Carpetas_2
                               WHERE        (Estado = ''REGISTRADO'' OR
                                                         Estado = ''1316'') AND (idCarpeta = Car.idCarpeta)
                               ORDER BY idCarpeta, fecha)) AS [Diferencia en dias a Registrado], dbo.estadosMajor.sidop AS [Ultimo estado], 
                         dbo.UltimoEstadoCuentas.fecha AS [Fecha del ultimo estado], DATEDIFF(day,
                             (SELECT        TOP (1) fecha
                               FROM            dbo.Carpetas AS Carpetas_3
                               WHERE        (Estado = ''ACTIVO'' OR
                                                         Estado = ''1280'') AND (idCarpeta = Car.idCarpeta)
                               ORDER BY idCarpeta, fecha), dbo.UltimoEstadoCuentas.fecha) AS [Diferencia en dias desde el inicio]
FROM            dbo.Carpetas AS Car INNER JOIN
                         dbo.UltimoEstadoCuentas ON Car.idCarpeta = dbo.UltimoEstadoCuentas.idCarpeta INNER JOIN
                         dbo.estadosMajor ON dbo.UltimoEstadoCuentas.estado = dbo.estadosMajor.codigo
ORDER BY C
' 
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane1' , N'SCHEMA',N'dbo', N'VIEW',N'Estadistica1', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[18] 4[13] 2[29] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Car"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "UltimoEstadoCuentas"
            Begin Extent = 
               Top = 6
               Left = 285
               Bottom = 118
               Right = 494
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "estadosMajor"
            Begin Extent = 
               Top = 6
               Left = 532
               Bottom = 135
               Right = 741
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 3000
         Width = 2685
         Width = 2250
         Width = 2805
         Width = 1905
         Width = 870
         Width = 495
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Estadistica1'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPaneCount' , N'SCHEMA',N'dbo', N'VIEW',N'Estadistica1', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Estadistica1'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[UltimoEstadoCuentas]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[UltimoEstadoCuentas]
AS
SELECT        idCarpeta, MAX(fecha) AS fecha,
                             (SELECT        TOP (1) Estado
                               FROM            dbo.Carpetas AS c
                               WHERE        (idCarpeta = c2.idCarpeta) AND (fecha = MAX(c2.fecha))) AS estado
FROM            dbo.Carpetas AS c2
GROUP BY idCarpeta
' 
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane1' , N'SCHEMA',N'dbo', N'VIEW',N'UltimoEstadoCuentas', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[14] 2[29] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "c2"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 2205
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'UltimoEstadoCuentas'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPaneCount' , N'SCHEMA',N'dbo', N'VIEW',N'UltimoEstadoCuentas', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'UltimoEstadoCuentas'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPseleccionarOrdenanzaFis]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SPseleccionarOrdenanzaFis]
	
	(
	@categoria nvarchar(6)
	)
	
AS
	Select * from ordenanzaFiscal where categoria=@categoria
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPagregarRegistroArchivo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SPagregarRegistroArchivo]
	(
	@nroDocumento nvarchar(10),
	@nrocuenta nvarchar(50),
	@fecha datetime,
	@oficinaDestino nvarchar(50),
	@subCarpeta nvarchar(50),
	@nro_archivo int,
	@nombreArchivo nvarchar(50),
	@ruta nvarchar (200),
	@ip nvarchar (15)
	)
	
AS
		insert into registroArchivos values (@nroDocumento,@nrocuenta,@fecha,@oficinaDestino,@subCarpeta,@nro_archivo,@nombreArchivo,@ruta,@ip)
	
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPseleccionarCantidadArchivos]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create PROCEDURE [dbo].[SPseleccionarCantidadArchivos]
	
	(
	@nroCuenta nvarchar(50),
	@subCarpeta nvarchar(50)
	)
	
AS
	Select count(*) from registroArchivos where nroCuenta=@nroCuenta and subCarpeta=@subCarpeta
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPagregarEstadistica]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SPagregarEstadistica]
	(
	@nroCuenta nvarchar(50),
	@cantidadLocales int,
	@cantidadViviendas int,
	@cantidadDormitorios int,
	@cantidadBanos int,
	@destino int,
	@viviendaPropia int,
	@financiamientoPropio int,
	@distanciaTransporte int,
	@superficie float,
	@tipoObra nvarchar(30)
	)
	
AS
		insert into Estadistica values (@nroCuenta,@cantidadLocales,@cantidadViviendas,@cantidadDormitorios,@cantidadBanos,@destino,@viviendaPropia,@financiamientoPropio,@distanciaTransporte,@superficie,@tipoObra)
	
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPactualizarEstadistica]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SPactualizarEstadistica]
	
	(
	@nroCuenta nvarchar(50),
	@cantidadLocales int,
	@cantidadViviendas int,
	@cantidadDormitorios int,
	@cantidadBanos int,
	@destino int,
	@viviendaPropia int,
	@financiamientoPropio int,
	@distanciaTransporte int,
	@superficie float,
	@tipoObra nvarchar(30)
	)
	
AS
	Update Estadistica set cantidadLocales=@cantidadLocales, cantidadViviendas=@cantidadViviendas, 
	cantidadDormitorios=@cantidadDormitorios, cantidadBanos=@cantidadBanos, destino=@destino, viviendaPropia=@viviendaPropia, 
	financiamientoPropio=@financiamientoPropio, distanciaTransporte=@distanciaTransporte, superficie=@superficie,tipoObra=@tipoObra where nrocuenta=@nrocuenta
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPseleccionarEstadistica]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create PROCEDURE [dbo].[SPseleccionarEstadistica]
	
	(
	@nroCuenta nvarchar(50)
	)
	
AS
	Select * from Estadistica where nroCuenta=@nroCuenta
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPeliminarMunicipalesXCuenta]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create PROCEDURE [dbo].[SPeliminarMunicipalesXCuenta]
	(
	@nroDocumento nvarchar(10),
	@nrocuenta nvarchar(50)
	)
	
AS
		delete from MunicipalXcuenta where nroDocumentoMunicipio=@nrodocumento and nroCuenta=@nrocuenta
	
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPagregarMunicipalesXCuenta]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create PROCEDURE [dbo].[SPagregarMunicipalesXCuenta]
	(
	@nroDocumento nvarchar(10),
	@nrocuenta nvarchar(50)
	)
	
AS
		insert into MunicipalXcuenta values (@nrodocumento, @nrocuenta)
	
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPagregarExpedienteACuenta]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SPagregarExpedienteACuenta]
	(
	@nroCuenta nvarchar(50),
	@matricula smallint,
	@ejercicio smallint,
	@numero int,
	@letra varchar(3),
	@provincia smallint,
	@tipo char(1),
	@subNumero smallint
	
	)
	
AS
		insert into expedientesxCuenta values (@nroCuenta,@matricula,@ejercicio,@numero,@letra,@provincia,@tipo,@subNumero)
	
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPagregarFormularioDerechoConstruccion]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SPagregarFormularioDerechoConstruccion]
	
	(
	/*@idLiquidacion int,*/
	@categoria char(1),
	@tipoVivienda nvarchar(50),
	@valorCategoria float,
	@nuevaObranueva_Cub float,
	@nuevaObranueva_Scub float,
	@nuevaAmpliacion_Cub float,
	@nuevaAmpliacion_Scub float,
	@nuevaObranuevaCub_Valor float,
	@nuevaObranuevaScub_Valor float,
	@nuevaAmpliacionCub_Valor float,
	@nuevaAmpliacionScub_Valor float,
	@nuevaDemolicion_Valor float,
	@nuevaModificacionInterna_Valor float,
	@nuevaPileta_Valor float,
	@nuevaObranuevaCub_Importe float,
	@nuevaObranuevaScub_Importe float,
	@nuevaAmpliacionCub_Importe float,
	@nuevaAmpliacionScub_Importe float,
	@nuevaDemolicion_Importe float,
	@nuevaModificacionInterna_Importe float,
	@nuevaPileta_Importe float,
	@nuevaObranuevaCub_Subtotal float,
	@nuevaObranuevaScub_Subtotal float,
	@nuevaAmpliacionCub_Subtotal float,
	@nuevaAmpliacionScub_Subtotal float,
	@nuevaDemolicion_Subtotal float,
	@nuevaModificacionInterna_Subtotal float,
	@nuevaPileta_Subtotal float,
	@existenteSubsistencia_Cub float,
	@existenteSubsistencia_Scub float,
	@existenteConformeObra_Cub float,
	@existenteConformeObra_Scub float,
	@existenteSubsistenciaCub_Valor float,
	@existenteSubsistenciaScub_Valor float,
	@existenteConformeObraCub_Valor float,
	@existenteConformeObraScub_Valor float,
	@existenteDemolicion_Valor float,
	@existenteModificacionInterna_Valor float,
	@existentePileta_Valor float,
	@existenteSubsistenciaCub_Importe float,
	@existenteSubsistenciaScub_Importe float,
	@existenteConformeObraCub_Importe float,
	@existenteConformeObraScub_Importe float,
	@existenteDemolicion_Importe float,
	@existenteModificacionInterna_Importe float,
	@existentePileta_Importe float,
	@existenteSubsistenciaCub_Recargo float,
	@existenteSubsistenciaScub_Recargo float,
	@existenteConformeObraCub_Recargo float,
	@existenteConformeObraScub_Recargo float,
	@existenteDemolicion_Recargo float,
	@existenteModificacionInterna_Recargo float,
	@existentePileta_Recargo float,
	@existenteSubsistenciaCub_Subtotal float,
	@existenteSubsistenciaScub_Subtotal float,
	@existenteConformeObraCub_Subtotal float,
	@existenteConformeObraScub_Subtotal float,
	@existenteDemolicion_Subtotal float,
	@existenteModificacionInterna_Subtotal float,
	@existentePileta_Subtotal float,
	@especialCubValor float,
	@especialScubValor float,
	@multifamiliarValor float,
	@galeriasValor float,
	@industriaValor float,
	@emprendimientosUrbanosValor float,
	@ambientalCubValor float,
	@ambientalScubValor float,
	@especialCubImporte float,
	@especialScubImporte float,
	@multifamiliarImporte float,
	@galeriasImporte float,
	@industriaImporte float,
	@emprendimientosUrbanosImporte float,
	@ambientalCubImporte float,
	@ambientalScubImporte float,
	@especialCubSubtotal float,
	@especialScubSubtotal float,
	@multifamiliarSubtotal float,
	@galeriasSubtotal float,
	@industriaSubtotal float,
	@emprendimientosUrbanosSubtotal float,
	@ambientalCubSubtotal float,
	@ambientalScubSubtotal float,
	@canchaTenis float,
	@canchaPaddle float,
	@canchaTenisValor float,
	@canchaPaddleValor float,
	@canchaTenisSubtotal float,
	@canchaPaddleSubtotal float,
	@totalPagar float,
	@nroCuenta nvarchar(50)
	

	)
	
AS
	INSERT INTO LiquidacionDerechosConstruccion
                         (/*idLiquidacion,*/ categoria,	tipoVivienda,
	valorCategoria ,
	nuevaObranueva_Cub ,
	nuevaObranueva_Scub ,
	nuevaAmpliacion_Cub ,
	nuevaAmpliacion_Scub ,
	nuevaObranuevaCub_Valor ,
	nuevaObranuevaScub_Valor ,
	nuevaAmpliacionCub_Valor ,
	nuevaAmpliacionScub_Valor ,
	nuevaDemolicion_Valor ,
	nuevaModificacionInterna_Valor ,
	nuevaPileta_Valor ,
	nuevaObranuevaCub_Importe ,
	nuevaObranuevaScub_Importe ,
	nuevaAmpliacionCub_Importe ,
	nuevaAmpliacionScub_Importe ,
	nuevaDemolicion_Importe ,
	nuevaModificacionInterna_Importe ,
	nuevaPileta_Importe ,
	nuevaObranuevaCub_Subtotal ,
	nuevaObranuevaScub_Subtotal ,
	nuevaAmpliacionCub_Subtotal ,
	nuevaAmpliacionScub_Subtotal ,
	nuevaDemolicion_Subtotal ,
	nuevaModificacionInterna_Subtotal ,
	nuevaPileta_Subtotal ,
	existenteSubsistencia_Cub ,
	existenteSubsistencia_Scub ,
	existenteConformeObra_Cub ,
	existenteConformeObra_Scub ,
	existenteSubsistenciaCub_Valor ,
	existenteSubsistenciaScub_Valor ,
	existenteConformeObraCub_Valor ,
	existenteConformeObraScub_Valor ,
	existenteDemolicion_Valor ,
	existenteModificacionInterna_Valor ,
	existentePileta_Valor ,
	existenteSubsistenciaCub_Importe ,
	existenteSubsistenciaScub_Importe ,
	existenteConformeObraCub_Importe ,
	existenteConformeObraScub_Importe ,
	existenteDemolicion_Importe ,
	existenteModificacionInterna_Importe ,
	existentePileta_Importe ,
	existenteSubsistenciaCub_Recargo ,
	existenteSubsistenciaScub_Recargo ,
	existenteConformeObraCub_Recargo ,
	existenteConformeObraScub_Recargo ,
	existenteDemolicion_Recargo ,
	existenteModificacionInterna_Recargo ,
	existentePileta_Recargo,
	existenteSubsistenciaCub_Subtotal ,
	existenteSubsistenciaScub_Subtotal ,
	existenteConformeObraCub_Subtotal ,
	existenteConformeObraScub_Subtotal ,
	existenteDemolicion_Subtotal ,
	existenteModificacionInterna_Subtotal ,
	existentePileta_Subtotal ,
	
	especialCubValor,
	especialScubValor,
	multifamiliarValor,
	galeriasValor,
	industriaValor,
	emprendimientosUrbanosValor,
	ambientalCubValor,
	ambientalScubValor,
	especialCubImporte,
	especialScubImporte,
	multifamiliarImporte,
	galeriasImporte,
	industriaImporte,
	emprendimientosUrbanosImporte,
	ambientalCubImporte,
	ambientalScubImporte,
	especialCubSubtotal,
	especialScubSubtotal,
	multifamiliarSubtotal,
	galeriasSubtotal,
	industriaSubtotal,
	emprendimientosUrbanosSubtotal,
	ambientalCubSubtotal,
	ambientalScubSubtotal,
	canchaTenis,
	canchaPaddle,
	canchaTenisValor,
	canchaPaddleValor,
	canchaTenisSubtotal,
	canchaPaddleSubtotal,
	totalPagar,
	fecha,
	nroCuenta)
VALUES        (	/*@idLiquidacion,*/
	@categoria,
	@tipoVivienda,
	@valorCategoria ,
	@nuevaObranueva_Cub ,
	@nuevaObranueva_Scub ,
	@nuevaAmpliacion_Cub ,
	@nuevaAmpliacion_Scub ,
	@nuevaObranuevaCub_Valor ,
	@nuevaObranuevaScub_Valor ,
	@nuevaAmpliacionCub_Valor ,
	@nuevaAmpliacionScub_Valor ,
	@nuevaDemolicion_Valor ,
	@nuevaModificacionInterna_Valor ,
	@nuevaPileta_Valor ,
	@nuevaObranuevaCub_Importe ,
	@nuevaObranuevaScub_Importe ,
	@nuevaAmpliacionCub_Importe ,
	@nuevaAmpliacionScub_Importe ,
	@nuevaDemolicion_Importe ,
	@nuevaModificacionInterna_Importe ,
	@nuevaPileta_Importe ,
	@nuevaObranuevaCub_Subtotal ,
	@nuevaObranuevaScub_Subtotal ,
	@nuevaAmpliacionCub_Subtotal ,
	@nuevaAmpliacionScub_Subtotal ,
	@nuevaDemolicion_Subtotal ,
	@nuevaModificacionInterna_Subtotal ,
	@nuevaPileta_Subtotal ,
	@existenteSubsistencia_Cub ,
	@existenteSubsistencia_Scub ,
	@existenteConformeObra_Cub ,
	@existenteConformeObra_Scub ,
	@existenteSubsistenciaCub_Valor ,
	@existenteSubsistenciaScub_Valor ,
	@existenteConformeObraCub_Valor ,
	@existenteConformeObraScub_Valor ,
	@existenteDemolicion_Valor ,
	@existenteModificacionInterna_Valor ,
	@existentePileta_Valor ,
	@existenteSubsistenciaCub_Importe ,
	@existenteSubsistenciaScub_Importe ,
	@existenteConformeObraCub_Importe ,
	@existenteConformeObraScub_Importe ,
	@existenteDemolicion_Importe ,
	@existenteModificacionInterna_Importe ,
	@existentePileta_Importe ,
	@existenteSubsistenciaCub_Recargo ,
	@existenteSubsistenciaScub_Recargo ,
	@existenteConformeObraCub_Recargo ,
	@existenteConformeObraScub_Recargo ,
	@existenteDemolicion_Recargo ,
	@existenteModificacionInterna_Recargo ,
	@existentePileta_Recargo ,
	@existenteSubsistenciaCub_Subtotal ,
	@existenteSubsistenciaScub_Subtotal ,
	@existenteConformeObraCub_Subtotal ,
	@existenteConformeObraScub_Subtotal ,
	@existenteDemolicion_Subtotal ,
	@existenteModificacionInterna_Subtotal ,
	@existentePileta_Subtotal ,
	@especialCubValor,
	@especialScubValor,
	@multifamiliarValor,
	@galeriasValor,
	@industriaValor,
	@emprendimientosUrbanosValor,
	@ambientalCubValor,
	@ambientalScubValor,
	@especialCubImporte,
	@especialScubImporte,
	@multifamiliarImporte,
	@galeriasImporte,
	@industriaImporte,
	@emprendimientosUrbanosImporte,
	@ambientalCubImporte,
	@ambientalScubImporte,
	@especialCubSubtotal,
	@especialScubSubtotal,
	@multifamiliarSubtotal,
	@galeriasSubtotal,
	@industriaSubtotal,
	@emprendimientosUrbanosSubtotal,
	@ambientalCubSubtotal,
	@ambientalScubSubtotal,
	@canchaTenis,
	@canchaPaddle,
	@canchaTenisValor,
	@canchaPaddleValor,
	@canchaTenisSubtotal,
	@canchaPaddleSubtotal,
	@totalPagar,
	GetDate(),
	@nroCuenta )
	
	SELECT @@IDENTITY AS ''Identity'' 
	
	
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPactualizarFormularioDerechosConstruccion]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SPactualizarFormularioDerechosConstruccion]
	
	(
	@idLiquidacion int,
	@categoria char(1),
	@tipoVivienda nvarchar(50),
	@valorCategoria float,
	@nuevaObranueva_Cub float,
	@nuevaObranueva_Scub float,
	@nuevaAmpliacion_Cub float,
	@nuevaAmpliacion_Scub float,
	@nuevaObranuevaCub_Valor float,
	@nuevaObranuevaScub_Valor float,
	@nuevaAmpliacionCub_Valor float,
	@nuevaAmpliacionScub_Valor float,
	@nuevaDemolicion_Valor float,
	@nuevaModificacionInterna_Valor float,
	@nuevaPileta_Valor float,
	@nuevaObranuevaCub_Importe float,
	@nuevaObranuevaScub_Importe float,
	@nuevaAmpliacionCub_Importe float,
	@nuevaAmpliacionScub_Importe float,
	@nuevaDemolicion_Importe float,
	@nuevaModificacionInterna_Importe float,
	@nuevaPileta_Importe float,
	@nuevaObranuevaCub_Subtotal float,
	@nuevaObranuevaScub_Subtotal float,
	@nuevaAmpliacionCub_Subtotal float,
	@nuevaAmpliacionScub_Subtotal float,
	@nuevaDemolicion_Subtotal float,
	@nuevaModificacionInterna_Subtotal float,
	@nuevaPileta_Subtotal float,
	@existenteSubsistencia_Cub float,
	@existenteSubsistencia_Scub float,
	@existenteConformeObra_Cub float,
	@existenteConformeObra_Scub float,
	@existenteSubsistenciaCub_Valor float,
	@existenteSubsistenciaScub_Valor float,
	@existenteConformeObraCub_Valor float,
	@existenteConformeObraScub_Valor float,
	@existenteDemolicion_Valor float,
	@existenteModificacionInterna_Valor float,
	@existentePileta_Valor float,
	@existenteSubsistenciaCub_Importe float,
	@existenteSubsistenciaScub_Importe float,
	@existenteConformeObraCub_Importe float,
	@existenteConformeObraScub_Importe float,
	@existenteDemolicion_Importe float,
	@existenteModificacionInterna_Importe float,
	@existentePileta_Importe float,
	@existenteSubsistenciaCub_Recargo float,
	@existenteSubsistenciaScub_Recargo float,
	@existenteConformeObraCub_Recargo float,
	@existenteConformeObraScub_Recargo float,
	@existenteDemolicion_Recargo float,
	@existenteModificacionInterna_Recargo float,
	@existentePileta_Recargo float,
	@existenteSubsistenciaCub_Subtotal float,
	@existenteSubsistenciaScub_Subtotal float,
	@existenteConformeObraCub_Subtotal float,
	@existenteConformeObraScub_Subtotal float,
	@existenteDemolicion_Subtotal float,
	@existenteModificacionInterna_Subtotal float,
	@existentePileta_Subtotal float,
	@especialCubValor float,
	@especialScubValor float,
	@multifamiliarValor float,
	@galeriasValor float,
	@industriaValor float,
	@emprendimientosUrbanosValor float,
	@ambientalCubValor float,
	@ambientalScubValor float,
	@especialCubImporte float,
	@especialScubImporte float,
	@multifamiliarImporte float,
	@galeriasImporte float,
	@industriaImporte float,
	@emprendimientosUrbanosImporte float,
	@ambientalCubImporte float,
	@ambientalScubImporte float,
	@especialCubSubtotal float,
	@especialScubSubtotal float,
	@multifamiliarSubtotal float,
	@galeriasSubtotal float,
	@industriaSubtotal float,
	@emprendimientosUrbanosSubtotal float,
	@ambientalCubSubtotal float,
	@ambientalScubSubtotal float,
	@canchaTenis float,
	@canchaPaddle float,
	@canchaTenisValor float,
	@canchaPaddleValor float,
	@canchaTenisSubtotal float,
	@canchaPaddleSubtotal float,
	@totalPagar float,
	@nroCuenta nvarchar(50)
	)
	
AS
	Update LiquidacionDerechosConstruccion set 
	/*idLiquidacion=@idLiquidacion,*/
	categoria=@categoria,
	tipoVivienda=@tipoVivienda,
	valorCategoria=@valorCategoria,
	nuevaObranueva_Cub=@nuevaObranueva_Cub,
	nuevaObranueva_Scub=@nuevaObranueva_Scub,
	nuevaAmpliacion_Cub=@nuevaAmpliacion_Cub,
	nuevaAmpliacion_Scub=@nuevaAmpliacion_Scub,
	nuevaObranuevaCub_Valor=@nuevaObranuevaCub_Valor,
	nuevaObranuevaScub_Valor=@nuevaObranuevaScub_Valor,
	nuevaAmpliacionCub_Valor=@nuevaAmpliacionCub_Valor,
	nuevaAmpliacionScub_Valor=@nuevaAmpliacionScub_Valor,
	nuevaDemolicion_Valor=@nuevaDemolicion_Valor,
	nuevaModificacionInterna_Valor=@nuevaModificacionInterna_Valor,
	nuevaPileta_Valor=@nuevaPileta_Valor,
	nuevaObranuevaCub_Importe=@nuevaObranuevaCub_Importe,
	nuevaObranuevaScub_Importe=@nuevaObranuevaScub_Importe,
	nuevaAmpliacionCub_Importe=@nuevaAmpliacionCub_Importe,
	nuevaAmpliacionScub_Importe=@nuevaAmpliacionScub_Importe,
	nuevaDemolicion_Importe=@nuevaDemolicion_Importe,
	nuevaModificacionInterna_Importe=@nuevaModificacionInterna_Importe,
	nuevaPileta_Importe=nuevaPileta_Importe,
	nuevaObranuevaCub_Subtotal=@nuevaObranuevaCub_Subtotal,
	nuevaObranuevaScub_Subtotal=@nuevaObranuevaScub_Subtotal,
	nuevaAmpliacionCub_Subtotal=@nuevaAmpliacionCub_Subtotal,
	nuevaAmpliacionScub_Subtotal=@nuevaAmpliacionScub_Subtotal,
	nuevaDemolicion_Subtotal=@nuevaDemolicion_Subtotal,
	nuevaModificacionInterna_Subtotal=@nuevaModificacionInterna_Subtotal,
	nuevaPileta_Subtotal=@nuevaPileta_Subtotal,
	existenteSubsistencia_Cub=@existenteSubsistencia_Cub,
	existenteSubsistencia_Scub=@existenteSubsistencia_SCub,
	existenteConformeObra_Cub=@existenteConformeObra_Cub,
	existenteConformeObra_Scub=@existenteConformeObra_Scub,
	existenteSubsistenciaCub_Valor=@existenteSubsistenciaCub_Valor,
	existenteSubsistenciaScub_Valor=@existenteSubsistenciaScub_Valor,
	existenteConformeObraCub_Valor=@existenteConformeObraCub_Valor,
	existenteConformeObraScub_Valor=@existenteConformeObraScub_Valor,
	existenteDemolicion_Valor=@existenteDemolicion_Valor,
	existenteModificacionInterna_Valor=@existenteModificacionInterna_Valor,
	existentePileta_Valor=@existentePileta_Valor,
	existenteSubsistenciaCub_Importe=@existenteSubsistenciaCub_importe,
	existenteSubsistenciaScub_Importe=@existenteSubsistenciaScub_Importe,
	existenteConformeObraCub_Importe=@existenteConformeObraCub_Importe,
	existenteConformeObraScub_Importe=@existenteConformeObraScub_Importe,
	existenteDemolicion_Importe=@existenteDemolicion_Importe,
	existenteModificacionInterna_Importe=@existenteModificacionInterna_Importe,
	existentePileta_Importe=@existentePileta_Importe,
	existenteSubsistenciaCub_Recargo=@existenteSubsistenciaCub_Recargo,
	existenteSubsistenciaScub_Recargo=@existenteSubsistenciaScub_Recargo,
	existenteConformeObraCub_Recargo=@existenteConformeObraCub_Recargo,
	existenteConformeObraScub_Recargo=@existenteConformeObraScub_Recargo,
	existenteDemolicion_Recargo=@existenteDemolicion_Recargo,
	existenteModificacionInterna_Recargo=@existenteModificacionInterna_Recargo,
	existentePileta_Recargo=@existentePileta_Recargo,
	existenteSubsistenciaCub_Subtotal=@existenteSubsistenciaCub_Subtotal,
	existenteSubsistenciaScub_Subtotal=@existenteSubsistenciaScub_Subtotal,
	existenteConformeObraCub_Subtotal=@existenteConformeObraCub_Subtotal,
	existenteConformeObraScub_Subtotal=@existenteConformeObraScub_Subtotal,
	existenteDemolicion_Subtotal=@existenteDemolicion_Subtotal,
	existenteModificacionInterna_Subtotal=@existenteModificacionInterna_Subtotal,
	existentePileta_Subtotal=@existentePileta_Subtotal,
	especialCubValor=@especialCubValor ,
	especialScubValor=@especialScubValor ,
	multifamiliarValor=@multifamiliarValor ,
	galeriasValor=@galeriasValor ,
	industriaValor=@industriaValor ,
	emprendimientosUrbanosValor=@emprendimientosUrbanosValor ,
	ambientalCubValor=@ambientalCubValor ,
	ambientalScubValor=@ambientalScubValor ,
	especialCubImporte=@especialCubImporte ,
	especialScubImporte=@especialScubImporte ,
	multifamiliarImporte=@multifamiliarImporte ,
	galeriasImporte=@galeriasImporte ,
	industriaImporte =@industriaImporte ,
	emprendimientosUrbanosImporte=@emprendimientosUrbanosImporte ,
	ambientalCubImporte =@ambientalCubImporte ,
	ambientalScubImporte=@ambientalScubImporte ,
	especialCubSubtotal=@especialCubSubtotal ,
	especialScubSubtotal=@especialScubSubtotal ,
	multifamiliarSubtotal=@multifamiliarSubtotal ,
	galeriasSubtotal =@galeriasSubtotal ,
	industriaSubtotal =@industriaSubtotal ,
	emprendimientosUrbanosSubtotal =@emprendimientosUrbanosSubtotal ,
	ambientalCubSubtotal=@ambientalCubSubtotal ,
	ambientalScubSubtotal=@ambientalScubSubtotal ,
	canchaTenis=@canchaTenis,
	canchaPaddle=@canchaPaddle,
	canchaTenisValor=@canchaTenisValor,
	canchaPaddleValor=@canchaPaddleValor,
	canchaTenisSubtotal=@canchaTenisSubtotal,
	canchaPaddleSubtotal=@canchaPaddleSubtotal,
	totalPagar=@totalPagar,
	fechaActualizacion=GetDate()
	
	where idLiquidacion=@idLiquidacion
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPagregarCopiaFielPlano]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SPagregarCopiaFielPlano]
	(
	@nroCuenta nvarchar(50),
	@fecha datetime,
	@estado nvarchar(50),
	@nroPedido int,
	@tipo nvarchar(20)
	
	)
	
AS
		insert into PedidoCopiaFiel values (@nroCuenta,@fecha,@estado,@nroPedido,@tipo)
	
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPagregarPersonas]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SPagregarPersonas]
	(
	@tipoDocumento nvarchar(50),
	@nroDocumento nvarchar(10),
	@nombre nvarchar(50),
	@apellido nvarchar(50),
	@mail nvarchar(50),
	@telefono nvarchar(20),
	@direccion nvarchar(100),
	@localidad nvarchar(100),
	@ciudad nvarchar(100)
	)
	
AS
		insert into Personas values (@tipoDocumento,@nroDocumento,@nombre,@apellido,@mail,@telefono,@direccion,@localidad,@ciudad,0)
	
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[ViewTotalExpedientesXRegistrosUnpivot]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[ViewTotalExpedientesXRegistrosUnpivot]
AS
SELECT        Totales, Cantidad
FROM            (SELECT        [Todas las cuentas en SiDOP], [Todas las cuentas Registradas en SiDOP]
                          FROM            ViewTotalExpedientesXRegistrados) AS consulta UNPIVOT (Cantidad FOR Totales IN ([Todas las cuentas en SiDOP], 
                         [Todas las cuentas Registradas en SiDOP])) AS unpvt
' 
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane1' , N'SCHEMA',N'dbo', N'VIEW',N'ViewTotalExpedientesXRegistrosUnpivot', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewTotalExpedientesXRegistrosUnpivot'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPaneCount' , N'SCHEMA',N'dbo', N'VIEW',N'ViewTotalExpedientesXRegistrosUnpivot', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewTotalExpedientesXRegistrosUnpivot'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPagregarProfesionales]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SPagregarProfesionales]
	(
	@tipoDocumento nvarchar(50),
	@nroDocumento nvarchar(10),
	@nroRegistroProfesional nvarchar(50),
	@nroRegistroMunicipal nvarchar(50),
	@nroCuentaMunicipal nvarchar(50),
	@nro_cuit nvarchar(20),
	@tituloHabilitante nvarchar(50),
	@categoria nvarchar(50)
	)
	
AS
		insert into Profesionales values (@tipoDocumento,@nroDocumento,@nroRegistroProfesional,@nroRegistroMunicipal,@nroCuentaMunicipal,@nro_cuit,@tituloHabilitante,@categoria)
	
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPeliminarProfesionalXCuenta]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create PROCEDURE [dbo].[SPeliminarProfesionalXCuenta]
	(
	@nroDocumento nvarchar(10),
	@nrocuenta nvarchar(50)
	)
	
AS
		Delete from ProfesionalXcuenta where nroDocumentoProfesional=@nrodocumento and nroCuenta=@nrocuenta
	
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SPagregarProfesionalXCuenta]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create PROCEDURE [dbo].[SPagregarProfesionalXCuenta]
	(
	@nroDocumento nvarchar(10),
	@nrocuenta nvarchar(50)
	)
	
AS
		insert into ProfesionalXcuenta values (@nrodocumento, @nrocuenta)
	
	RETURN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[ViewDemoraEstadistica]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[ViewDemoraEstadistica]
AS
SELECT        COUNT(CASE WHEN [Diferencia en dias a verificado] <= 15 THEN 1 END) AS [Cantidad de verificados en menos de 15 dias], 
                         COUNT(CASE WHEN [Diferencia en dias a verificado] > 15 AND [Diferencia en dias a verificado] <= 30 THEN 1 END) 
                         AS [Cantidad de verificados con demora entre 15 y 30 dias], COUNT(CASE WHEN [Diferencia en dias a verificado] > 30 AND 
                         [Diferencia en dias a verificado] <= 45 THEN 1 END) AS [Cantidad de verificados con demora entre 30 y 45 dias], 
                         COUNT(CASE WHEN [Diferencia en dias a verificado] > 45 THEN 1 END) AS [Cantidad de verificados fuera de parametros], 
                         COUNT(CASE WHEN [Diferencia en dias a Registrado] <= 15 THEN 1 END) AS [Cantidad de registrados en menos de 15 dias], 
                         COUNT(CASE WHEN [Diferencia en dias a Registrado] > 15 AND [Diferencia en dias a Registrado] <= 30 THEN 1 END) 
                         AS [Cantidad de registrados con demora entre 15 y 30 dias], COUNT(CASE WHEN [Diferencia en dias a Registrado] > 30 AND 
                         [Diferencia en dias a Registrado] <= 45 THEN 1 END) AS [Cantidad de registrado con demora entre 30 y 45 dias], 
                         COUNT(CASE WHEN [Diferencia en dias a Registrado] > 45 THEN 1 END) AS [Cantidad de registrados fuera de parametros]
FROM            dbo.Estadistica1
' 
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane1' , N'SCHEMA',N'dbo', N'VIEW',N'ViewDemoraEstadistica', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[33] 4[16] 2[17] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Estadistica1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 307
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 3705
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2715
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewDemoraEstadistica'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPaneCount' , N'SCHEMA',N'dbo', N'VIEW',N'ViewDemoraEstadistica', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewDemoraEstadistica'
