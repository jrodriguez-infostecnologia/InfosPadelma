
CREATE PROCEDURE [dbo].[spRetornaPeriodoCerrado]
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
	set @retorno =0

	if exists (select cerrado from nperiododetalle where	año = @año and 	mes = @mes and 	empresa = @empresa and cerrado=0)
		set @retorno =0
	else
		set @retorno =1

	set @retorno = ISNULL(@retorno, 0)