CREATE proc [dbo].[spValidaParametrosGeneralEmpresa]
@empresa int,
@retorno int output
as

if exists(select * from nParametrosGeneral where empresa=@empresa)
	set @retorno=1
else
set @retorno=0