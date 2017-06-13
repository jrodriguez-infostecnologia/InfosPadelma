CREATE proc [dbo].[spVerificaConceptoyGrupoIR]
@empresa int,
@grupo char(5),
@concepto char(5),
@retorno int output
as

	if exists(select * from cGrupoConceptoIR where grupo=@grupo and cocepto=@concepto and empresa=@empresa)
			set @retorno=0
	else
			set @retorno=1