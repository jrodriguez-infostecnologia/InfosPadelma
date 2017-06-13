CREATE proc [dbo].[SpSeleccionapTransaccionDetalle]
@tipo varchar(50),
@numero varchar(50),
@empresa int
as
declare @producto int = (select producto from pTransaccion where numero=@numero and tipo=@tipo and empresa=@empresa)
declare @registro int = (select max(registro) from pTransaccionDetalle where numero=@numero and tipo=@tipo and empresa=@empresa)

select distinct a.empresa, a.tipo,a.numero,a.registro,a.año,a.mes,a.movimiento,isnull(a.valor,0) valor,b.resultado, d.descripcion,b.orden 
from pTransaccionDetalle a
join pTransaccion c on c.numero=a.numero and c.tipo=a.tipo and c.empresa=a.empresa
join iItems d on d.codigo=a.movimiento and d.empresa=a.empresa 
join pProductoMovimiento b on b.movimiento=a.movimiento and b.empresa=a.empresa and c.producto=b.producto
where a.numero=@numero
and a.tipo=@tipo
and a.empresa=@empresa
--and b.resultado=0
--and a.valor>0
--union
--select @empresa, @tipo,@numero, @registro + ROW_NUMBER() OVER(ORDER BY movimiento ASC) AS registro,null,null,b.movimiento,0 valor,b.resultado, d.descripcion,b.orden
--from pProductoMovimiento b
--join iItems d on d.codigo=b.movimiento and d.empresa=b.empresa 
--where b.empresa=@empresa and b.producto=@producto 
--and  movimiento not in (select movimiento from pTransaccionDetalle where numero=@numero and tipo=@tipo and empresa=@empresa)
order by orden asc