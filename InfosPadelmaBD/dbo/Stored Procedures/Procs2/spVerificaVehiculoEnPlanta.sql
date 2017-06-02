
create PROCEDURE [dbo].[spVerificaVehiculoEnPlanta]
	@vehiculo	varchar(50),
	@remolque	varchar(50),
	@empresa    int,
	@retorno	int output
AS
/***************************************************************************
Nombre: spVerificaVehiculoEnPlanta
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS
Fecha: 16/03/2012

Argumentos de entrada: Vehículo
Argumentos de salida: 0 Si el vehículo no está en planta,
					  1 Si el vehículo está en planta.
Descripción: Verifica si el vehículo seleccionado está en planta.
*****************************************************************************/

	set @retorno = 0

	if( ( select COUNT(*)from bRegistroPorteria  where
		  vehiculo = @vehiculo and remolque =@remolque and empresa=@empresa  and estado = 'EP') > 0 )
	begin
		set @retorno = 1
	end