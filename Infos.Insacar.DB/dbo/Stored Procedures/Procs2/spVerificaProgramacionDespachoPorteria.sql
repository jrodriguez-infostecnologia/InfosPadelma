
CREATE PROCEDURE [dbo].[spVerificaProgramacionDespachoPorteria]
	@vehiculo	varchar(50),
	@empresa int
AS
/***************************************************************************
Nombre: spVerificaProgramacionDespachoPorteria
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Vehículo
Argumentos de salida:
Descripción: Selecciona la programación vigente de despachos.
*****************************************************************************/

	select MIN( fechaDespacho ) as fechaDespacho,MAX( numero ) as numero,vehiculo
	from logProgramacionVehiculo
	where
	 estado<>'D' and
	empresa=@empresa and
	vehiculo = @vehiculo and
	vehiculo+remolque not in ( select vehiculo+remolque from bRegistroPorteria
								  where vehiculo = @vehiculo and  estado = 'EP' and empresa=@empresa ) 
	and Convert( datetime,convert( varchar(50),fechaDespacho,103 ),103 ) between 
		Convert( datetime,convert( varchar(50),DATEADD( day,-3,GETDATE() ),103 ),103 ) and
		Convert( datetime,convert( varchar(50),GETDATE(),103 ),103 )
		
	group by vehiculo