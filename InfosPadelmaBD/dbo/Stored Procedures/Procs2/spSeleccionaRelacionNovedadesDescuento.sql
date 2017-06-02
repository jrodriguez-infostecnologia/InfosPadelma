CREATE proc [dbo].[spSeleccionaRelacionNovedadesDescuento]
 @año int ,@periodo int ,@empresa int
as
select distinct d.id codiTercero, d.codigo identificacion, d.descripcion nombreTercero,c.codigo cosConcepto, c.descripcion nombreConcepto,
b.valor
, g.codigo, a.numero,e.id
  from nNovedades a
join nNovedadesDetalle b on b.tipo=a.tipo and b.numero=a.numero and b.empresa=a.empresa
join nConcepto c on c.codigo=b.concepto and c.empresa=b.empresa
join cTercero d on d.id=b.empleado and d.empresa=b.empresa
join nContratos e on e.tercero=d.id and e.empresa=e.empresa and e.id in  (select max(id) from nContratos where tercero=d.id and empresa=c.empresa)
   join cCentrosCosto  f on f.codigo=e.ccosto and f.empresa=e.empresa and f.auxiliar=1
   join cCentrosCosto g on g.codigo=f.mayor and g.empresa=f.empresa and g.mayor is null
where  a.empresa=@empresa and @año  between b.añoInicial and b.añoFinal
			AND a.anulado=0 and b.anulado=0 and c.signo=2
			and (@periodo between   (case when b.añoInicial =@año then b.periodoInicial else 0 end) and 
			(case when b.añoFinal=@año then b.periodoFinal else 99999999 end))
union
select distinct c.id, c.codigo,c.descripcion, b.codigo,b.descripcion, valorCuotas
, g.codigo,a.codigo, e.id
from nPrestamo a
join nConcepto b on b.codigo=a.concepto and b.empresa=a.empresa
join cTercero c on c.id=a.empleado and c.empresa=a.empresa
join nContratos e on e.tercero=c.id and e.empresa=e.empresa and e.id in  (select max(id) from nContratos where tercero=c.id and empresa=c.empresa)
 join cCentrosCosto  f on f.codigo=e.ccosto and f.empresa=e.empresa and f.auxiliar=1
 join cCentrosCosto g on g.codigo=f.mayor and g.empresa=f.empresa and g.mayor is null
where a.empresa=@empresa and a.valorSaldo>0
and a.periodoInicial<= @periodo and año<=@año
order by codiTercero