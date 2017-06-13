create proc [dbo].[spVerificaTipoConceptoNomina]
@empresa int,
@tipo char(5),
@concepto char(5),
@retorno int output
as

	if exists(select * from nTipoConceptoDetalle where tipoConcepto=@tipo and concepto=@concepto and empresa=@empresa)
			set @retorno=0
	else
			set @retorno=1