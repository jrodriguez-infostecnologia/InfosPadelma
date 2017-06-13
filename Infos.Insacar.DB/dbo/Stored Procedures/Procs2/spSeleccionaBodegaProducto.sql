CREATE PROCEDURE [dbo].[spSeleccionaBodegaProducto]
	@tipo	varchar(50)	,
	@empresa int
AS
/***************************************************************************
Nombre: spSeleccionaBodegaProducto
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Producto
Argumentos de salida: 
Descripción: Selecciona las bodegas asociadas al producto seleccionado
*****************************************************************************/

	select bodega as codigo,descripcion 
	from iBodegaTipoTransaccion a
	join iBodega b on b.codigo=a.bodega and b.empresa=a.empresa
	where 	a.empresa=@empresa
	union
	select codigo,descripcion from lTanque b
	where b.empresa=@empresa 
	order by descripcion