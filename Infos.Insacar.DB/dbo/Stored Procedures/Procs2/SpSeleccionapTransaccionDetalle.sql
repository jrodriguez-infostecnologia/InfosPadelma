CREATE proc [dbo].[SpSeleccionapTransaccionDetalle]
@tipo varchar(50),
@numero varchar(50),
@empresa int
as
declare @producto int = (select producto from pTransaccion where numero=@numero and tipo=@tipo and empresa=@empresa)

select a.empresa, a.tipo,a.numero,a.registro,a.año,a.mes,a.movimiento,a.valor,b.resultado, d.descripcion from pTransaccionDetalle a
join pTransaccion c on c.numero=a.numero and c.tipo=a.tipo and c.empresa=a.empresa
join iItems d on d.codigo=a.movimiento and d.empresa=a.empresa 
join pProductoMovimiento b on b.movimiento=a.movimiento and b.empresa=a.empresa and c.producto=b.producto
where a.numero=@numero
and a.tipo=@tipo
and a.empresa=@empresa
order by b.orden asc