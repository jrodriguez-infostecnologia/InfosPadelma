
create PROCEDURE [dbo].[spSeleccionaTanquesProducto]
	@producto	varchar(50),
	@empresa int
AS
/***************************************************************************
Nombre: spSeleccionaTanquesProducto
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tenologia SAS

Argumentos de entrada: Producto
Argumentos de salida: 
Descripción: Selecciona los tanques por asignación de producto.
*****************************************************************************/

	select * from lTanque
	where
	item = @producto
	and empresa=@empresa