
create PROCEDURE [dbo].[spRetornaUmedidaCatalogoConsumo]
	@producto	varchar(50),
	@empresa	int,
	@uMedida	varchar(50) output
AS
/***************************************************************************
Nombre: spRetornaUmedidaCatalogo
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Producto
Argumentos de salida: 
Descripción: Retorna la unidad de medida correspondiente al producto seleccionado.
*****************************************************************************/

	select @uMedida = uMedidaConsumo 
	from iItems
	where
	codigo = @producto
	and empresa=@empresa