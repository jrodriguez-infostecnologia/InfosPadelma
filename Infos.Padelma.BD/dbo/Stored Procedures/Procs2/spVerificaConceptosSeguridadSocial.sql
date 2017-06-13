create proc [dbo].[spVerificaConceptosSeguridadSocial]
@empresa int,
@tipo int,
@concepto varchar(50) ,
@retorno int output
as

	if exists(select * from nParametroSeguridadSocialDetalle   where concepto=@concepto and codigo=@tipo and empresa=@empresa)
			set @retorno=0
	else
			set @retorno=1