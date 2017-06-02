CREATE PROCEDURE [dbo].[spSeleccionaBodegaTipoTransaccion]
	@tipo	varchar(50),
	@item varchar(50),
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
--select @item
	select   a.codigo,a.descripcion , c.item,tipo , a.empresa
	from ibodega a
	join ibodegaTipoTransaccion b on b.bodega=a.codigo and b.empresa=a.empresa
	join iItemsBodega c on  c.bodega=a.codigo COLLATE Modern_Spanish_CI_AS and c.empresa=a.empresa 
	where
	tipo=@tipo and a.empresa=@empresa and convert(int,c.item) = @item
	order by descripcion