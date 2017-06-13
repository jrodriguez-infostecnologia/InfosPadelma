CREATE PROCEDURE [dbo].[spRetornaReferenciaTipoTransaccion]
	@tipoTransaccion	varchar(50),
	@empresa			int,
	@referencia			int output
AS
/***************************************************************************
Nombre: spRetornaReferenciaTipoTransaccion
Tipo: Procedimiento Almacenado
Desarrollado: INFOS TECNOLOGIA S.A.S

*****************************************************************************/

	select @referencia = referencia
	 from gTipoTransaccion	
	where
	codigo = @tipoTransaccion 
	and empresa =@empresa