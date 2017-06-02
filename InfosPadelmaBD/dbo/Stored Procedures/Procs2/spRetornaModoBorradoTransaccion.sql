CREATE PROCEDURE [dbo].[spRetornaModoBorradoTransaccion]
	@tipoTransaccion	varchar(50),
	@empresa			int,
	@tipoBorrado		char(1) output
AS
/***************************************************************************
Nombre: spRetornaModoBorradoTransaccion
Tipo: Procedimiento Almacenado
INFOS TECNOLOGIA S.A.S
*****************************************************************************/

	select @tipoBorrado = modoAnulacion
	from gTipoTransaccion
	where
	codigo = @tipoTransaccion and empresa=@empresa

	if( @tipoBorrado is null )
		set @tipoBorrado = ''