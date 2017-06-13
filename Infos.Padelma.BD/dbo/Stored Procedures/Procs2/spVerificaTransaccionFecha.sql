CREATE proc [dbo].[spVerificaTransaccionFecha]
@fecha datetime,
@empresa int,
@transaccion varchar(50),
@retorno int output
as

set @retorno = 0

if exists(
select * from pTransaccionJerarquiaAnalisis a join 
pTransaccionJerarquia b on a.tipo =b.tipo
and a.numero =b.numero and a.año=b.año and a.mes=b.mes
and a.fecha=b.fecha
where b.fecha=@fecha and a.empresa=@empresa and a.tipo=@transaccion and b.anulado=0)
set @retorno=1