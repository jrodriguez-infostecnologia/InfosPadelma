CREATE proc [dbo].[spSeleccionaNominaxPeriodo]
@año int,
@periodo int,
@empresa int
as

declare  @causacionNominapr table (
año int,
mes int , 
noPeriodo int,
fecha date,
tercero	 int,
identificacion varchar(50),
empleado varchar(200),
concepto varchar(50),
nombreConcepto varchar(200),
valorTotal money,
ccosto varchar(50),
empresa int,
entidadEPS varchar(50),
entidadPension varchar(50),
naturaleza int,
desarrollo bit,
baseCesantias bit,
basePrimas bit,
baseInteresesCesantias bit,
baseVacaciones bit,
cantidad float,
lote varchar(50),
uMedida varchar(50)
)


declare @fi date, @ff date, @mes int


declare @conceptoCesantias varchar(50),
@conceptoVacaciones varchar(50),
@conceptoInteresCesantias varchar(50),
@conceptoPrimas varchar(50)

select @conceptoCesantias=cesantias, 
@conceptoVacaciones=vacaciones, @conceptoInteresCesantias=intereses,
@conceptoPrimas = primas  from nParametrosGeneral
where empresa=@empresa


insert @causacionNominapr
select 0, 0, 0,a.fecha, a.codTercero, a.codiTercero identificacion, a.nombreTercero empleado,   a.codConcepto, a.nombreConcepto nombreConcepto,
sum(valorTotal) valorTotal, a.codCCosto , a.empresa,a.entidadEps, a.entidadPension, a.signo,0,
a.baseCesantias, a.basePrimas, a.baseIntereses, a.baseVacaciones,a.cantidad,null, null
from vSeleccionaLiquidacionDefinitiva a 
where a.año=@año and a.noPeriodo=@periodo and a.empresa=@empresa  
and a.tipo='LQN'
and a.anulado=0
group by  a.codTercero, codiTercero, a.nombreTercero ,   a.codConcepto,a.nombreConcepto,a.codCCosto,a.empresa, a.entidad,a.signo,a.entidadEps, a.entidadPension,a.cantidad,a.fecha,
a.baseCesantias, a.basePrimas, a.baseIntereses, a.baseVacaciones

--select * from @causacionNominapr

select @fi=fechaInicial, @ff=fechaFinal from nPeriodoDetalle where año=@año and noPeriodo=@periodo 
and empresa=@empresa

if exists(select distinct d.concepto from aTransaccion a 
join aTransaccionNovedad b on a.numero=b.numero and a.tipo=b.tipo and a.empresa=b.empresa 
join aTransaccionTercero c on b.numero=c.numero and b.tipo=c.tipo and b.registro=c.registroNovedad and b.empresa=c.empresa 
join aNovedad d on b.novedad = d.codigo and b.empresa=d.empresa
join cTercero e on c.tercero=e.id and e.empresa=c.empresa
join nContratos g on g.tercero=c.tercero and g.empresa=c.empresa and g.id=c.contrato
 left join aLotes h on h.codigo=c.lote and h.empresa=c.empresa
 join nConcepto i on i.codigo=d.concepto and i.empresa=d.empresa
where convert(date, a.fecha) between @fi and @ff and a.empresa=@empresa
and d.concepto in (select distinct concepto from @causacionNominapr)
and g.ccosto in (select distinct ccosto from @causacionNominapr)
and a.anulado=0  and c.ejecutado=1
group by e.codigo, e.descripcion,i.codigo, i.descripcion,e.descripcion, g.ccosto, c.tercero,b.novedad, d.descripcion,d.uMedida, a.mes,a.empresa, d.naturaleza,h.desarrollo,
i.baseCesantias, i.basePrimas, i.baseIntereses, i.baseVacaciones, d.concepto
)
 begin

create table #conceptos (concepto varchar(50))
insert #conceptos
select  d.concepto 
from aTransaccion a 
join aTransaccionNovedad b on a.numero=b.numero and a.tipo=b.tipo and a.empresa=b.empresa 
join aTransaccionTercero c on b.numero=c.numero and b.tipo=c.tipo and b.registro=c.registroNovedad and b.empresa=c.empresa 
join aNovedad d on b.novedad = d.codigo and b.empresa=d.empresa
join cTercero e on c.tercero=e.id and e.empresa=c.empresa
--join nContratos g on g.tercero=c.tercero and g.empresa=c.empresa and g.id= c.contrato
 left join aLotes h on h.codigo=c.lote and h.empresa=c.empresa
 join nConcepto i on i.codigo=d.concepto and i.empresa=d.empresa
