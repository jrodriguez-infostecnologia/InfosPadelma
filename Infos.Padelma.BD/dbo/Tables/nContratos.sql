CREATE TABLE [dbo].[nContratos] (
    [empresa]                  INT            NOT NULL,
    [id]                       INT            NOT NULL,
    [codigoTercero]            VARCHAR (50)   NOT NULL,
    [tercero]                  INT            NOT NULL,
    [cargo]                    VARCHAR (50)   NULL,
    [banco]                    VARCHAR (50)   NULL,
    [tipoContizante]           VARCHAR (50)   NULL,
    [motivoRetiro]             VARCHAR (50)   NULL,
    [turno]                    VARCHAR (50)   NULL,
    [departamento]             VARCHAR (50)   NULL,
    [ccosto]                   VARCHAR (50)   NULL,
    [tipoNomina]               VARCHAR (50)   NULL,
    [tiempoBasico]             VARCHAR (50)   NULL,
    [entidadPension]           VARCHAR (50)   NULL,
    [entidadEps]               VARCHAR (50)   NULL,
    [entidadCesantias]         VARCHAR (50)   NULL,
    [entidadCaja]              VARCHAR (50)   NULL,
    [entidadArp]               VARCHAR (50)   NULL,
    [entidadSena]              VARCHAR (50)   NULL,
    [entidadIcbf]              VARCHAR (50)   NULL,
    [fechaIngreso]             DATETIME       NULL,
    [fechaRetiro]              DATETIME       NULL,
    [fechaContratoHasta]       DATETIME       NULL,
    [fechaPrimaHasta]          DATETIME       NULL,
    [fechaVacacionesHasta]     DATETIME       NULL,
    [fechaUltimoAumento]       DATETIME       NULL,
    [fechaUltimoVacaciones]    DATETIME       NULL,
    [fechaUltimaPension]       DATETIME       NULL,
    [fechaUltimoCesantias]     DATETIME       NULL,
    [fechaContratoLey50]       DATETIME       NULL,
    [salario]                  MONEY          NOT NULL,
    [salarioAnterior]          MONEY          NOT NULL,
    [valorDeducibleRete]       MONEY          NOT NULL,
    [valorCesantiasCongeladas] MONEY          NOT NULL,
    [valorCesantiasRetiradas]  MONEY          NOT NULL,
    [valorOtrosSalud]          MONEY          NOT NULL,
    [valorSaludObligatoria]    MONEY          NOT NULL,
    [cantidadHoras]            DECIMAL (9, 6) NOT NULL,
    [pRetencion]               DECIMAL (9, 6) NOT NULL,
    [pTiempoLaborado]          DECIMAL (9, 6) NOT NULL,
    [diasPagadosVaciones]      DECIMAL (9, 6) NOT NULL,
    [personaCargo]             INT            NULL,
    [cuentaBancaria]           VARCHAR (50)   NULL,
    [formaPago]                VARCHAR (50)   NULL,
    [regimenLaboral]           INT            NULL,
    [auxilioTransporte]        INT            NULL,
    [procediimentoRete]        INT            NULL,
    [pactoColectivo]           BIT            NULL,
    [deducible]                VARCHAR (50)   NULL,
    [otrosSalud]               VARCHAR (50)   NULL,
    [salarioIntegral]          BIT            NULL,
    [tipoCuenta]               VARCHAR (50)   NULL,
    [claseContrato]            VARCHAR (50)   NOT NULL,
    [terminoContrato]          VARCHAR (1)    NOT NULL,
    [foto]                     INT            NULL,
    [observacion]              VARCHAR (50)   NULL,
    [activo]                   BIT            NOT NULL,
    [valorPrepagada]           MONEY          NOT NULL,
    [valorDependientes]        MONEY          NOT NULL,
    [fechaRegistro]            DATETIME       NOT NULL,
    [usuario]                  VARCHAR (50)   NOT NULL,
    [fechaActualizacion]       DATETIME       NULL,
    [usuarioActualizacion]     VARCHAR (50)   NULL,
    [ley50]                    BIT            CONSTRAINT [DF_nContratos_ley50] DEFAULT ((0)) NOT NULL,
    [centroTrabajo]            VARCHAR (50)   NOT NULL,
    [diasContrato]             INT            NOT NULL,
    [mSindicato]               BIT            NULL,
    [mFondoEmpleado]           BIT            NULL,
    [entidadFondoEmpleado]     VARCHAR (50)   NULL,
    [entidadSindicato]         VARCHAR (50)   NULL,
    [pFondoEmpleado]           FLOAT (53)     NULL,
    [pSindicato]               FLOAT (53)     NULL,
    [subTipoCotizante]         VARCHAR (50)   NULL,
    [entidadSaludAdicional]    VARCHAR (50)   NULL,
    [manejaDestajo]            BIT            NULL,
    [grupoLaborDestajo]        VARCHAR (50)   NULL,
    [cantidadDestajo]          INT            NULL,
    CONSTRAINT [PK_nContratos] PRIMARY KEY CLUSTERED ([empresa] ASC, [id] ASC, [codigoTercero] ASC, [tercero] ASC),
    CONSTRAINT [FK_nContratos_cCentrosCosto] FOREIGN KEY ([empresa], [ccosto]) REFERENCES [dbo].[cCentrosCosto] ([empresa], [codigo]),
    CONSTRAINT [FK_nContratos_gFormaPago] FOREIGN KEY ([empresa], [formaPago]) REFERENCES [dbo].[gFormaPago] ([empresa], [codigo]),
    CONSTRAINT [FK_nContratos_nCargo] FOREIGN KEY ([empresa], [cargo]) REFERENCES [dbo].[nCargo] ([empresa], [codigo]),
    CONSTRAINT [FK_nContratos_nClaseContrato] FOREIGN KEY ([empresa], [claseContrato]) REFERENCES [dbo].[nClaseContrato] ([empresa], [codigo]),
    CONSTRAINT [FK_nContratos_nDepartamento] FOREIGN KEY ([empresa], [departamento]) REFERENCES [dbo].[nDepartamento] ([empresa], [codigo]),
    CONSTRAINT [FK_nContratos_nEntidadAfc] FOREIGN KEY ([empresa], [entidadCesantias]) REFERENCES [dbo].[nEntidadAfc] ([empresa], [codigo]),
    CONSTRAINT [FK_nContratos_nEntidadCaja] FOREIGN KEY ([empresa], [entidadCaja]) REFERENCES [dbo].[nEntidadCaja] ([empresa], [codigo]),
    CONSTRAINT [FK_nContratos_nEntidadEps] FOREIGN KEY ([empresa], [entidadEps]) REFERENCES [dbo].[nEntidadEps] ([empresa], [codigo]),
    CONSTRAINT [FK_nContratos_nEntidadFondoPension] FOREIGN KEY ([empresa], [entidadPension]) REFERENCES [dbo].[nEntidadFondoPension] ([empresa], [codigo]),
    CONSTRAINT [FK_nContratos_nFuncionario] FOREIGN KEY ([empresa], [tercero]) REFERENCES [dbo].[nFuncionario] ([empresa], [tercero]),
    CONSTRAINT [FK_nContratos_nSubTipoCotizante] FOREIGN KEY ([empresa], [subTipoCotizante]) REFERENCES [dbo].[nSubTipoCotizante] ([empresa], [codigo]),
    CONSTRAINT [FK_nContratos_nTipoCotizante] FOREIGN KEY ([empresa], [tipoContizante]) REFERENCES [dbo].[nTipoCotizante] ([empresa], [codigo])
);


