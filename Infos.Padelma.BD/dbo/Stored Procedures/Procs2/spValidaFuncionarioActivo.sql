create proc spValidaFuncionarioActivo
@tercero int,
@empresa int,
@retorno int output
as

if exists(select * from nFuncionario where empresa=@empresa and activo=0 and tercero=@tercero)
	set @retorno =1
else
		set @retorno =0