
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

	declare @nroDoc		varchar(50),
			@año int,
			@mes int,
			@nroComer	varchar(50),
			@error		int,
			@fecha		datetime
			
	set @nroComer = ''		
	set @error = 0				
	set @año=YEAR(GETDATE())
	set @mes=month(GETDATE())
	set @fecha = GETDATE()
	
	execute spRetornaConsecutivoTransaccion @tipoTran,@empresa,@nroDoc output

	begin tran inserta
	
		insert logDespacho(
		año,
		mes,
		tipo,
		numero,
		tiquete,
		remision,
		remisionComercializadora,
		vehiculo,
		remolque,
		cantidad,
		producto,
		programacion,
		cliente,
		lugarEntrega,
		comercializadora,
		planta,
		fecha,
		empresa)
		select
		@año,
		@mes,
		a.tipo,
		a.numero,
		a.tiquete,
		@nroDoc,
		@nroComer,
		a.vehiculo,
		a.remolque,
		a.pesoNeto,
		a.item,
		b.programacionCarga,
		b.tercero,
		b.cliente,
		b.comercializadora,
		b.planta,
		@fecha,
		@empresa		
		from bRegistroBascula a
		join logProgramacionVehiculo b on b.despacho=a.numero and b.empresa=a.empresa and b.numero=a.remision
		where
		a.numero = @numero
		AND a.empresa=@empresa
		
		set @error = @@ERROR
		
		update gTipoTransaccion
		set
		actual = actual + 1
		where codigo = @tipoTran
		and empresa=@empresa
		
		set @error = ( @error + @@ERROR )
		
	
		update logProgramacionVehiculo
		set estado = 'D' where
		rtrim( despacho ) = rtrim( @numero )
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