GO
-- =============================================
-- Author:		Infos tecnologia S.A.S
-- Create date: 09/03/2016
-- Description:	Guarda el log de la tabla de contratos
-- =============================================
CREATE TRIGGER [dbo].[trgnContratos]
   ON  [dbo].[nContratos]
   AFTER  INSERT,DELETE,UPDATE
AS 
BEGIN

			

CREATE TABLE #TmplogContratosI(
	[empresa] [int] NOT NULL,
	[id] [int] NOT NULL,
	[codigoTercero] [varchar](50) NOT NULL,
	[tercero] [int] NOT NULL,
	[cargo] [varchar](50) NULL,
	[banco] [varchar](50) NULL,
	[tipoContizante] [varchar](50) NULL,
	[motivoRetiro] [varchar](50) NULL,
	[turno] [varchar](50) NULL,
	[departamento] [varchar](50) NULL,
	[ccosto] [varchar](50) NULL,
	[tipoNomina] [varchar](50) NULL,
	[tiempoBasico] [varchar](50) NULL,
	[entidadPension] [varchar](50) NULL,
	[entidadEps] [varchar](50) NULL,
	[entidadCesantias] [varchar](50) NULL,
	[entidadCaja] [varchar](50) NULL,
	[entidadArp] [varchar](50) NULL,
	[entidadSena] [varchar](50) NULL,
	[entidadIcbf] [varchar](50) NULL,
	[fechaIngreso] [datetime] NULL,
	[fechaRetiro] [datetime] NULL,
	[fechaContratoHasta] [datetime] NULL,
	[fechaPrimaHasta] [datetime] NULL,
	[fechaVacacionesHasta] [datetime] NULL,
	[fechaUltimoAumento] [datetime] NULL,
	[fechaUltimoVacaciones] [datetime] NULL,
	[fechaUltimaPension] [datetime] NULL,
	[fechaUltimoCesantias] [datetime] NULL,
	[fechaContratoLey50] [datetime] NULL,
	[salario] [money] NOT NULL,
	[salarioAnterior] [money] NOT NULL,
	[valorDeducibleRete] [money] NOT NULL,
	[valorCesantiasCongeladas] [money] NOT NULL,
	[valorCesantiasRetiradas] [money] NOT NULL,
	[valorOtrosSalud] [money] NOT NULL,
	[valorSaludObligatoria] [money] NOT NULL,
	[cantidadHoras] [decimal](9, 6) NOT NULL,
	[pRetencion] [decimal](9, 6) NOT NULL,
	[pTiempoLaborado] [decimal](9, 6) NOT NULL,
	[diasPagadosVaciones] [decimal](9, 6) NOT NULL,
	[personaCargo] [int] NULL,
	[cuentaBancaria] [varchar](50) NULL,
	[formaPago] [varchar](50) NULL,
	[regimenLaboral] [int] NULL,
	[auxilioTransporte] [int] NULL,
	[procediimentoRete] [int] NULL,
	[pactoColectivo] [bit] NULL,
	[deducible] [varchar](50) NULL,
	[otrosSalud] [varchar](50) NULL,
	[salarioIntegral] [bit] NULL,
	[tipoCuenta] [varchar](50) NULL,
	[claseContrato] [varchar](50) NOT NULL,
	[terminoContrato] [varchar](1) NOT NULL,
	[foto] [int] NULL,
	[observacion] [varchar](50) NULL,
	[activo] [bit] NOT NULL,
	[valorPrepagada] [money] NOT NULL,
	[valorDependientes] [money] NOT NULL,
	[fechaRegistro] [datetime] NOT NULL,
	[usuario] [varchar](50) NOT NULL,
	[fechaActualizacion] [datetime] NULL,
	[usuarioActualizacion] [varchar](50) NULL,
	[ley50] [bit] NOT NULL,
	[centroTrabajo] [varchar](50) NOT NULL,
	[diasContrato] [int] NOT NULL,
	[mSindicato] [bit] NULL,
	[mFondoEmpleado] [bit] NULL,
	[entidadFondoEmpleado] [varchar](50) NULL,
	[entidadSindicato] [varchar](50) NULL,
	[pFondoEmpleado] [float] NULL,
	[pSindicato] [float] NULL,
	[subTipoCotizante] [varchar](50) NULL,
	[entidadSaludAdicional] [varchar](50) NULL,
	[manejaDestajo] [bit] NULL,
	[grupoLaborDestajo] [varchar](50) NULL,
	[cantidadDestajo] [int] NULL) 
