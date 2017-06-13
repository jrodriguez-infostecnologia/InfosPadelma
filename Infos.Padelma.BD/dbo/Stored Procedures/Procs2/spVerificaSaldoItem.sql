CREATE proc [dbo].[spVerificaSaldoItem]
@empresa int,
@item int,
@numero varchar(50),
@lote varchar(50),
@retorno int output
as

if exists(
select * from aTransaccionItem
where numero=@numero and empresa=@empresa and lote=@lote
and item=@item and saldo>0 )
begin
set @retorno=1
end
else
begin
set @retorno=0
end