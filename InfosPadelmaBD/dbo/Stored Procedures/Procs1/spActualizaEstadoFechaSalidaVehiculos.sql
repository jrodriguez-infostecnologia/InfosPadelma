CREATE procedure [dbo].[spActualizaEstadoFechaSalidaVehiculos]
	@vehiculo	varchar(50),
	@remolque	varchar(50),
	@empresa	int,
	@retorno	int output
AS
/***************************************************************************
Nombre: spActualizaEstadoFechaSalidaVehiculos
Tipo: Procedimiento Almacenado
Desarrollado: Infos tecnologia S.A.S
Fecha: 11/12/2015

Argumentos de entrada: Placa vehículo
Argumentos de salida: 
Descripción: Actualiza la fecha de salida y el estado en la tabla registro de
			 portería
*****************************************************************************/

	declare @error int
	
	set @error = 0

	begin tran Actualiza
		
		

		update logCarnetDespacho
		set
		estado = 'A'
		where
		codigo in ( select b.remision 
					from bRegistroPorteria b,bRegistroBascula c
					where
					b.vehiculo = @vehiculo 
					and b.empresa=c.empresa
					and
					(rtrim(ltrim(b.remolque))=@remolque 
					or rtrim(ltrim(b.remolque))='')  
					and c.empresa=@empresa 
					and
					b.estado = 'EP' and
					b.numero = c.remision and
					c.tiquete <> '' 
					) 
					
					
				
		set @error = @@ERROR
		
		update bRegistroPorteria
		set
		fechaSalida = getdate(),
		estado = 'FP'
		where
		vehiculo = @vehiculo and
		(rtrim(ltrim(remolque))=@remolque or rtrim(ltrim(remolque))='' ) and 
		estado = 'EP' and empresa=@empresa
		
		set @error = ( @error + @@ERROR )

	if( @error = 0 )
	begin
		commit tran Actualiza
		set @retorno = 0
	end
	else
	begin
		rollback tran Actualiza
		set @retorno = 1
	end