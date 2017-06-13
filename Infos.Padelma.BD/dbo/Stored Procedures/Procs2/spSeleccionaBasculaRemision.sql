CREATE PROCEDURE [dbo].[spSeleccionaBasculaRemision]
	@codigo	varchar(50),
	@empresa int
AS
/***************************************************************************
Nombre: spSeleccionaBasculaRemision
Tipo: Procedimiento Almacenado
INFOS TECNOLOGIA S.A.S
*****************************************************************************/

	select a.*, b.descripcion desProducto from bRegistroBascula a
	join iItems b on b.codigo=a.item and b.empresa=a.empresa
	where
	a.remision = @codigo
	and a.empresa=@empresa