CREATE TABLE #TmplogContratosD(
	[empresa] [int] NOT NULL,
	[id] [int] NOT NULL,
	[codigoTercero] [varchar](50) NOT NULL,
	[tercero] [int] NOT NULL,
	[cargo] [varchar](50) NULL,
	[banco] [varchar](50) NULL,
	[tipoContizante] [varchar](50) NULL,
	[motivoRetiro] [varchar](50) NULL,
	[turno] [varchar](50) NULL,
	[departamento] [varchar](50) NULL,
	[ccosto] [varchar](50) NULL,
	[tipoNomina] [varchar](50) NULL,
	[tiempoBasico] [varchar](50) NULL,
	[entidadPension] [varchar](50) NULL,
	[entidadEps] [varchar](50) NULL,
	[entidadCesantias] [varchar](50) NULL,
	[entidadCaja] [varchar](50) NULL,
	[entidadArp] [varchar](50) NULL,
	[entidadSena] [varchar](50) NULL,
	[entidadIcbf] [varchar](50) NULL,
	[fechaIngreso] [datetime] NULL,
	[fechaRetiro] [datetime] NULL,
	[fechaContratoHasta] [datetime] NULL,
	[fechaPrimaHasta] [datetime] NULL,
	[fechaVacacionesHasta] [datetime] NULL,
	[fechaUltimoAumento] [datetime] NULL,
	[fechaUltimoVacaciones] [datetime] NULL,
	[fechaUltimaPension] [datetime] NULL,
	[fechaUltimoCesantias] [datetime] NULL,
	[fechaContratoLey50] [datetime] NULL,
	[salario] [money] NOT NULL,
	[salarioAnterior] [money] NOT NULL,
	[valorDeducibleRete] [money] NOT NULL,
	[valorCesantiasCongeladas] [money] NOT NULL,
	[valorCesantiasRetiradas] [money] NOT NULL,
	[valorOtrosSalud] [money] NOT NULL,
	[valorSaludObligatoria] [money] NOT NULL,
	[cantidadHoras] [decimal](9, 6) NOT NULL,
	[pRetencion] [decimal](9, 6) NOT NULL,
	[pTiempoLaborado] [decimal](9, 6) NOT NULL,
	[diasPagadosVaciones] [decimal](9, 6) NOT NULL,
	[personaCargo] [int] NULL,
	[cuentaBancaria] [varchar](50) NULL,
	[formaPago] [varchar](50) NULL,
	[regimenLaboral] [int] NULL,
	[auxilioTransporte] [int] NULL,
	[procediimentoRete] [int] NULL,
	[pactoColectivo] [bit] NULL,
	[deducible] [varchar](50) NULL,
	[otrosSalud] [varchar](50) NULL,
	[salarioIntegral] [bit] NULL,
	[tipoCuenta] [varchar](50) NULL,
	[claseContrato] [varchar](50) NOT NULL,
	[terminoContrato] [varchar](1) NOT NULL,
	[foto] [int] NULL,
	[observacion] [varchar](50) NULL,
	[activo] [bit] NOT NULL,
	[valorPrepagada] [money] NOT NULL,
	[valorDependientes] [money] NOT NULL,
	[fechaRegistro] [datetime] NOT NULL,
	[usuario] [varchar](50) NOT NULL,
	[fechaActualizacion] [datetime] NULL,
	[usuarioActualizacion] [varchar](50) NULL,
	[ley50] [bit] NOT NULL,
	[centroTrabajo] [varchar](50) NOT NULL,
	[diasContrato] [int] NOT NULL,
	[mSindicato] [bit] NULL,
	[mFondoEmpleado] [bit] NULL,
	[entidadFondoEmpleado] [varchar](50) NULL,
	[entidadSindicato] [varchar](50) NULL,
	[pFondoEmpleado] [float] NULL,
	[pSindicato] [float] NULL,
	[subTipoCotizante] [varchar](50) NULL,
	[entidadSaludAdicional] [varchar](50) NULL,
	[manejaDestajo] [bit] NULL,
	[grupoLaborDestajo] [varchar](50) NULL,
	[cantidadDestajo] [int] NULL) 

		insert #TmplogContratosI 
			select * from inserted

			insert #TmplogContratosD
			select * from deleted

