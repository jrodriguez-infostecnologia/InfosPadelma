CREATE proc [dbo].[spVerificaRegistroPrecios]
@año int,
@empresa int,
@retorno int output
as

if exists(select * from  anovedadloteprecio where año=@año  and empresa=@empresa) 
set @retorno=1
else
set @retorno=0