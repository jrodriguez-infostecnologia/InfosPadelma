CREATE proc spSeleccionaDiferenciasCosecha
 @empresa int , @año int, @mes int
 as

 declare @total int = (select  sum(d.cantidad) kilos  from aTransaccion a
join aTransaccionNovedad b on b.numero=a.numero and b.empresa=a.empresa and b.tipo=a.tipo
join aTransaccionBascula c on c.empresa=a.empresa and c.numero=a.numero and c.tipo=a.tipo
join aTransaccionTercero d on d.empresa=b.empresa and d.numero=b.numero and d.tipo=b.tipo and d.registroNovedad=b.registro
join aLotes e on e.codigo=d.lote and e.empresa=d.empresa
join aNovedad f on f.codigo=d.novedad and f.empresa=d.empresa and f.claseLabor=2
where a.empresa=@empresa and a.anulado=0 and a.año=@año and a.mes=@mes)

select 0 tipo,d.lote,e.añoSiembra, sum(d.cantidad) kilos, DATEDIFF(day,b.fecha,c.fecha) dias, a.año,a.mes,dbo.fRetornaNombreMes(a.mes) nombreMes from aTransaccion a
join aTransaccionNovedad b on b.numero=a.numero and b.empresa=a.empresa and b.tipo=a.tipo
join aTransaccionBascula c on c.empresa=a.empresa and c.numero=a.numero and c.tipo=a.tipo
join aTransaccionTercero d on d.empresa=b.empresa and d.numero=b.numero and d.tipo=b.tipo and d.registroNovedad=b.registro
join aLotes e on e.codigo=d.lote and e.empresa=d.empresa
join aNovedad f on f.codigo=d.novedad and f.empresa=d.empresa and f.claseLabor=2
where a.empresa=@empresa and a.anulado=0 and a.año=@año and a.mes=@mes
group by d.lote,e.añoSiembra,DATEDIFF(day,b.fecha,c.fecha),a.año,a.mes

union 

select 1 tipo , 'Total por dia ',0, sum(d.cantidad) kilos, DATEDIFF(day,b.fecha,c.fecha) dias, a.año,a.mes,dbo.fRetornaNombreMes(a.mes) nombreMes from aTransaccion a
join aTransaccionNovedad b on b.numero=a.numero and b.empresa=a.empresa and b.tipo=a.tipo
join aTransaccionBascula c on c.empresa=a.empresa and c.numero=a.numero and c.tipo=a.tipo
join aTransaccionTercero d on d.empresa=b.empresa and d.numero=b.numero and d.tipo=b.tipo and d.registroNovedad=b.registro
join aLotes e on e.codigo=d.lote and e.empresa=d.empresa
join aNovedad f on f.codigo=d.novedad and f.empresa=d.empresa and f.claseLabor=2
where a.empresa=@empresa and a.anulado=0 and a.año=@año and a.mes=@mes
group by DATEDIFF(day,b.fecha,c.fecha),a.año,a.mes
union
select 2 tipo, 'Promedio',0, (sum(d.cantidad)/@total)*100 kilos, DATEDIFF(day,b.fecha,c.fecha) dias, a.año,a.mes,dbo.fRetornaNombreMes(a.mes) nombreMes from aTransaccion a
join aTransaccionNovedad b on b.numero=a.numero and b.empresa=a.empresa and b.tipo=a.tipo
join aTransaccionBascula c on c.empresa=a.empresa and c.numero=a.numero and c.tipo=a.tipo
join aTransaccionTercero d on d.empresa=b.empresa and d.numero=b.numero and d.tipo=b.tipo and d.registroNovedad=b.registro
join aLotes e on e.codigo=d.lote and e.empresa=d.empresa
join aNovedad f on f.codigo=d.novedad and f.empresa=d.empresa and f.claseLabor=2
where a.empresa=@empresa and a.anulado=0 and a.año=@año and a.mes=@mes
group by DATEDIFF(day,b.fecha,c.fecha),a.año,a.mes