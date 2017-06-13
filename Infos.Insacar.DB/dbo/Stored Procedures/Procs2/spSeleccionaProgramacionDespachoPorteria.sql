
CREATE PROCEDURE [dbo].[spSeleccionaProgramacionDespachoPorteria]
	@registro	varchar(50),
	@empresa int
AS
/***************************************************************************
Nombre: spSeleccionaProgramacionDespachoPorteria
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS


Argumentos de entrada: Vehículo
Argumentos de salida:
Descripción: Selecciona la programación vigente de despachos.
*****************************************************************************/

	select a.*,b.descripcion
	from logProgramacionVehiculo a
	join iItems b on b.codigo=a.producto and b.empresa=a.empresa
	where
	numero = @registro
	and a.empresa=@empresa