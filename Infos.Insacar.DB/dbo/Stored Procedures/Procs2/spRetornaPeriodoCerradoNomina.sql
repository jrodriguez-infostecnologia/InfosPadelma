
CREATE PROCEDURE [dbo].[spRetornaPeriodoCerradoNomina]
	@año int ,
	@mes int,
	@empresa int,
	@fecha	date,
	@agro bit,
	@retorno	int output
AS
/***************************************************************************
Nombre: spRetornaPeriodoCerradoNomina
Tipo: Procedimiento Almacenado
INFOS TECNOLOGIA S.A.S
*****************************************************************************/
	set @retorno =0

	set @retorno = (select top 1 cerrado from nperiododetalle	where 	empresa = @empresa
	and @fecha between fechaInicial and fechaFinal  and agronomico=@agro)

	set @retorno = ISNULL(@retorno, 2)