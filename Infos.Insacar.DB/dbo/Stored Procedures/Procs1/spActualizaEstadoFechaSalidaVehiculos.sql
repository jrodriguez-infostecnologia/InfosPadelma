create PROCEDURE [dbo].[spActualizaEstadoFechaSalidaVehiculos]
	@vehiculo	varchar(50),
	@remolque	varchar(50),
	@empresa int,
	@retorno	int output
AS
/***************************************************************************
Nombre: spActualizaEstadoFechaSalidaVehiculos
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

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
		empresa=@empresa and 
		codigo in ( select b.remision 
					from bRegistroPorteria b
					join  bRegistroBascula c on b.numero = c.remision and b.empresa=c.empresa
					where
					b.vehiculo = @vehiculo 
					and
					(rtrim(ltrim(b.remolque))=@remolque 
					or rtrim(ltrim(b.remolque))='')  and
					b.estado = 'EP' and
					c.tiquete <> '' 	) 
					
					
				
		set @error = @@ERROR
		
		update bRegistroPorteria
		set
		fechaSalida = getdate(),
		estado = 'FP'
		where
		vehiculo = @vehiculo and
		(rtrim(ltrim(remolque))=@remolque or rtrim(ltrim(remolque))='' ) and 
		estado = 'EP'
		and empresa=@empresa
		
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