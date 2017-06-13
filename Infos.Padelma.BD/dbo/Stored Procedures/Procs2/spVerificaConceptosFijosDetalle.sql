create proc [dbo].[spVerificaConceptosFijosDetalle]
@empresa int,
@centroCosto varchar(50),
@año int,@mes int,@periodo int,
@concepto varchar(50),
@retorno int output
as

	if exists(select * from nconceptosFijosDetalle where centroCosto =@centroCosto and año=@año and mes=@mes and noPeriodo=@periodo and empresa=@empresa and concepto=@concepto)
			set @retorno=0
	else
			set @retorno=1