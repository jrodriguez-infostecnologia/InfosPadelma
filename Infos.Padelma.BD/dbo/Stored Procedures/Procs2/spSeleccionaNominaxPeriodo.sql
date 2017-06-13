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
create table #conceptosAgronomicos(codigo varchar(50))

insert @causacionNominapr
select 0, 0, 0,a.fecha, a.codTercero, a.codiTercero identificacion, a.nombreTercero empleado,   a.codConcepto, a.nombreConcepto nombreConcepto,
sum(valorTotal) valorTotal, a.codCCosto , a.empresa,a.entidadEps, a.entidadPension, a.signo,0,
a.baseCesantias, a.basePrimas, a.baseIntereses, a.baseVacaciones,a.cantidad,null, null
from vSeleccionaLiquidacionDefinitiva a join
nConcepto b on a.codConcepto=b.codigo and a.empresa=b.empresa
join cTercero c on c.id = a.codTercero and c.empresa = b.empresa
join nContratos e on e.tercero=a.codtercero and a.empresa=e.empresa and a.contrato=e.id
join nClaseContrato f on e.claseContrato=f.codigo and e.empresa=f.empresa
join cCentrosCosto g on g.codigo=a.codCCosto and g.empresa=a.empresa
join nConcepto h on h.codigo=a.codConcepto and h.empresa=a.empresa
where a.año=@año and a.noPeriodo=@periodo and a.empresa=@empresa  
and a.tipo='LQN'
and a.anulado=0
group by  a.codTercero, codiTercero, a.nombreTercero ,   a.codConcepto,a.nombreConcepto,a.codCCosto,a.empresa, a.entidad,a.signo,a.entidadEps, a.entidadPension,a.cantidad,a.fecha,
a.baseCesantias, a.basePrimas, a.baseIntereses, a.baseVacaciones

select @fi=fechaInicial, @ff=fechaFinal from nPeriodoDetalle where año=@año and noPeriodo=@periodo 
and empresa=@empresa


 insert #conceptosAgronomicos
select distinct f.concepto from aTransaccion a 
 join aTransaccionNovedad b on a.numero=b.numero and a.tipo=b.tipo and a.empresa=b.empresa 
 join aTransaccionTercero c on b.numero=c.numero and b.tipo=c.tipo and b.registro=c.registroNovedad and b.empresa=c.empresa 
 join aNovedad f on f.codigo=c.novedad and f.empresa=c.empresa 
where convert(date, a.fecha) between @fi and @ff and a.empresa=@empresa
and a.anulado=0 and
c.ejecutado = 1

 insert #conceptosAgronomicos
select distinct f.concepto from aTransaccion a 
 join aTransaccionNovedad b on a.numero=b.numero and a.tipo=b.tipo and a.empresa=b.empresa 
 join aTransaccionTercero c on b.numero=c.numero and b.tipo=c.tipo and b.registro=c.registroNovedad and b.empresa=c.empresa 
 join aNovedad f on f.codigo=c.novedad and f.empresa=c.empresa 
where convert(date, a.fecha) between @fi and @ff and a.empresa=@empresa
and a.anulado=0 and
c.ejecutado = 1




delete @causacionNominapr
where concepto in (select concepto from aNovedad where empresa=@empresa and concepto<>'')

insert  @causacionNominapr
select  0, 0,0, a.fecha ,c.tercero, e.identificacion identificacion,e.nombreTercero empleado,  f.codigo, f.descripcion nombreConcepto,
c.valorTotal valorTotal, e.codCCosto ,a.empresa,'', '', e.signo ,l.desarrollo,
e.baseCesantias, e.basePrimas, e.baseIntereses, e.baseVacaciones,c.cantidad, c.lote , f.uMedida
 from aTransaccion a 
 join aTransaccionNovedad b on a.numero=b.numero and a.tipo=b.tipo and a.empresa=b.empresa 
 join aTransaccionTercero c on b.numero=c.numero and b.tipo=c.tipo and b.registro=c.registroNovedad and b.empresa=c.empresa 
 join aNovedad f on f.codigo=c.novedad and f.empresa=c.empresa 
 join (select distinct w.tipoConcepto, w.codDepto , w.numero, w.departamento, w.empresa,	w.identificacion, w.codCCosto,	w.codTercero,	w.nombreTercero,	w.codConcepto,	w.tipo,	w.año,	w.mes,	w.anulado,	w.noPeriodo,	w.signo,	w.entidad,	w.basePrimas,	
 w.baseCajaCompensacion,	w.baseCesantias,	w.baseVacaciones,	w.baseIntereses,	w.baseSeguridadSocial,	w.manejaRango,	w.baseEmbargo,	w.claseContrato,	w.entidadPension,	w.entidadEps,	w.entidadCesantias,	
 w.entidadCaja,	w.entidadArp,	w.entidadSena,	w.entidadIcbf,	w.codiTercero--, w.noContrato
 from vSeleccionaLiquidacionDefinitiva w where w.noPeriodo=@periodo and w.empresa=@empresa and w.año=@año and w.anulado=0  )  e on
  c.tercero=e.codtercero and  f.concepto = e.codconcepto and e.empresa=a.empresa --and e.noContrato=c.contrato
left join cCentrosCosto j on j.codigo=e.codccosto and j.empresa=a.empresa
left join aLoteCcostoSigo k on k.empresa=b.empresa and k.lote=c.lote
left join aLotes l on l.codigo=c.lote and l.empresa=c.empresa
join nConcepto m on f.concepto=m.codigo and  f.empresa=m.empresa
where convert(date, a.fecha) between @fi and @ff and a.empresa=@empresa
and a.anulado=0 and
c.ejecutado = 1
and e.anulado=0


select a.*, b.descripcion desCcosto, (select sum(valorTotal) from @causacionNominapr where naturaleza=1 ) TDevengado,
 (select sum(valorTotal) from @causacionNominapr where naturaleza=2 ) TDeducido from @causacionNominapr a 
 join cCentrosCosto b on a.ccosto = b.codigo and a.empresa=b.empresa --and a.concepto=54