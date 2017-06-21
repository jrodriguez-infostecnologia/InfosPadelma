
CREATE proc [dbo].[spSeleccionaConceptosFantantesNominaxPeriodo]
 @año int,
 @periodo int,
 @tipo varchar(4),
 @empresa int
 as

 create table #conceptosAgronomico (concepto varchar(50))
 create table #conceptosContableCCosto (concepto varchar(50),ccosto varchar(50))
 create table #ConceptosSinParametrizacion 
 (	concepto varchar(50),
	nombreConcepto varchar(500),
	ccosto varchar(50),
	nombreCCosto varchar(500)
 
 )
-- variables 

declare @finicial date, @ffinal date
select @finicial=fechaInicial, @ffinal=fechaFinal from nPeriodoDetalle where año=@año and noPeriodo=@periodo 
and empresa=@empresa

insert #conceptosAgronomico
select distinct d.concepto
 from aTransaccion a 
join aTransaccionNovedad b on a.numero=b.numero and a.tipo=b.tipo and a.empresa=b.empresa 
join aTransaccionTercero c on b.numero=c.numero and b.tipo=c.tipo and b.registro=c.registroNovedad and b.empresa=c.empresa 
join aNovedad d on b.novedad = d.codigo and b.empresa=d.empresa
join cTercero e on c.tercero=e.id and e.empresa=c.empresa
join nContratos g on g.tercero=c.tercero and g.empresa=c.empresa and g.id= (select max(id) from nContratos zz where c.tercero=zz.tercero and c.empresa=zz.empresa) --and g.activo=1 l
 left join aLotes h on h.codigo=c.lote and h.empresa=c.empresa
 left join aloteCcostoSigo i on i.lote = c.lote and i.empresa=c.empresa
 join vSeleccionaLiquidacionDefinitiva k on k.tercero=c.tercero and k.empresa=a.empresa and 
 k.año=@año and k.noPeriodo=@periodo and a.empresa=@empresa
and a.anulado=0 and c.ejecutado=1
where convert(date, a.fecha) between @finicial and @ffinal and a.empresa=@empresa



insert #ConceptosSinParametrizacion
select distinct  'L'+d.codigo ,d.descripcion,  k.ccosto, l.descripcion
 from aTransaccion a 
join aTransaccionNovedad b on a.numero=b.numero and a.tipo=b.tipo and a.empresa=b.empresa 
join aTransaccionTercero c on b.numero=c.numero and b.tipo=c.tipo and b.registro=c.registroNovedad and b.empresa=c.empresa 
join aNovedad d on b.novedad = d.codigo and b.empresa=d.empresa
join cTercero e on c.tercero=e.id and e.empresa=c.empresa
join nContratos g on g.tercero=c.tercero and g.empresa=c.empresa and g.id= (select max(id) from nContratos zz where c.tercero=zz.tercero and c.empresa=zz.empresa) --and g.activo=1 
 left join aLotes h on h.codigo=c.lote and h.empresa=c.empresa
 join vSeleccionaLiquidacionDefinitiva k on k.tercero=c.tercero and k.empresa=a.empresa and 
 k.año=@año and k.noPeriodo=@periodo and a.empresa=@empresa
 join cCentrosCosto l on k.ccosto=l.codigo and l.empresa=a.empresa
where convert(date, a.fecha) between @finicial and @ffinal and a.empresa=@empresa
and a.anulado=0 and c.ejecutado=1 


update aTransaccionTercero
set ejecutado=0
where tipo+numero+ convert(varchar(50),tercero) + novedad
in(
select distinct  c.tipo+c.numero+ convert(varchar(50),c.tercero) + c.novedad
 from aTransaccion a 
join aTransaccionNovedad b on a.numero=b.numero and a.tipo=b.tipo and a.empresa=b.empresa 
join aTransaccionTercero c on b.numero=c.numero and b.tipo=c.tipo and b.registro=c.registroNovedad and b.empresa=c.empresa 
join aNovedad d on b.novedad = d.codigo and b.empresa=d.empresa
join cTercero e on c.tercero=e.id and e.empresa=c.empresa
join nContratos g on g.tercero=c.tercero and g.empresa=c.empresa and g.id= (select max(id) from nContratos zz where c.tercero=zz.tercero and c.empresa=zz.empresa) --and g.activo=1 
 left join aLotes h on h.codigo=c.lote and h.empresa=c.empresa
 join vSeleccionaLiquidacionDefinitiva k on k.tercero=c.tercero and k.empresa=a.empresa and 
 k.año=@año and k.noPeriodo=@periodo and a.empresa=@empresa
 join cCentrosCosto l on k.ccosto=l.codigo and l.empresa=a.empresa
where convert(date, a.fecha) between @finicial and @ffinal and a.empresa=@empresa
and a.anulado=0 and c.ejecutado=1 AND K.ccosto='0101'
)
--select * from #conceptosAgronomico

insert #conceptosContableCCosto
select distinct concepto, a.cCosto from cParametroContaNomi a  join cClaseParametroContaNomi b 
on a.clase=b.codigo and a.empresa=b.empresa
where b.tipo=@tipo and a.empresa=@empresa

insert #ConceptosSinParametrizacion
select distinct a.concepto, b.descripcion nombreConcepto, a.ccosto, d.descripcion nombreCCosto
from vSeleccionaLiquidacionDefinitiva a join
nConcepto b on a.concepto=b.codigo and a.empresa=b.empresa
join cTercero c on c.id = a.tercero and c.empresa = b.empresa 
 join cCentrosCosto d on a.ccosto=d.codigo and a.empresa=d.empresa
where a.año=@año and a.noPeriodo=@periodo and a.empresa=@empresa
and a.anulado=0 and a.concepto not in (select concepto from #conceptosAgronomico)

--select concepto+ccosto from #conceptosContableCCosto

select * from  #ConceptosSinParametrizacion
where concepto + ccosto not in (select concepto+ccosto from #conceptosContableCCosto)


drop table #conceptosAgronomico
drop table #ConceptosSinParametrizacion
drop table #conceptosContableCCosto


--go

--exec  [dbo].[spSeleccionaConceptosFantantesNominaxPeriodo]
-- @año int,
-- @periodo int,
-- @tipo varchar(4),
-- @empresa int
-- as