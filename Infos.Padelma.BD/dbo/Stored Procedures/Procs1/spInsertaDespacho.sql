CREATE PROCEDURE [dbo].[spInsertaDespacho]
	@numero		varchar(50),
	@tipoTran	varchar(50),
	@empresa	int,
	@retorno	int output
AS
/***************************************************************************
Nombre: spInsertaDespacho
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS
Fecha: 16/12/2014

Argumentos de entrada: Código interno de transacci'on
Argumentos de salida: 0 Si es exitoso,
					  1 Si no es exitoso
Descripción: Crea el despacho seleccionado
*****************************************************************************/
	begin tran inserta

	declare @nroDoc		varchar(50),
			@año int,
			@mes int,
			@nroComer	varchar(50),
			@error		int,
			@fecha		datetime,
			@planta int,
			@OrdenSalida varchar(50) =(select  ordenSalida from gParametrosGenerales where empresa=@empresa),
			@nroOS varchar(50),
			@motivoOSA varchar(100)

	set @nroOS=''
	set @nroComer = ''		
	set @error = 0				
	set @año=YEAR(GETDATE())
	set @mes=month(GETDATE())
	set @fecha = GETDATE()
	
	execute spRetornaConsecutivoTransaccion @tipoTran,@empresa,@nroDoc output
		
	if( exists( select * from  gTipoTransaccion a	where a.codigo in (@OrdenSalida) and a.empresa=@empresa and activo=1   ))
	begin 
		execute spRetornaConsecutivoTransaccion @OrdenSalida,@empresa,@nroOS output
	   set @motivoOSA = UPPER ('Despacho producto terminado')
		update gTipoTransaccion
		set
		actual = actual + 1
		where
		codigo = @OrdenSalida
		and empresa=@empresa

		update bRegistroBascula
		set fechaOS= getdate(),
		usuarioOS = null,
		estado = 'OS'
		where tiquete=@numero and empresa=@empresa
	end          

	declare @tercero varchar(50)

	set @planta = isnull((select a.planta from logProgramacionVehiculo a join bRegistroBascula b on a.numero=b.remision and a.empresa=b.empresa where b.tiquete=@numero),'')
	set @tercero = isnull((select a.tercero from logProgramacionVehiculo a join bRegistroBascula b on a.numero=b.remision and a.empresa=b.empresa where b.tiquete=@numero),'')



	update bRegistroBascula
	set remisionplanta=@nroDoc,
	remisionComercializadora= @nroComer,
	planta= @planta,
	saldo=pesoNeto,
	ordenSalida=@nroOS,
	motivoOS= @motivoOSA,
	tercero=@tercero
	where empresa=@empresa 
	and tiquete=@numero

		set @error = @@ERROR
		
		update gTipoTransaccion	set
		actual = actual + 1
		where
		codigo = @tipoTran
		AND empresa=@empresa
		set @error = ( @error + @@ERROR )
		
		update logProgramacionVehiculo set
		estado = 'D',
		despacho=(select top 1 numero from bRegistroBascula where empresa=@empresa and tiquete =@numero)
		where
		 numero  in  (select remision from bRegistroBascula where empresa=@empresa and tiquete =@numero)
		AND empresa=@empresa
		
		set @error = ( @error + @@ERROR )
		
	if( @error = 0 )
	begin
		commit tran Inserta
		set @retorno = 0
	end		
	else
	begin
		rollback tran Inserta
		set @retorno = 1
	end