where convert(date, a.fecha) between @fi and @ff and a.empresa=@empresa
and d.concepto in (select distinct concepto from @causacionNominapr)
and c.ccosto in (select distinct ccosto from @causacionNominapr)
and a.anulado=0  and c.ejecutado=1
group by e.codigo, e.descripcion,i.codigo, i.descripcion,e.descripcion, c.ccosto, c.tercero,b.novedad, d.descripcion,d.uMedida, a.mes,a.empresa, d.naturaleza,h.desarrollo,
i.baseCesantias, i.basePrimas, i.baseIntereses, i.baseVacaciones, d.concepto


delete @causacionNominapr
where concepto in (select concepto from aNovedad where empresa=@empresa and concepto<>'')

insert  @causacionNominapr
select  0, 0,0, a.fecha ,c.tercero, e.codigo identificacion,e.nombreTercero empleado,  f.codigo, f.descripcion nombreConcepto,
c.valorTotal valorTotal, e.codCCosto ,a.empresa,'', '', e.signo ,l.desarrollo,
e.baseCesantias, e.basePrimas, e.baseIntereses, e.baseVacaciones,c.cantidad, c.lote , f.uMedida
 from aTransaccion a 
left join aTransaccionNovedad b on a.numero=b.numero and a.tipo=b.tipo and a.empresa=b.empresa 
left join aTransaccionTercero c on b.numero=c.numero and b.tipo=c.tipo and b.registro=c.registroNovedad and b.empresa=c.empresa 
--left join cTercero d on d.id=c.tercero and d.empresa=c.empresa
left join aNovedad f on f.codigo=c.novedad and f.empresa=c.empresa 
left join vSeleccionaLiquidacionDefinitiva e on c.tercero=e.codtercero and  f.concepto = e.codconcepto and e.empresa=a.empresa and e.noContrato=c.contrato
--left join cPeriodo g on g.año=e.año and g.mes=e.mes and g.empresa=a.empresa
--left join nClaseContrato i on e.claseContrato=i.codigo and e.empresa=i.empresa
--left join cCentrosCosto j on j.codigo=e.codccosto and j.empresa=a.empresa
left join aLoteCcostoSigo k on k.empresa=b.empresa and k.lote=c.lote
left join aLotes l on l.codigo=c.lote and l.empresa=c.empresa
where convert(date, a.fecha) between @fi and @ff and a.empresa=@empresa
and a.anulado=0 and c.ejecutado=1  and e.noPeriodo=@periodo and e.año=@año --and a.mes=@mes

end

--select * from @causacionNominapr
--delete @causacionNominapr
--where concepto in(@conceptoVacaciones)

--insert @causacionNominapr

--select 0, 0, 0,'', a.empleado, c.codigo identificacion, c.descripcion empleado,   b.codigo, b.descripcion nombreConcepto,
--aa.valorTotal, d.ccosto , a.empresa,'', '', b.signo,0,
--b.baseCesantias, b.basePrimas, b.baseIntereses, b.baseVacaciones,a.diasCausados, null, null
--from nVacaciones a  join
--nVacacionesDetalle aa on a.periodoInicial=aa.periodoInicial and a.periodoFinal=aa.periodoFinal and a.empleado=aa.empleado
--and a.registro=aa.registro
--and a.empresa=aa.empresa   join 
--nConcepto b on @conceptoVacaciones=b.codigo and a.empresa=b.empresa and aa.concepto=b.codigo 
--join cTercero c on c.id = a.empleado and c.empresa = a.empresa
--join nContratos d on d.tercero=a.empleado and d.empresa=a.empresa and   d.id in  (select max(id) from nContratos where a.empleado=tercero and empresa=@empresa)
--where añoPago=@año and a.periodo=@periodo and a.empresa=@empresa and a.anulado=0
--and a.tipo=1  and aa.concepto=@conceptoVacaciones 
--group by  a.empleado, c.codigo, c.descripcion ,  c.codigo, b.codigo,b.descripcion,ccosto,a.empresa,b.signo,
--b.baseCesantias, b.basePrimas, b.baseIntereses, b.baseVacaciones, aa.valorTotal,a.diasCausados


select a.*, b.descripcion desCcosto, (select sum(valorTotal) from @causacionNominapr where naturaleza=1 ) TDevengado,
 (select sum(valorTotal) from @causacionNominapr where naturaleza=2 ) TDeducido from @causacionNominapr a 
 join cCentrosCosto b on a.ccosto = b.codigo and a.empresa=b.empresa --and a.concepto=54