declare @id int, @nombreColumna varchar(8000)
	declare @valorNuevo varchar(8000)
			declare @valorAnterior varchar(8000)
			declare @tercero varchar(50)
			declare @empresa varchar(50)
			declare @idContrato varchar(50)
			declare @cadena nvarchar(1000)
			declare @cadena2 nvarchar(1000) 
			declare @ParmDefinition nvarchar(1000)
			declare @ParmDefinition2 nvarchar(1000) 
			declare @movimiento varchar(100) ='insertar'


	-- update
	if exists ( select * from nContratos where  convert(varchar(50), empresa) + 	CONVERT(varchar(50),id )  + CONVERT(varchar(50),tercero) 
	in 	
	( select convert(varchar(50), empresa) + 	CONVERT(varchar(50),id ) + CONVERT(varchar(50),tercero)   from inserted )  and exists(select * from deleted) )

	begin
	set @id= (select count(*) +1 from sLogNomina where empresa in (select empresa from inserted))

	insert sLogNomina
	select a.empresa, @id, a.usuario, b.descripcion, getdate(), 'Contratos','Actualizacion'   from nContratos a join 
	 inserted c on a.empresa=c.empresa and c.id=a.id and a.tercero=c.tercero	
	 join sUsuarios b on a.usuario = b.usuario
	 set @movimiento ='actualiza'
	end	else 	if exists ( select * from nContratos where  convert(varchar(50), empresa) + 	CONVERT(varchar(50),id )  + CONVERT(varchar(50),tercero) 
	in 	
	( select convert(varchar(50), empresa) + 	CONVERT(varchar(50),id ) + CONVERT(varchar(50),tercero)   from inserted )  and not exists(select * from deleted) )

	begin
	set @id= (select count(*) +1 from sLogNomina where empresa in (select empresa from inserted))

		insert sLogNomina
		select a.empresa,@id, a.usuario, b.descripcion, getdate(), 'Contratos','Insercion'   from nContratos a join 
		 inserted c on a.empresa=c.empresa and c.id=a.id and a.tercero=c.tercero	
		 join sUsuarios b on a.usuario = b.usuario
		 set @movimiento ='inserta'
	end
		else
			begin
			set @id= (select count(*) +1 from sLogNomina where empresa in (select empresa from deleted))

			insert sLogNomina
			select c.empresa, @id,c.usuario, (select top 1 descripcion from  sUsuarios b where usuario=c.usuario), getdate(), 'Contratos','Eliminacion'   from 
			deleted c 

			set @movimiento ='eliminar'
			end
		

			DECLARE curColumnas CURSOR FOR 
			SELECT c.name 
			FROM sys.columns c JOIN sys.tables t 
			ON c.object_id = t.object_id
			WHERE t.name = 'ncontratos'

			OPEN curColumnas

			FETCH NEXT FROM curColumnas 
			INTO @nombreColumna

			WHILE @@FETCH_STATUS = 0
			BEGIN

			set @cadena  = 'select @valorNuevoOut =c.' +  @nombreColumna + ' from #TmplogContratosI c'
			set @cadena2  = 'select @valorNuevoOut = c.' +  @nombreColumna + ' from #TmplogContratosD c '
			
			set @ParmDefinition  = N'@valorNuevoOut nvarchar(1000) OUTPUT'
			EXECUTE sp_executesql 
			@cadena,
			@ParmDefinition,
			@valorNuevoOut=@valorNuevo OUTPUT

			set @ParmDefinition2  = N'@valorNuevoOut nvarchar(1000) OUTPUT'
			EXECUTE sp_executesql
			@cadena2,
			@ParmDefinition2,
			@valorNuevoOut=@valorAnterior OUTPUT


			if @movimiento='inserta'
			begin
			insert sLogNominaDetalle
			select c.empresa, @id, 'Contratos', @nombreColumna , @valorAnterior, @valorNuevo, c.usuario  from 
			 #TmplogContratosI c 
			 --join sUsuarios b on c.usuario = b.usuario
			end
			else
			if  @movimiento='actualiza'
			begin
			insert sLogNominaDetalle
			select c.empresa, @id, 'Contratos', @nombreColumna , @valorAnterior, @valorNuevo, c.usuario  from 
			 #TmplogContratosI c 
			 --join sUsuarios b on c.usuario = b.usuario
			end
			else
			 if @movimiento='eliminar'
			begin 
			insert sLogNominaDetalle
			select c.empresa, @id, 'Contratos', @nombreColumna , @valorAnterior, @valorNuevo, c.usuario  from 
			 #TmplogContratosD c 
			 -- join sUsuarios b on c.usuario = b.usuario
			end

			
			FETCH NEXT FROM curColumnas 
			INTO @nombreColumna
			end

			CLOSE curColumnas
			DEALLOCATE curColumnas

			drop table #TmplogContratosI
			drop table #TmplogContratosD


END