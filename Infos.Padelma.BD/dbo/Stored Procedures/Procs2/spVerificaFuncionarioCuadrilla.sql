create proc [dbo].[spVerificaFuncionarioCuadrilla]
@empresa int,
@funcionario int,
@cuadrilla varchar(50) ,
@retorno int output
as

	if exists(select * from nCuadrillaFuncionario where funcionario=@funcionario and cuadrilla=@cuadrilla and empresa=@empresa)
			set @retorno=0
	else
			set @retorno=1