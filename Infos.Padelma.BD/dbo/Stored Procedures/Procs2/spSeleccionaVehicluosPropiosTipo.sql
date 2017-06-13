
create PROCEDURE [dbo].[spSeleccionaVehicluosPropiosTipo]
	@empresa int,
	@codigo	varchar(50),
	@tipo	char(1)
AS
/***************************************************************************
Nombre: spSeleccionaVehicluosPropiosTipo
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia
Fecha: 12/11/2014

Argumentos de entrada: Vehículo, tipo de vehículo
Argumentos de salida: 
Descripción: Selecciona los vehículos propios por código y tipo
*****************************************************************************/

	select * from bVehiculo
	where
	codigo = @codigo and
	tipo = @tipo
	and empresa=@empresa