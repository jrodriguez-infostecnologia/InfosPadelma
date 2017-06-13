
create proc [dbo].[spRetornaDiasVacaciones]
@empresa int,
@retorno int output
as



select @retorno =diasVacaciones from nparametrosgeneral
where empresa=@empresa

if @retorno is null
set @retorno=15