
CREATE PROCEDURE [dbo].[spSeleccionaAnalisisProducto]
	@producto	varchar(50),
	@empresa int
	
AS
/***************************************************************************
Nombre: spSeleccionaAnalisisProducto
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Producto
Argumentos de salida: 
Descripción: Selecciona los análisis registrados para el producto seleccionado.
*****************************************************************************/

	select a.producto producto,a.movimiento  analisis,b.descripcion descripcion, 0 valor
	from pProductoMovimiento a
	join iItems b on b.codigo=a.movimiento and b.empresa=a.empresa
	where
	a.producto = @producto
	and a.empresa=@empresa