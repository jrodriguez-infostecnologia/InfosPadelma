create proc [dbo].[spVerificaAnalisisSellos]
@item int,
@empresa int,
@retorno int output
as


set @retorno = 0

if exists (select * from iItems where codigo=@item and empresa=@empresa and sello=1)
begin
set @retorno=1
end