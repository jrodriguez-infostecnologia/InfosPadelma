CREATE proc [dbo].[spVerificaAnalisisItems]
@empresa int,
@analisis varchar(50),
@item int ,
@retorno int output
as

	if exists(select * from lAnalisisItem where item=@item and analisis=@analisis and empresa=@empresa)
			set @retorno=0
	else
			set @retorno=1