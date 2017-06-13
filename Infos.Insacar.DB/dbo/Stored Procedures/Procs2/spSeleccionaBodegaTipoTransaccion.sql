
CREATE PROCEDURE [dbo].[spSeleccionaBodegaTipoTransaccion]
	@tipo	varchar(50),
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

	select distinct  a.codigo,a.descripcion 
	from ibodega a
	join ibodegaTipoTransaccion b on b.bodega=a.codigo and b.empresa=a.empresa
	where
	tipo=@tipo
	order by descripcion