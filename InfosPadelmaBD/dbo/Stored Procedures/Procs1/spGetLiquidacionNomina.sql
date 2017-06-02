CREATE proc [dbo].[spGetLiquidacionNomina]
@noPeriodo int,
@empresa int
as

select a.*, case when a.signo=1 then 'DEVENGADO'
ELSE 'DEDUCCIONES' END signoLiquidacion, b.codigo codTercero ,b.descripcion DesTercero, c.descripcion DesConcepto ,
a.cantidad*a.valor  valorTotal, 
case when a.signo=2 then null
else a.cantidad end  cantidadTotal,
e.fechaInicial, e.fechaFinal,
g.descripcion cargo,
h.descripcion ccosto,
i.razonSocial Desempresa
from
tmpliquidacionNomina a 
 join ctercero b on a.tercero=b.id and a.empresa=b.empresa
 join nConcepto c on a.concepto=c.codigo  and c.empresa=a.empresa
join nPeriodoDetalle e on e.año=a.año and e.mes=a.mes and e.empresa=a.empresa  and e.noPeriodo=a.noPeriodo
left join ncontratos f on f.tercero=a.tercero and f.empresa= a.empresa
left join nCargo g on f.cargo=g.codigo and g.empresa=f.empresa
left join cCentrosCosto h on f.ccosto = h.codigo and f.empresa=h.empresa
left join gEmpresa i on a.empresa=i.id
where a.noperiodo=@noPeriodo and a.empresa=@empresa 
order by a.tercero,prioridad