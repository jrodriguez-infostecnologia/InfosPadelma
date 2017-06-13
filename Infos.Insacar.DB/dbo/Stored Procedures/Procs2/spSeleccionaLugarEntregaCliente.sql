create procedure [dbo].[spSeleccionaLugarEntregaCliente]
	@cliente	varchar(50),
	@empresa int
AS
/***************************************************************************
Nombre: spSeleccionaLugarEntregaCliente
Tipo: Procedimiento Almacenado
INFOS TECNOLOGIA S.A.S
*****************************************************************************/

	select * from cxcCliente
	where
	idtercero = @cliente