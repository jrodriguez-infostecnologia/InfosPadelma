CREATE proc [dbo].[spSeleccionaLaboresFertilizacionInforme]
@empresa int,
@fechaInicial date,
@fechaFinal date
as


select a.tipo, a.numero, a.fecha fechaTra ,c.novedad , f.descripcion desNovedad ,  b.cantidad cantidad,  
g.uMedida uMedidaNovedad , sum(c.valorTotal) valorTOTAL  , b.item, e.descripcion desitem,
sum(c.cantidad) cantidadNov, c.lote , b.uMedida, b.dosis, b.pBulto pesoBulto, b.mBulto
, d.numero  +' - '+ CONVERT(varchar(50), d.fecha ) + ' hasta ' + CONVERT(varchar(50), d.fechaFinal ) referencia
from aTransaccion a join aTransaccionItem b on a.tipo=b.tipo and a.numero=b.numero and a.empresa=b.empresa 
join aTransaccionTercero c on a.tipo=c.tipo and a.numero=c.numero and a.empresa=c.empresa and c.lote=b.lote
left join aTransaccion d on d.numero=a.referencia and d.empresa=a.empresa
join iItems e on b.item = e.codigo and a.empresa=e.empresa
join aNovedad f on f.codigo=c.novedad and f.empresa=a.empresa
join aTransaccionNovedad g on g.tipo=a.tipo and g.numero=a.numero and g.empresa=a.empresa
and g.novedad = c.novedad and g.registro=c.registroNovedad and c.lote=c.lote 
and c.novedad=g.novedad and c.registroNovedad = c.registroNovedad
and c.registroNovedad=g.registroNovedad
join cTercero h on c.tercero=h.id and c.empresa=h.empresa
where a.anulado = 0  and a.empresa=@empresa
and a.fecha between @fechaInicial and @fechaFinal
group by a.tipo, a.numero, a.fecha  ,c.novedad , f.descripcion ,
b.item, e.descripcion ,
b.cantidad , c.lote , b.uMedida, d.fecha , B.dosis, B.pBulto, A.numero, A.fechaFinal, D.numero, D.fechaFinal, b.noPalmas, c.cantidad,
g.uMedida, b.mBulto