
CREATE PROCEDURE [dbo].[spSeleccionaProductoTransaccion]
	@transaccion	varchar(50),
	@empresa int
AS
/***************************************************************************
Nombre: spSeleccionaProductoTransaccion
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia S.A.S
*****************************************************************************/

	select a.producto,b.descripcion
	from gTipoTransaccionProducto a join iItems b on a.producto=b.codigo
	and a.empresa=b.empresa
	where
	a.tipo = @transaccion and
	a.empresa=@empresa
	order by b.codigo