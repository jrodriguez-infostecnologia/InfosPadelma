create PROCEDURE [dbo].[spRetornaPeriodoCerradoAgro]
	@año int ,
	@mes int,
	@empresa int,
	@retorno	int output
AS
/***************************************************************************
Nombre: spRetornaPeriodoCerrado
Tipo: Procedimiento Almacenado
INFOS TECNOLOGIA S.A.S
*****************************************************************************/

	select @retorno = cerrado 
	from aPeriodo
	where
	año = @año and 
	mes = @mes and 
	empresa = @empresa