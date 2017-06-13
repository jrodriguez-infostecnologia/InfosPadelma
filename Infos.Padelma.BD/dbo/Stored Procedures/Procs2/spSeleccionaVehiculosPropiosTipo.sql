CREATE PROCEDURE [dbo].[spSeleccionaVehiculosPropiosTipo]
	@tipo	char(1), 
	@empresa int
AS
/***************************************************************************
Nombre: spSeleccionaVehiculosPropiosTipo
Tipo: Procedimiento Almacenado
INFOS TECNOLOGIA S.A.S

Argumentos de entrada: Tipo de vehículo
Argumentos de salida: 
Descripción: Selecciona los vehículos propios por tipo
*****************************************************************************/

	select * from bVehiculo
	where
	tipo = @tipo and 
	empresa = @empresa
	
	order by codigo