
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

	select a.item producto,a.analisis,b.descripcion descripcion
	from lAnalisisItem a
	join lAnalisis b on b.codigo=a.analisis and b.empresa=a.empresa
	where
	a.item = @producto
	and a.empresa=@empresa