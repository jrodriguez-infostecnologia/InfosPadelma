CREATE proc spSeleccionaLaboresPeriodo
@empresa int,
@año int,
@periodo int,
@numero varchar(50)
as


declare @fi date, @ff date
select @fi=fechaInicial, @ff=fechaFinal from nPeriodoDetalle where año=@año and noPeriodo=@periodo 
and empresa=@empresa

select a.tercero, c.codigo identificacion, c.descripcion empleado,  '' labor,'' nombreLabor, 
round(valorTotal,0) valortotal , a.concepto, b.descripcion nombreConcepto
from vSeleccionaLiquidacionDefinitiva a join
nConcepto b on a.concepto=b.codigo and a.empresa=b.empresa
join cTercero c on c.id = a.tercero and c.empresa = b.empresa
where a.año=@año and a.noPeriodo=@periodo and a.empresa=@empresa
and a.numero   like '%'+@numero+'%'
and a.concepto not in
(
select  distinct  i.codigo
from aTransaccion a 
join aTransaccionNovedad b on a.numero=b.numero and a.tipo=b.tipo and a.empresa=b.empresa 
join aTransaccionTercero c on b.numero=c.numero and b.tipo=c.tipo and b.registro=c.registroNovedad and b.empresa=c.empresa 
join aNovedad d on b.novedad = d.codigo and b.empresa=d.empresa
join cTercero e on c.tercero=e.id and e.empresa=c.empresa
join nContratos g on g.tercero=c.tercero and g.empresa=c.empresa --and g.activo=1
join aLotes h on h.codigo=c.lote and h.empresa=c.empresa
join nConcepto i on d.concepto=i.codigo and d.empresa=i.empresa
where convert(date, a.fecha) between @fi and @ff and a.empresa=@empresa
)
union

select   c.tercero, e.codigo identificacion,e.descripcion empleado, 
d.codigo labor, d.descripcion nombreLabor,
c.valorTotal , 
i.codigo concepto,
i.descripcion nombreConcepto
from aTransaccion a 
join aTransaccionNovedad b on a.numero=b.numero and a.tipo=b.tipo and a.empresa=b.empresa 
join aTransaccionTercero c on b.numero=c.numero and b.tipo=c.tipo and b.registro=c.registroNovedad and b.empresa=c.empresa 
join aNovedad d on b.novedad = d.codigo and b.empresa=d.empresa
join cTercero e on c.tercero=e.id and e.empresa=c.empresa
join nContratos g on g.tercero=c.tercero and g.empresa=c.empresa --and g.activo=1
join aLotes h on h.codigo=c.lote and h.empresa=c.empresa
join nConcepto i on d.concepto=i.codigo and d.empresa=i.empresa
where convert(date, a.fecha) between @fi and @ff and a.empresa=@empresa
and CONVERT(varchar(50), c.tercero)  in 
(select CONVERT(varchar(50), a.tercero)
from vSeleccionaLiquidacionDefinitiva a join
nConcepto b on a.concepto=b.codigo and a.empresa=b.empresa
join cTercero c on c.id = a.tercero and c.empresa = b.empresa
where a.año=@año and a.noPeriodo=@periodo and a.empresa=@empresa
and a.numero   like '%'+@numero+'%')
and a.anulado=0  and c.ejecutado=1