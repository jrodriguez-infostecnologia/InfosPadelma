﻿CREATE proc [dbo].[spPrecontabilizaNominaTipoPeriodo] 
--- parametros
@año int, 
@periodo int,
@tipo varchar(4),
@empresa int,
@fechaT datetime,
@usuario varchar(50),
@numeroTransaccion varchar(50),
@retorno int output
as
SET NOCOUNT OFF
begin tran cprecontabilizacion
--  variables
declare @fechaInicial date, @fechaFinal date, @tipoTransaccion varchar(50)='', @mes int, @clase int, @xTercero bit, @cuentaCruce varchar(50), 
@mCcostoCruceContable varchar(50), @aCcostoCruceContable varchar(50), @estado int = 0, @maxRegistro int,
@conceptoCesantias varchar(50), @conceptoVacaciones varchar(50), @conceptoInteresCesantias varchar(50), @conceptoPrimas varchar(50), @tipoNovedadNomina varchar(1)='N',
@tipoNovedadlabor varchar(1)='L', @conceptoSalud varchar(50), @conceptoPension varchar(50),@conceptoCaja varchar(50), @conceptoARP  varchar(50),@conceptoICBF  varchar(50),
@conceptoSENA  varchar(50), @conceptoFondoSolidaridad  varchar(50) , @periodoContable varchar(50), @tipoInAccidenteTrabajo varchar(50),
@conceptoIncapacidad varchar(50)
-- Parametros de  contabilizacion
select @fechaInicial = fechaInicial, @fechaFinal=fechaFinal, @mes = mes from nPeriodoDetalle
where año=@año and noPeriodo=@periodo and empresa=@empresa
select @periodoContable=periodo from cPeriodo
where empresa=@empresa and año=@año and mes=@mes
select @conceptoSalud=salud,@conceptoPension= pension,
@conceptoCaja= cajaCompensacion, @conceptoARP=ARP, @conceptoICBF=ICBF, @conceptoSENA= sena, 
@conceptoFondoSolidaridad= fondoSolidaridad, @conceptoIncapacidad=incapacidades from nParametrosGeneral where empresa=@empresa
select @conceptoCesantias=cesantias, 
@conceptoVacaciones=vacaciones, @conceptoInteresCesantias=intereses,
@conceptoPrimas = primas 
from nParametrosGeneral where empresa=@empresa
select @clase=codigo from cClaseParametroContaNomi
where tipo=@tipo and empresa=@empresa
select @xTercero =portercero, @cuentaCruce =cuentaCruce, @mCcostoCruceContable= ccostoMayor, @aCcostoCruceContable=ccosto from cClaseParametroContaNomi where tipo=@tipo
and empresa=@empresa
select @tipoTransaccion =tipoTransaccion from cParametroContaNomi a join cClaseParametroContaNomi b on a.clase=b.codigo
and a.empresa=b.empresa and b.tipo=@tipo and tipoTransaccion<>''
select  @tipoInAccidenteTrabajo=codigo from nTipoIncapacidad
where afectaNovedadSS='IRP' and empresa=@empresa
-- Borrar datos Precontabilizacion si el estado es 0 

set @retorno=0
if exists( select * from cprecontabilizacion 
where tipo=@tipo and año=@año and mes=@mes  and periodoNomina=@periodo and estado=1
and empresa=@empresa and  docNomina like isnull(@numeroTransaccion,'')  )
begin
set @retorno=2
end
else
begin
if @tipo='SS'
set @mes=@periodo
delete cprecontabilizacion 
where tipo=@tipo and año=@año   and periodoNomina=@periodo 
and empresa=@empresa
-- tablaTemporales
create   table #tmpNomina
(
empresa	int	,
año	int	,
mes	int	,
periodoContable	varchar(6)	,
terceroEmpleado	varchar(50)	,
codigoTercero	varchar(50)	,
tipoNomina	varchar(50)	,
numeroNomina	varchar(50)	,
contrato	int	,
periodoNomina	int	,
claseContrato	varchar(50)	,
manejaLC	bit	,
manejaHE	bit	,
mccostoNomina	varchar(50)	,
cccostoNomina	varchar(50)	,
departamento	varchar(50)	,
tipoNovedad varchar(10),
concepto	varchar(50)	,
novedadAgronomica varchar(50),
signo	int	,
valorTotal float	,
entidadEps	varchar(50)	,
entidadPension	varchar(50)	,
entidadArp	varchar(50)	,
entidadCaja	varchar(50)	,
entidadSena	varchar(50)	,
entidadCesantias	varchar(50)	,
entidadFondoS	varchar(50)	,
entidadICBF varchar(50),
entidadAdicional	varchar(50)	,
mCCostoLote varchar(50),
aCcostoLote varchar(50),
loteDesarrollo bit,
baseCesantias bit,
basePrimas bit ,
baseIntereses bit,
baseVacaciones bit,
baseEmbargo bit,
baseCajaCompensacion bit,
baseSeguridadSocial bit,
tipoConcepto varchar(50),
conceptoReferencia varchar(50),
cuentaDepartamento varchar(50),
mccostoDepartamento varchar(50),
accostoDepartamento varchar(50)
)
create   table #tmpProvision
(
empresa	int	,
año	int	,
mes	int	,
periodoContable	varchar(6)	,
terceroEmpleado	varchar(50)	,
codigoTercero	varchar(50)	,
tipoNomina	varchar(50)	,
numeroNomina	varchar(50)	,
contrato	int	,
periodoNomina	int	,
claseContrato	varchar(50)	,
manejaLC	bit	,
manejaHE	bit	,
mccostoNomina	varchar(50)	,
cccostoNomina	varchar(50)	,
departamento	varchar(50)	,
tipoNovedad varchar(10),
concepto	varchar(50)	,
novedadAgronomica varchar(50),
signo	int	,
valorTotal float	,
entidadEps	varchar(50)	,
entidadPension	varchar(50)	,
entidadArp	varchar(50)	,
entidadCaja	varchar(50)	,
entidadSena	varchar(50)	,
entidadCesantias	varchar(50)	,
entidadFondoS	varchar(50)	,
entidadICBF varchar(50),
entidadAdicional	varchar(50)	,
mCCostoLote varchar(50),
aCcostoLote varchar(50),
loteDesarrollo bit,
baseCesantias bit,
basePrimas bit ,
baseIntereses bit,
baseVacaciones bit,
baseEmbargo bit,
baseCajaCompensacion bit,
baseSeguridadSocial bit,
tipoConcepto varchar(50),
conceptoReferencia varchar(50),
cuentaDdepartamento varchar(50),
cuentaCdepartamento varchar(50),
mcostoDdepartamento varchar(50),
accostoDdepartamento varchar(50),
mccostoCdepartamento varchar(50),
accostoCdepartamento varchar(50),
terceroDdepartamento varchar(50),
terceroCdepartamento varchar(50)
)
create   table #tmpPagoNomina
(
empresa	int	,
año	int	,
mes	int	,
periodoContable	varchar(6)	,
terceroEmpleado	varchar(50)	,
codigoTercero	varchar(50)	,
tipoNomina	varchar(50)	,
numeroNomina	varchar(50)	,
contrato	int	,
periodoNomina	int	,
claseContrato	varchar(50)	,
manejaLC	bit	,
manejaHE	bit	,
mccostoNomina	varchar(50)	,
cccostoNomina	varchar(50)	,
departamento	varchar(50)	,
tipoNovedad varchar(10),
concepto	varchar(50)	,
novedadAgronomica varchar(50),
signo	int	,
valorTotal float	,
entidadEps	varchar(50)	,
entidadPension	varchar(50)	,
entidadArp	varchar(50)	,
entidadCaja	varchar(50)	,
entidadSena	varchar(50)	,
entidadCesantias	varchar(50)	,
entidadFondoS	varchar(50)	,
entidadICBF varchar(50),
entidadAdicional	varchar(50)	,
mCCostoLote varchar(50),
aCcostoLote varchar(50),
loteDesarrollo bit,
baseCesantias bit,
basePrimas bit ,
baseIntereses bit,
baseVacaciones bit,
baseEmbargo bit,
baseCajaCompensacion bit,
baseSeguridadSocial bit,
tipoConcepto varchar(50),
conceptoReferencia varchar(50)
)
--- datos de la nomina
if @tipo	!=	'SS'
begin
-- nomina
insert #tmpNomina
select a.empresa, a.año, a.mes, @periodoContable,
a.codtercero , a.codiTercero, a.tipo, a.numero, a.contrato,
a.noPeriodo, f.codigo claseContrato, g.manejaLC, g.manejaHE, g.mayor mccostoNomina, g.codigo cccostoNomina,
a.coddepto,
@tipoNovedadNomina,
a.codConcepto,
null novedadAgronimica,
a.signo,
a.valorTotal,
a.entidadEps,
a.entidadPension,
a.entidadArp,
a.entidadCaja,
a.entidadSena,
a.entidadCesantias,
null entidadFondoS,
a.entidadIcbf,
a.entidad entidadAdicional,
'',
'',
0,
a.baseCesantias,--baseCesantias bit,
a.basePrimas,--basePrimas bit ,
a.baseIntereses,--baseIntereses bit,
a.baseVacaciones,--baseVacaciones bit,
a.baseEmbargo,--baseEmbargos bit,
a.baseCajaCompensacion,--baseCajaCompensacion bit,
a.baseSeguridadSocial,--baseSeguridadSocial bit
a.tipoConcepto,
null,
(select top 1 case 
		when a.signo=1 then zz.cuentaGasto 
		when a.signo= 2 then zz.cuentaCredito
		end
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
and a.codCCosto=zz.cCosto and a.departamento=zz.departamento and zz.concepto=a.codConcepto) cuenta,
(select top 1 case 
		when a.signo=1 then zz.cCostoMayorSigo 
		when a.signo= 2 then zz.cCostoMayorCredito
		end
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
and a.codCCosto=zz.cCosto and a.departamento=zz.departamento and zz.concepto=a.codConcepto) mccosto,
(select top 1 case 
		when a.signo=1 then zz.cCostoSigo 
		when a.signo= 2 then zz.cCostoCredito
		end
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
and a.codCCosto=zz.cCosto and a.departamento=zz.departamento and zz.concepto=a.codConcepto) aacosto
from vSeleccionaLiquidacionDefinitiva a join
nConcepto b on a.codConcepto=b.codigo and a.empresa=b.empresa
join cTercero c on c.id = a.codTercero and c.empresa = b.empresa
join nContratos e on e.tercero=a.codtercero and a.empresa=e.empresa and a.contrato=e.id
join nClaseContrato f on e.claseContrato=f.codigo and e.empresa=f.empresa
join cCentrosCosto g on g.codigo=a.codCCosto and g.empresa=a.empresa
join nConcepto h on h.codigo=a.codConcepto and h.empresa=a.empresa
where a.año=@año and a.noPeriodo=@periodo and a.empresa=@empresa
and a.tipo=@tipoTransaccion --and a.codtercero=7 and concepto=1028
and a.numero like '%'+@numeroTransaccion+'%'
and a.anulado=0 
-- borro conceptos de agronomico
delete #tmpNomina
where concepto  in (select f.concepto  
 from aTransaccion a 
 join aTransaccionNovedad b on a.numero=b.numero and a.tipo=b.tipo and a.empresa=b.empresa 
 join aTransaccionTercero c on b.numero=c.numero and b.tipo=c.tipo and b.registro=c.registroNovedad and b.empresa=c.empresa 
 join aNovedad f on f.codigo=c.novedad and f.empresa=c.empresa 
  join vSeleccionaLiquidacionDefinitiva e on c.tercero=e.codtercero and  f.concepto = e.codconcepto and e.empresa=a.empresa --and e.noContrato=c.contrato
and e.noPeriodo=@periodo  and e.año=@año and isnull(e.numero,'') like '%'+@numeroTransaccion+'%'
left join cCentrosCosto j on j.codigo=e.codccosto and j.empresa=a.empresa
left join aLoteCcostoSigo k on k.empresa=b.empresa and k.lote=c.lote
left join aLotes l on l.codigo=c.lote and l.empresa=c.empresa
join nConcepto m on f.concepto=m.codigo and  f.empresa=m.empresa
join nContratos n on e.contrato=n.id and e.codTercero=n.tercero and n.empresa=e.empresa-- and n.activo=1
where convert(date, a.fecha) between @fechaInicial and @fechaFinal and a.empresa=@empresa
and a.anulado=0 and c.ejecutado=1  and c.periodo=@periodo 
and e.tipo=@tipoTransaccion

)
 -- agronomico
 insert #tmpNomina
select 
a.empresa, 
a.año, 
@mes, 
@periodoContable,
c.tercero, 
replace((select top 1 codigo from cTercero where empresa=@empresa and id=c.tercero),',','') identificacion,
a.tipo, 
a.numero,
(select  max(id )from nContratos where empresa=@empresa and  tercero=c.tercero) contratos ,
c.periodo, 
isnull(e.claseContrato,(select  max(id )from nContratos where empresa=@empresa and  tercero=c.tercero)) contratos,
isnull(j.manejaLC,1), isnull(j.manejaHE,0),  
isnull(j.mayor ,(select max(mayor) from cCentrosCosto where  empresa=@empresa and codigo = (select  max( ccosto )from nContratos where empresa=@empresa and  tercero=c.tercero))) mccostoNomina, 
isnull(j.codigo, (select  max(ccosto) from nContratos where empresa=@empresa and  tercero=c.tercero)) cccostoNomina,
isnull(e.codDepto, (select  max(departamento )from nContratos where empresa=@empresa and  tercero=c.tercero)) departamento,
@tipoNovedadlabor,
isnull(f.concepto, m.codigo),
c.novedad novedadAgronimica,
case when c.valorTotal<0 and e.signo=1 then 2
when e.signo=2 then 2 
else 1 end signo  ,
abs(c.valorTotal) valorTotal,
null entidadEps,
null entidadPension,
null entidadArp,
null entidadCaja,
null entidadSena,
null entidadCesantias,
null entidadFondoS,
null entidadICBF,
null entidadAdicional,
k.mCcostoSigo,
k.aCcostoSigo,
isnull(l.desarrollo,0),
isnull(e.baseCesantias, m.baseCesantias),--baseCesantias bit,
isnull(e.basePrimas, m.basePrimas),--basePrimas bit ,
isnull(e.baseIntereses, m.baseIntereses),--baseIntereses bit,
isnull(e.baseVacaciones, m.baseVacaciones),--baseVacaciones bit,
isnull(e.baseEmbargo, m.baseEmbargo),--baseEmbargos bit,
isnull(e.baseCajaCompensacion, m.baseCajaCompensacion),--baseCajaCompensacion bit,
isnull(e.baseSeguridadSocial, m.baseSeguridadSocial), --baseSeguridadSocial bit
e.tipoConcepto,
null,
(select top 1 case 
		when e.signo=1 then zz.cuentaGasto 
		when e.signo= 2 then zz.cuentaCredito
		end
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
and e.codCCosto=zz.cCosto and e.departamento=zz.departamento) cuenta,
(select top 1 case 
		when e.signo=1 then zz.cCostoMayorSigo 
		when e.signo= 2 then zz.cCostoMayorCredito
		end
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
and e.codCCosto=zz.cCosto and e.departamento=zz.departamento) mccosto,
(select top 1 case 
		when e.signo=1 then zz.cCostoSigo 
		when e.signo= 2 then zz.cCostoCredito
		end
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
and e.codCCosto=zz.cCosto and e.departamento=zz.departamento) aacosto
 from aTransaccion a 
 join aTransaccionNovedad b on a.numero=b.numero and a.tipo=b.tipo and a.empresa=b.empresa 
 join aTransaccionTercero c on b.numero=c.numero and b.tipo=c.tipo and b.registro=c.registroNovedad and b.empresa=c.empresa 
 join aNovedad f on f.codigo=c.novedad and f.empresa=c.empresa 
 join (select distinct w.tipoConcepto, w.codDepto , w.numero, w.departamento, w.empresa,	w.identificacion, w.codCCosto,	w.codTercero,	w.nombreTercero,	w.codConcepto,	w.tipo,	w.año,	w.mes,	w.anulado,	w.noPeriodo,	w.signo,	w.entidad,	w.basePrimas,	
 w.baseCajaCompensacion,	w.baseCesantias,	w.baseVacaciones,	w.baseIntereses,	w.baseSeguridadSocial,	w.manejaRango,	w.baseEmbargo,	w.claseContrato,	w.entidadPension,	w.entidadEps,	w.entidadCesantias,	
 w.entidadCaja,	w.entidadArp,	w.entidadSena,	w.entidadIcbf,	w.codiTercero--, w.noContrato
 from vSeleccionaLiquidacionDefinitiva w where w.noPeriodo=@periodo and w.empresa=@empresa and w.año=@año )  e on
  c.tercero=e.codtercero and  f.concepto = e.codconcepto and e.empresa=a.empresa --and e.noContrato=c.contrato
 and isnull(e.numero,'') like '%'+@numeroTransaccion+'%'
left join cCentrosCosto j on j.codigo=e.codccosto and j.empresa=a.empresa
left join aLoteCcostoSigo k on k.empresa=b.empresa and k.lote=c.lote
left join aLotes l on l.codigo=c.lote and l.empresa=c.empresa
join nConcepto m on f.concepto=m.codigo and  f.empresa=m.empresa
where convert(date, a.fecha) between @fechaInicial and @fechaFinal and a.empresa=@empresa
and a.anulado=0 and
c.ejecutado = 1
and c.periodo=@periodo
and e.tipo=@tipoTransaccion 
and e.anulado=0
--///////////////////////// provisiones ////////////////////////////

insert #tmpProvision 
select empresa ,	año ,	mes ,	@periodoContable ,	terceroEmpleado ,
	codigoTercero ,	'' ,	'' ,	contrato ,	periodoNomina ,	
	'' ,	0 ,	0 ,	mccostoNomina ,	cccostoNomina ,	departamento ,	@tipoNovedadNomina ,	
	@conceptoCesantias concepto ,	'' ,	1 , 
	sum(case   
	when concepto=@conceptoVacaciones and tipoConcepto='1' then 	case when signo=2 then valorTotal*(-1) else valorTotal end
	when concepto<>@conceptoVacaciones then case when signo=2 then valorTotal*(-1) else valorTotal end
	else 0 end)  valorTotal ,	
	'' entidadEps ,	'' entidadPension ,	'' entidadArp ,
		'' entidadCaja ,	'' entidadSena ,	'' entidadCesantias ,	'' entidadFondoS ,'' entidadICBF,	'' entidadAdicional ,	
		'' ,	'' ,	loteDesarrollo ,	 baseCesantias ,	0 ,	0 ,
			0 ,	0 ,	0 ,	0 , '','',
			(select top 1 zz.cuentaGasto
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
			and  #tmpNomina.cccostoNomina =zz.cCosto and 
			#tmpNomina.departamento=zz.departamento and zz.concepto=@conceptoCesantias) cuentaDdepartamento,
			(select top 1 zz.cuentaCredito
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
			and  #tmpNomina.cccostoNomina =zz.cCosto and 
			#tmpNomina.departamento=zz.departamento and zz.concepto=@conceptoCesantias) cuentaCdepartamento,
			(select top 1 zz.cCostoMayorSigo
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
			and  #tmpNomina.cccostoNomina =zz.cCosto and 
			#tmpNomina.departamento=zz.departamento and zz.concepto=@conceptoCesantias) mccostoDdepartamento,
			(select top 1 zz.cCostoSigo
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
			and  #tmpNomina.cccostoNomina =zz.cCosto and 
			#tmpNomina.departamento=zz.departamento and zz.concepto=@conceptoCesantias) accostoDdepartamento,
			(select top 1 zz.cCostoMayorCredito
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
			and  #tmpNomina.cccostoNomina =zz.cCosto and 
			#tmpNomina.departamento=zz.departamento and zz.concepto=@conceptoCesantias) mccostoCdepartamento,
			(select top 1 zz.cCostoCredito
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
			and  #tmpNomina.cccostoNomina =zz.cCosto and 
			#tmpNomina.departamento=zz.departamento and zz.concepto=@conceptoCesantias) accostoCdepartamento,
			(select top 1 zz.tercero
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
			and  #tmpNomina.cccostoNomina =zz.cCosto and 
			#tmpNomina.departamento=zz.departamento and zz.concepto=@conceptoCesantias) tercerpDdepartamento,
			(select top 1 zz.terceroCredito
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
			and  #tmpNomina.cccostoNomina =zz.cCosto and 
			#tmpNomina.departamento=zz.departamento and zz.concepto=@conceptoCesantias) terceroCdepartamento
 from #tmpNomina 
 where baseCesantias=1  
 group by 
 empresa ,	año ,	mes ,	terceroEmpleado ,
	codigoTercero ,	contrato ,	periodoNomina ,	mccostoNomina ,	cccostoNomina ,	departamento ,		
	loteDesarrollo ,baseCesantias 
 -- vacaciones
insert #tmpProvision 
select empresa ,	año ,	mes ,	@periodoContable ,	terceroEmpleado ,
	codigoTercero ,	'' ,	'' ,	contrato ,	periodoNomina ,	
	'' ,	0 ,	0 ,	mccostoNomina ,	cccostoNomina ,	departamento ,	@tipoNovedadNomina ,	
	@conceptoVacaciones concepto ,	'' ,	1 , 
	sum(case   
	when concepto=@conceptoVacaciones and tipoConcepto='1' then 	case when signo=2 then valorTotal*(-1) else valorTotal end
	when concepto<>@conceptoVacaciones then case when signo=2 then valorTotal*(-1) else valorTotal end
	else 0 end)  valorTotal ,	
	'' entidadEps ,	'' entidadPension ,	'' entidadArp ,
		'' entidadCaja ,	'' entidadSena ,	'' entidadCesantias ,	'' entidadFondoS ,'' entidadICBF,	'' entidadAdicional ,	
		'' ,	'' ,	loteDesarrollo ,	 0 ,	0 ,	0 ,
			baseVacaciones ,	0 ,	0 ,	0 , '','',
			(select top 1 zz.cuentaGasto
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
			and  #tmpNomina.cccostoNomina =zz.cCosto and 
			#tmpNomina.departamento=zz.departamento and zz.concepto=@conceptoVacaciones) cuentaDdepartamento,
			(select top 1 zz.cuentaCredito
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
			and  #tmpNomina.cccostoNomina =zz.cCosto and 
			#tmpNomina.departamento=zz.departamento and zz.concepto=@conceptoVacaciones) cuentaCdepartamento,
			(select top 1 zz.cCostoMayorSigo
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
			and  #tmpNomina.cccostoNomina =zz.cCosto and 
			#tmpNomina.departamento=zz.departamento and zz.concepto=@conceptoVacaciones) mccostoDdepartamento,
			(select top 1 zz.cCostoSigo
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
			and  #tmpNomina.cccostoNomina =zz.cCosto and 
			#tmpNomina.departamento=zz.departamento and zz.concepto=@conceptoVacaciones) accostoDdepartamento,
			(select top 1 zz.cCostoMayorCredito
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
			and  #tmpNomina.cccostoNomina =zz.cCosto and 
			#tmpNomina.departamento=zz.departamento and zz.concepto=@conceptoVacaciones) mccostoCdepartamento,
			(select top 1 zz.cCostoCredito
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
			and  #tmpNomina.cccostoNomina =zz.cCosto and 
			#tmpNomina.departamento=zz.departamento and zz.concepto=@conceptoVacaciones) accostoCdepartamento,
			(select top 1 zz.tercero
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
			and  #tmpNomina.cccostoNomina =zz.cCosto and 
			#tmpNomina.departamento=zz.departamento and zz.concepto=@conceptoVacaciones) tercerpDdepartamento,
			(select top 1 zz.terceroCredito
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
			and  #tmpNomina.cccostoNomina =zz.cCosto and 
			#tmpNomina.departamento=zz.departamento and zz.concepto=@conceptoVacaciones) terceroCdepartamento
 from #tmpNomina 
 where baseVacaciones=1  
 group by 
 empresa ,	año ,	mes ,	terceroEmpleado ,
	codigoTercero ,	contrato ,	periodoNomina ,	mccostoNomina ,	cccostoNomina ,	departamento ,		
	loteDesarrollo ,baseVacaciones 
 -- primas
insert #tmpProvision 
select empresa ,	año ,	mes ,	@periodoContable ,	terceroEmpleado ,
	codigoTercero ,	'' ,	'' ,	contrato ,	periodoNomina ,	
	'' ,	0 ,	0 ,	mccostoNomina ,	cccostoNomina ,	departamento ,	@tipoNovedadNomina ,	
	@conceptoPrimas concepto ,	'' ,	1 , 
	sum(case   
	when concepto=@conceptoVacaciones and tipoConcepto='1' then 	case when signo=2 then valorTotal*(-1) else valorTotal end
	when concepto<>@conceptoVacaciones then case when signo=2 then valorTotal*(-1) else valorTotal end
	else 0 end)  valorTotal ,	
	'' entidadEps ,	'' entidadPension ,	'' entidadArp ,
		'' entidadCaja ,	'' entidadSena ,	'' entidadCesantias ,	'' entidadFondoS ,'' entidadICBF,	'' entidadAdicional ,	
		'' ,	'' ,	loteDesarrollo ,	 0 ,	basePrimas ,	0 ,
			0 ,	0 ,	0 ,	0 , '','',
			(select top 1 zz.cuentaGasto
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
			and  #tmpNomina.cccostoNomina =zz.cCosto and 
			#tmpNomina.departamento=zz.departamento and zz.concepto=@conceptoPrimas) cuentaDdepartamento,
			(select top 1 zz.cuentaCredito
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
			and  #tmpNomina.cccostoNomina =zz.cCosto and 
			#tmpNomina.departamento=zz.departamento and zz.concepto=@conceptoPrimas) cuentaCdepartamento,
			(select top 1 zz.cCostoMayorSigo
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
			and  #tmpNomina.cccostoNomina =zz.cCosto and 
			#tmpNomina.departamento=zz.departamento and zz.concepto=@conceptoPrimas) mccostoDdepartamento,
			(select top 1 zz.cCostoSigo
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
			and  #tmpNomina.cccostoNomina =zz.cCosto and 
			#tmpNomina.departamento=zz.departamento and zz.concepto=@conceptoPrimas) accostoDdepartamento,
			(select top 1 zz.cCostoMayorCredito
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
			and  #tmpNomina.cccostoNomina =zz.cCosto and 
			#tmpNomina.departamento=zz.departamento and zz.concepto=@conceptoPrimas) mccostoCdepartamento,
			(select top 1 zz.cCostoCredito
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
			and  #tmpNomina.cccostoNomina =zz.cCosto and 
			#tmpNomina.departamento=zz.departamento and zz.concepto=@conceptoPrimas) accostoCdepartamento,
			(select top 1 zz.tercero
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
			and  #tmpNomina.cccostoNomina =zz.cCosto and 
			#tmpNomina.departamento=zz.departamento and zz.concepto=@conceptoPrimas) tercerpDdepartamento,
			(select top 1 zz.terceroCredito
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
			and  #tmpNomina.cccostoNomina =zz.cCosto and 
			#tmpNomina.departamento=zz.departamento and zz.concepto=@conceptoPrimas) terceroCdepartamento
 from #tmpNomina 
 where basePrimas=1  
 group by 
 empresa ,	año ,	mes ,	terceroEmpleado ,
	codigoTercero ,	contrato ,	periodoNomina ,	mccostoNomina ,	cccostoNomina ,	departamento ,		
	loteDesarrollo ,basePrimas 
 --intereses de cesantias
insert #tmpProvision 
select a.empresa ,	año ,	mes ,	@periodoContable ,	terceroEmpleado ,
	codigoTercero ,	tipoNomina ,	numeroNomina ,	contrato ,	periodoNomina ,	
	claseContrato ,	manejaLC ,	manejaHE ,	mccostoNomina ,	cccostoNomina ,	a.departamento ,	@tipoNovedadNomina ,	
	@conceptoInteresCesantias concepto ,	novedadAgronomica ,	signo , 
	a.valorTotal * (case when b.tipoDato=2 then b.valorTipoDato/100 else 1 end) valorTotal ,	
	entidadEps ,	entidadPension ,	entidadArp ,
		entidadCaja ,	entidadSena ,	entidadCesantias ,	entidadFondoS,entidadICBF ,	entidadAdicional ,	
		'' ,	'' ,	loteDesarrollo ,	baseCesantias ,	basePrimas ,	baseIntereses ,
			baseVacaciones ,	baseEmbargo ,	baseCajaCompensacion ,	baseSeguridadSocial , tipoConcepto, a.concepto,
			(select top 1 zz.cuentaGasto
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
			and  a.cccostoNomina =zz.cCosto and 
			a.departamento=zz.departamento and zz.concepto=@conceptoInteresCesantias) cuentaDdepartamento,
			(select top 1 zz.cuentaCredito
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
			and  a.cccostoNomina =zz.cCosto and 
			a.departamento=zz.departamento and zz.concepto=@conceptoInteresCesantias) cuentaCdepartamento,
			(select top 1 zz.cCostoMayorSigo
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
			and  a.cccostoNomina =zz.cCosto and 
			a.departamento=zz.departamento and zz.concepto=@conceptoInteresCesantias) mccostoDdepartamento,
			(select top 1 zz.cCostoSigo
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
			and  a.cccostoNomina =zz.cCosto and 
			a.departamento=zz.departamento and zz.concepto=@conceptoInteresCesantias) accostoDdepartamento,
			(select top 1 zz.cCostoMayorCredito
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
			and  a.cccostoNomina =zz.cCosto and 
			a.departamento=zz.departamento and zz.concepto=@conceptoInteresCesantias) mccostoCdepartamento,
			(select top 1 zz.cCostoCredito
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
			and  a.cccostoNomina =zz.cCosto and 
			a.departamento=zz.departamento and zz.concepto=@conceptoInteresCesantias) accostoCdepartamento,
			(select top 1 zz.tercero
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
			and  a.cccostoNomina =zz.cCosto and 
			a.departamento=zz.departamento and zz.concepto=@conceptoInteresCesantias) tercerpDdepartamento,
			(select top 1 zz.terceroCredito
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
			and  a.cccostoNomina =zz.cCosto and 
			a.departamento=zz.departamento and zz.concepto=@conceptoInteresCesantias) terceroCdepartamento
 from #tmpProvision a
 join cParametroContaNomi b on
 a.concepto=b.concepto  and b.cCosto=a.cccostoNomina and  b.cCostoMayor =a.mccostoNomina  and a.empresa=b.empresa
 where  a.concepto=@conceptoCesantias and b.clase=@clase 
 and  len(rtrim( ltrim(b.departamento)))=0
-- ///////////// pago de nomina ///////////////////////////////////////////
insert #tmpPagoNomina
select a.empresa, a.año, a.mes, @periodoContable,
a.codtercero , a.codiTercero, null, null, a.contrato,
@periodo, f.codigo claseContrato, g.manejaLC, g.manejaHE, g.mayor mccostoNomina, e.ccosto cccostoNomina,
e.departamento,
@tipoNovedadNomina,'' ,
null novedadAgronimica, 1,
aa.valorPago,
null,null,null,null,null,null,null,
null entidadFondoS,
null entidadAdicional,null,null,0,null,--baseCesantias bit,
null,--basePrimas bit ,
null,--baseIntereses bit,
null,--baseVacaciones bit,
null,--baseEmbargos bit,
null,--baseCajaCompensacion bit,
null,--baseSeguridadSocial bit
null,null
from vSeleccionaPagosNomina aa    join  (select distinct z.codtercero codtercero, z.codiTercero, z.contrato,z.año,
z.mes,
z.entidadEps,
z.entidadPension,
z.entidadArp,
z.entidadCaja,
z.entidadSena,
z.entidadCesantias, z.empresa,
z.noPeriodo
from vSeleccionaLiquidacionDefinitiva z   
where año=@año  and z.empresa=@empresa and noPeriodo=@periodo ) a 
on a.codtercero = aa.tercero and a.empresa=aa.empresa and a.noPeriodo=aa.noPeriodo and a.año=aa.año
   join cTercero c on c.id = a.codtercero and c.empresa = a.empresa
   join cperiodo d on d.año=a.año and d.mes=a.mes and d.empresa=a.empresa
   join nContratos e on e.tercero=a.codtercero and a.empresa=e.empresa and a.contrato=e.id
   join nClaseContrato f on e.claseContrato=f.codigo and e.empresa=f.empresa
   join cCentrosCosto g on g.codigo=e.ccosto and g.empresa=a.empresa --and g.activo=1
where aa.año=@año  and aa.empresa=@empresa  
and aa.noPeriodo=@periodo and aa.anulado=0
if @tipo='CC'
begin
	delete #tmpNomina
	insert #tmpNomina
	select a.empresa, a.año, @mes, @periodoContable,
	a.tercero , a.nit, null, null, 1,
	@periodo, 0 claseContrato, 0, 0,  null,  null,
	null,
	@tipoNovedadlabor, g.concepto ,
	g.codigo novedadAgronimica, 1,
	a.valorTotal,
	null,null,null,null,null,null,null,
	null entidadFondoS,
	null entidadAdicional,null,null,isnull(c.desarrollo,0),null,--baseCesantias bit,
	null,--basePrimas bit ,
	null,--baseIntereses bit,
	null,--baseVacaciones bit,
	null,--baseEmbargos bit,
	null,--baseCajaCompensacion bit,
	null,--baseSeguridadSocial bit
	null,null, null, null,null
	from vSeleccionaLiquidacionContratista a join aNovedad b on a.codigo=b.codigo and a.empresa=b.empresa
	left join  aLotes c on c.codigo=a.lote and c.empresa=a.empresa
	join cTercero d on a.nit = d.codigo and a.empresa=d.empresa
	left join aloteCcostoSigo i on i.lote = a.lote and i.empresa=c.empresa
	join aNovedad g on g.codigo = a.codigo and g.empresa=a.empresa
	where a.fechaT between @fechaInicial and @fechaFinal and a.empresa=@empresa
	--select * from #tmpNomina
end

if @tipo='CI'
begin
delete #tmpNomina
insert 	#tmpNomina
select a.empresa, a.año, a.mes, @periodoContable,
a.codtercero , a.codiTercero, a.tipo, a.numero, a.contrato,
a.noPeriodo, f.codigo claseContrato, g.manejaLC, g.manejaHE, g.mayor mccostoNomina, g.codigo cccostoNomina,
a.coddepto,
@tipoNovedadNomina,
a.codConcepto,
null novedadAgronimica,
a.signo,
convert(decimal,a.valorNP) -convert(decimal,a.valorTotal),
a.entidadEps,
a.entidadPension,
a.entidadArp,
a.entidadCaja,
a.entidadSena,
a.entidadCesantias,
null entidadFondoS,
a.entidadIcbf,
a.entidad entidadAdicional,
'',
'',
0,
a.baseCesantias,--baseCesantias bit,
a.basePrimas,--basePrimas bit ,
a.baseIntereses,--baseIntereses bit,
a.baseVacaciones,--baseVacaciones bit,
a.baseEmbargo,--baseEmbargos bit,
a.baseCajaCompensacion,--baseCajaCompensacion bit,
a.baseSeguridadSocial,--baseSeguridadSocial bit
a.tipoConcepto,
null,
(select top 1 case 
		when a.signo=1 then zz.cuentaGasto 
		when a.signo= 2 then zz.cuentaCredito
		end
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
and a.codCCosto=zz.cCosto and a.departamento=zz.departamento and zz.concepto=a.codConcepto) cuenta,
(select top 1 case 
		when a.signo=1 then zz.cCostoMayorSigo 
		when a.signo= 2 then zz.cCostoMayorCredito
		end
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
and a.codCCosto=zz.cCosto and a.departamento=zz.departamento and zz.concepto=a.codConcepto) mccosto,
(select top 1 case 
		when a.signo=1 then zz.cCostoSigo 
		when a.signo= 2 then zz.cCostoCredito
		end
			 from cParametroContaNomi zz where zz.empresa=@empresa and zz.clase=@clase 
and a.codCCosto=zz.cCosto and a.departamento=zz.departamento and zz.concepto=a.codConcepto) aacosto
from vSeleccionaLiquidacionDefinitiva a join
nConcepto b on a.codConcepto=b.codigo and a.empresa=b.empresa
join cTercero c on c.id = a.codTercero and c.empresa = b.empresa
join nContratos e on e.tercero=a.codtercero and a.empresa=e.empresa and a.contrato=e.id
join nClaseContrato f on e.claseContrato=f.codigo and e.empresa=f.empresa
join cCentrosCosto g on g.codigo=a.codCCosto and g.empresa=a.empresa
join nConcepto h on h.codigo=a.codConcepto and h.empresa=a.empresa
where a.año=@año and a.noPeriodo=@periodo and a.empresa=@empresa
--and a.tipo=@tipoTransaccion --and a.codtercero=7 and concepto=1028
and codConcepto=@conceptoIncapacidad
--and a.numero like '%'+@numeroTransaccion+'%'
and a.anulado=0 and  convert(decimal, a.valorNP) - convert(decimal, a.valorTotal)>0
end
end
else
begin
-- SALUD
insert #tmpNomina
select a.empresa, a.año, a.mes, d.periodo,
a.codtercero , a.codiTercero, null, null, a.contrato,
null, f.codigo claseContrato, g.manejaLC, g.manejaHE, g.mayor mccostoNomina, e.ccosto cccostoNomina,
e.departamento,
@tipoNovedadNomina,@conceptoSalud conceptoSalud,
null novedadAgronimica, b.signo,
convert(int, round((case when f.electivaProduccion=0 then  aa.IBCsalud * h.pEmpleador/100
else aa.IBCsalud*f.porcentajeSS/100 end ),0)) ValorSalud,
i.nit entidadEPS,null,null,null,null,null,null,
null entidadFondoS,
null entidadAdicional,null,null,0,null,--baseCesantias bit,
null,--basePrimas bit ,
null,--baseIntereses bit,
null,--baseVacaciones bit,
null,--baseEmbargos bit,
null,--baseCajaCompensacion bit,
null,--baseSeguridadSocial bit
null,null,
null,null,null
from nSeguridadSocial aa join  (select distinct z.codtercero codtercero, z.codiTercero, (select max(id) from ncontratos where empresa=@empresa and tercero= z.codTercero ) contrato,z.año,
z.mes,
z.entidadEps,
null entidadPension,
null entidadArp,
null entidadCaja,
null entidadSena,
null entidadCesantias, z.empresa
from vSeleccionaLiquidacionDefinitiva z ) a 
on aa.idTercero=a.codtercero and aa.empresa=a.empresa
and a.año=aa.año and aa.mes=a.mes
 join nConcepto b on @conceptoSalud=b.codigo and a.empresa=b.empresa
 join cTercero c on c.id = a.codtercero and c.empresa = b.empresa
 join cperiodo d on d.año=a.año and d.mes=a.mes and d.empresa=a.empresa
 join nContratos e on e.tercero=a.codtercero and a.empresa=e.empresa and a.contrato=e.id
 join nClaseContrato f on e.claseContrato=f.codigo and e.empresa=f.empresa
 join cCentrosCosto g on g.codigo=e.ccosto and g.empresa=a.empresa and g.activo=1
 left join vEntidadEps h on h.codigo=e.entidadEps and h.empresa=aa.empresa
 join cTercero i on i.id= aa.terceroSalud and i.empresa=aa.empresa
where aa.año=@año and aa.mes=@periodo and aa.empresa=@empresa and aa.valorSalud>0
-- PENSION
insert #tmpNomina
select a.empresa, a.año, a.mes, d.periodo,
a.codtercero , a.codiTercero, null, null, a.contrato,
null, f.codigo claseContrato, g.manejaLC, g.manejaHE, g.mayor mccostoNomina,  e.ccosto  cccostoNomina,
e.departamento,
@tipoNovedadNomina,@conceptoPension concepto,
null novedadAgronimica,  b.signo ,
convert(int,round(aa.IBCpension* isnull( h.pEmpleador,0)/100,0)) valorPension,
null,i.nit entidadPension,null,null,null,null,null,
null entidadFondoS,
null entidadAdicional,null,null,0,null,--baseCesantias bit,
null,--basePrimas bit ,
null,--baseIntereses bit,
null,--baseVacaciones bit,
null,--baseEmbargos bit,
null,--baseCajaCompensacion bit,
null,--baseSeguridadSocial bit
null,null,
null,null,null
from nSeguridadSocial aa join  (select distinct z.codtercero codtercero, z.codiTercero, (select max(id) from ncontratos where empresa=@empresa and tercero= z.codTercero ) contrato,z.año,
z.mes mes, 
null entidadEps,
z.entidadPension,
null entidadArp,
null entidadCaja,
null entidadSena,
null entidadCesantias, z.empresa
 from vSeleccionaLiquidacionDefinitiva z ) a on aa.idTercero=a.codtercero and aa.empresa=a.empresa
 and a.año=aa.año and aa.mes=a.mes
 join nConcepto b on @conceptoPension=b.codigo and a.empresa=b.empresa
 join cTercero c on c.id = a.codtercero and c.empresa = b.empresa
 join cperiodo d on d.año=a.año and d.mes=a.mes and d.empresa=a.empresa
 join nContratos e on e.tercero=a.codtercero and a.empresa=e.empresa and a.contrato=e.id
 join nClaseContrato f on e.claseContrato=f.codigo and e.empresa=f.empresa
 join cCentrosCosto g on g.codigo=e.ccosto and g.empresa=a.empresa and g.activo=1
 join vEntidadPension h on h.codigo=a.entidadPension and h.empresa=aa.empresa
 join cTercero i on aa.terceroPension =i.id and aa.empresa=i.empresa
where aa.año=@año and aa.mes=@periodo and aa.empresa=@empresa and aa.valorPension>0
-- ARP
insert #tmpNomina
select a.empresa, a.año, a.mes, d.periodo,
a.codtercero , a.codiTercero, null, null, a.contrato,
null, f.codigo claseContrato, g.manejaLC, g.manejaHE, g.mayor mccostoNomina, g.codigo cccostoNomina,
e.departamento,
@tipoNovedadNomina,@conceptoARP,
null novedadAgronimica, b.signo,
aa.valorArp,
null,null,h.nit entidadArp,null,null,null,null,
null entidadFondoS,
null entidadAdicional,null,null,0,null,--baseCesantias bit,
null,--basePrimas bit ,
null,--baseIntereses bit,
null,--baseVacaciones bit,
null,--baseEmbargos bit,
null,--baseCajaCompensacion bit,
null,--baseSeguridadSocial bit
null,null,
null,null,null
from nSeguridadSocial aa join  (select distinct z.codtercero codtercero, z.codiTercero, (select max(id) from ncontratos where empresa=@empresa and tercero= z.codTercero ) contrato,z.año,
z.mes,
null entidadEps,
null entidadPension,
z.entidadArp,
null entidadCaja,
null entidadSena,
null entidadCesantias, z.empresa
 from vSeleccionaLiquidacionDefinitiva z ) a on aa.idTercero=a.codtercero and aa.empresa=a.empresa
 and a.año=aa.año and aa.mes=a.mes
 join nConcepto b on @conceptoARP=b.codigo and a.empresa=b.empresa
 join cTercero c on c.id = a.codtercero and c.empresa = b.empresa
 join cperiodo d on d.año=a.año and d.mes=a.mes and d.empresa=a.empresa
 join nContratos e on e.tercero=a.codtercero and a.empresa=e.empresa and a.contrato=e.id
 join nClaseContrato f on e.claseContrato=f.codigo and e.empresa=f.empresa
 join cCentrosCosto g on g.codigo=e.ccosto and g.empresa=a.empresa and g.activo=1
 join cTercero h on h.id=aa.terceroArp and h.empresa=aa.empresa
where aa.año=@año and aa.mes=@periodo and aa.empresa=@empresa and aa.valorArp>0
-- CAJA
insert #tmpNomina
select a.empresa, a.año, a.mes, d.periodo,
a.codtercero , a.codiTercero, null, null, a.contrato,
null, f.codigo claseContrato, g.manejaLC, g.manejaHE, g.mayor mccostoNomina, g.codigo cccostoNomina,
e.departamento,
@tipoNovedadNomina,@conceptoCaja,
null novedadAgronimica, b.signo,
aa.valorCaja,
null,null,null,h.nit caja,null,null,null,
null entidadFondoS,
null entidadAdicional,null,null,0,null,--baseCesantias bit,
null,--basePrimas bit ,
null,--baseIntereses bit,
null,--baseVacaciones bit,
null,--baseEmbargos bit,
null,--baseCajaCompensacion bit,
null,--baseSeguridadSocial bit
null,null,
null,null,null
from nSeguridadSocial aa join  (select distinct z.codtercero codtercero, z.codiTercero, (select max(id) from ncontratos where empresa=@empresa and tercero= z.codTercero ) contrato,z.año,
z.mes,
null entidadEps,
null entidadPension,
null entidadArp,
z.entidadCaja,
null entidadSena,
null entidadCesantias, z.empresa
 from vSeleccionaLiquidacionDefinitiva z  where año=@año and mes=@periodo and z.empresa=@empresa ) a on aa.idTercero=a.codtercero and aa.empresa=a.empresa
and a.año=aa.año and aa.mes=a.mes
 join nConcepto b on @conceptoCaja=b.codigo and a.empresa=b.empresa
 join cTercero c on c.id = a.codtercero and c.empresa = b.empresa
 join cperiodo d on d.año=a.año and d.mes=a.mes and d.empresa=a.empresa
 join nContratos e on e.tercero=a.codtercero and a.empresa=e.empresa and a.contrato=e.id
 join nClaseContrato f on e.claseContrato=f.codigo and e.empresa=f.empresa
 join cCentrosCosto g on g.codigo=e.ccosto and g.empresa=a.empresa and g.activo=1
 join cTercero h on h.id=aa.terceroCaja and h.empresa=aa.empresa
where aa.año=@año and aa.mes=@periodo and aa.empresa=@empresa and aa.valorCaja>0
-- SENA
insert #tmpNomina
select a.empresa, a.año, a.mes, d.periodo,
a.codtercero , a.codiTercero, null, null, a.contrato,
null, f.codigo claseContrato, g.manejaLC, g.manejaHE, g.mayor mccostoNomina, g.codigo cccostoNomina,
e.departamento,
@tipoNovedadNomina,@conceptoSENA,
null novedadAgronimica,b.signo,
aa.valorCaja,
null,null,null,null,h.nit entsena,null,null,
null entidadFondoS,
null entidadAdicional,null,null,0,null,--baseCesantias bit,
null,--basePrimas bit ,
null,--baseIntereses bit,
null,--baseVacaciones bit,
null,--baseEmbargos bit,
null,--baseCajaCompensacion bit,
null,--baseSeguridadSocial bit
null,null,
null,null,null
from nSeguridadSocial aa join  (select distinct z.codtercero codtercero, z.codiTercero, z.contrato,z.año,
z.mes,
z.entidadEps,
z.entidadPension,
z.entidadArp,
z.entidadCaja,
z.entidadSena,
z.entidadCesantias, z.empresa
from vSeleccionaLiquidacionDefinitiva z ) a on aa.idTercero=a.codtercero and aa.empresa=a.empresa
and a.año=aa.año and aa.mes=a.mes
 join nConcepto b on @conceptoSENA=b.codigo and a.empresa=b.empresa
 join cTercero c on c.id = a.codtercero and c.empresa = b.empresa
 join cperiodo d on d.año=a.año and d.mes=a.mes and d.empresa=a.empresa
 join nContratos e on e.tercero=a.codtercero and a.empresa=e.empresa and a.contrato=e.id
 join nClaseContrato f on e.claseContrato=f.codigo and e.empresa=f.empresa
 join cCentrosCosto g on g.codigo=e.ccosto and g.empresa=a.empresa and g.activo=1
 join cTercero h on aa.terceroSena=h.id and h.empresa=aa.empresa
where aa.año=@año and aa.mes=@periodo and aa.empresa=@empresa and aa.valorSena>0
-- FONDO DE SOLIDARIDAD 
insert #tmpNomina
select a.empresa, a.año, a.mes, d.periodo,
a.codtercero , a.codiTercero, null, null, a.contrato,
null, f.codigo claseContrato, g.manejaLC, g.manejaHE, g.mayor mccostoNomina, g.codigo cccostoNomina,
e.departamento,
@tipoNovedadNomina,@conceptoFondoSolidaridad,
null novedadAgronimica, b.signo,
isnull( aa.valorFondo,0) + isnull(aa.valorFondoSub,0),
null,a.entidadPension,null,null,null,null, null,
null entidadFondoS,
null entidadAdicional,null,null,0,null,--baseCesantias bit,
null,--basePrimas bit ,
null,--baseIntereses bit,
null,--baseVacaciones bit,
null,--baseEmbargos bit,
null,--baseCajaCompensacion bit,
null,--baseSeguridadSocial bit
null,null,
null,null,null
from nSeguridadSocial aa  join  (select distinct z.codtercero codtercero, z.codiTercero, (select max(id) from ncontratos where empresa=@empresa and tercero= z.codTercero ) contrato,z.año,
z.mes, null entidadEps,
 z.entidadPension entidadPension,
 null entidadArp,
 null entidadCaja,
 null entidadSena,
 z.entidadPension fondoSolidaridad, z.empresa
 from vSeleccionaLiquidacionDefinitiva z  ) a on aa.idTercero=a.codtercero and aa.empresa=a.empresa
and a.año=aa.año and aa.mes=a.mes
 join nConcepto b on @conceptoFondoSolidaridad=b.codigo and a.empresa=b.empresa
 join cTercero c on c.id = a.codtercero and c.empresa = b.empresa
 join cperiodo d on d.año=a.año and d.mes=a.mes and d.empresa=a.empresa
 join nContratos e on e.tercero=a.codtercero and a.empresa=e.empresa and a.contrato=e.id
 join nClaseContrato f on e.claseContrato=f.codigo and e.empresa=f.empresa
 join cCentrosCosto g on g.codigo=e.ccosto and g.empresa=a.empresa and g.activo=1
 left join vEntidadPension h on a.entidadPension = h.tercero and aa.empresa=h.empresa
 join cTercero i on aa.terceroPension=i.id and aa.empresa=i.empresa
where aa.año=@año and aa.mes=@periodo and aa.empresa=@empresa and aa.valorFondo>0
-- ICBF 
insert #tmpNomina
select a.empresa, a.año, a.mes, d.periodo,
a.codtercero , a.codiTercero, null, null, a.contrato,
null, f.codigo claseContrato, g.manejaLC, g.manejaHE, g.mayor mccostoNomina, g.codigo cccostoNomina,
e.departamento,
@tipoNovedadNomina,@conceptoICBF,
null novedadAgronimica, b.signo,
valorIcbf,
null,null,null,null,null,e.entidadCesantias,
null entidadFondoS,
h.nit entidadicbf,
null entidadAdicional,null,null,0,null,--baseCesantias bit,
null,--basePrimas bit ,
null,--baseIntereses bit,
null,--baseVacaciones bit,
null,--baseEmbargos bit,
null,--baseCajaCompensacion bit,
null,--baseSeguridadSocial bit
null,null,
null,null,null
from nSeguridadSocial aa join  (select distinct z.codtercero codtercero, z.codiTercero, (select max(id) from ncontratos where empresa=@empresa and tercero= z.codTercero ) contrato,z.año,
z.mes,
 null entidadEps,null entidadPension,
null entidadArp,
null entidadCaja,
null entidadSena,
null entidadCesantias, z.empresa,z.entidadIcbf
from vSeleccionaLiquidacionDefinitiva z ) a on aa.idTercero=a.codtercero and aa.empresa=a.empresa
and a.año=aa.año and aa.mes=a.mes
 join nConcepto b on @conceptoICBF=b.codigo and a.empresa=b.empresa
 join cTercero c on c.id = a.codtercero and c.empresa = b.empresa
 join cperiodo d on d.año=a.año and d.mes=a.mes and d.empresa=a.empresa
 join nContratos e on e.tercero=a.codtercero and a.empresa=e.empresa and a.contrato=e.id
 join nClaseContrato f on e.claseContrato=f.codigo and e.empresa=f.empresa
 join cCentrosCosto g on g.codigo=e.ccosto and g.empresa=a.empresa and g.activo=1
 join cTercero h on h.id=aa.terceroIcbf and h.empresa=aa.empresa
where aa.año=@año and aa.mes=@periodo and aa.empresa=@empresa and aa.valorIcbf>0



end
--- contabilizaciones
if @tipo	in	('CA','PS')
begin
set @maxRegistro = isnull((select max(registro) from cprecontabilizacion where tipo=@tipo and año=@año and mes=@mes and empresa=@empresa  ),0)
insert cprecontabilizacion
SELECT a.empresa, 
       @tipo           tipo, 
       a.año, 
       @mes, 
       a.periodocontable, 
        ROW_NUMBER()  over (order by  a.empresa   asc) + @maxRegistro registro ,
       a.terceroempleado, 
       a.codigoTercero, 
       a.tiponomina, 
       a.numeronomina, 
       a.contrato, 
       a.periodonomina, 
       a.clasecontrato, 
       a.manejalc, 
       a.manejahe, 
       a.mccostonomina, 
       a.cccostonomina, 
       a.departamento, 
       a.concepto, 
       a.novedadagronomica,
	           Isnull(CASE 
                WHEN b.manejaentidad = 1 THEN
				  CASE WHEN a.tipoConcepto=@tipoInAccidenteTrabajo and a.concepto=@conceptoIncapacidad then  
				  (SELECT vEntidadArp.cuenta 
                                                  FROM   vEntidadArp 
                                                  WHERE  codigo = a.entidadArp
                                                         AND empresa = @empresa and vEntidadArp.activo=1) 
				  else 
                  CASE 
                    WHEN b.entidad = 'EEPS' THEN (SELECT ventidadeps.cuenta 
                                                  FROM   ventidadeps 
                                                  WHERE  codigo = a.entidadEps
                                                         AND empresa = @empresa and ventidadeps.activo=1) 
                    WHEN b.entidad = 'EP' THEN (SELECT ventidadpension.cuenta 
                                                FROM   ventidadpension 
                                                WHERE  codigo = a.entidadpension 
                                                       AND empresa = @empresa and ventidadpension.activo=1) 
                  END
				  END 
                ELSE 
                  CASE 
                    WHEN lotedesarrollo = 1 THEN 
                    Isnull(b.cuentaactivo, c.cuentaactivo) 
                    ELSE 
                      CASE 
                        WHEN a.signo = 2 THEN 
						 case when len(ltrim(rtrim(a.cuentaDepartamento)))>0 then a.cuentaDepartamento else
                          CASE 
                            WHEN 
                      Len(Ltrim(Rtrim(Isnull(b.cuentacredito, '')))) = 0 
                      AND Len(Ltrim(Rtrim(Isnull(c.cuentacredito, '')))) = 0 
                          THEN 
                            b.cuentagasto 
                            ELSE Isnull(b.cuentacredito, c.cuentacredito) 
                          END end 
                        ELSE  case when len(ltrim(rtrim(a.cuentaDepartamento)))>0 then a.cuentaDepartamento else Isnull(b.cuentagasto, c.cuentagasto) end
                      END 
                  END 
              END, '')  cuentaContable, 
	   Isnull(CASE 
                WHEN  len(ltrim(rtrim(a.mccostolote)))>0  THEN a.mccostolote 
                ELSE 
                  CASE 
                    WHEN a.signo = 2 THEN 
					case when len(ltrim(rtrim(a.mccostoDepartamento)))>0 then a.mccostoDepartamento else
					Isnull( 
                    Isnull(b.ccostomayorcredito, c.ccostomayorcredito), '')  end
                    ELSE 
				    case when len(ltrim(rtrim(a.mccostoDepartamento)))>0 then a.mccostoDepartamento else 
					Isnull(Isnull(b.ccostomayorsigo, c.ccostomayorsigo), '') end
                  END 
              END, '') mCcostoContable, 
       Isnull(CASE 
                 WHEN  len(ltrim(rtrim(a.aCcostoLote)))>0  THEN a.accostolote 
                ELSE 
                  CASE 
                    WHEN a.signo = 2 THEN 
					case when len(ltrim(rtrim(a.accostoDepartamento)))>0 then a.accostoDepartamento else Isnull( 
                    Isnull(b.ccostocredito, c.ccostocredito), '') end
					ELSE 
					case when len(ltrim(rtrim(a.accostoDepartamento)))>0 then a.accostoDepartamento else
				   Isnull(Isnull(b.cCostoSigo, c.cCostoSigo), '') end
					end
					END, '') aCcostoContable, 
       Isnull(CASE 
                WHEN b.manejaentidad = 1 THEN 
                  CASE 
                    WHEN b.entidad = 'EEPS' THEN (SELECT ventidadeps.codigo 
                                                  FROM   ventidadeps 
                                                  WHERE  codigo = a.entidadeps 
                                                         AND empresa = @empresa) 
                    WHEN b.entidad = 'EP' THEN (SELECT ventidadpension.codigo 
                                                FROM   ventidadpension 
                                                WHERE  codigo = a.entidadpension 
                                                       AND empresa = @empresa) 
                  END 
                ELSE 
                  CASE 
                    WHEN lotedesarrollo = 1 THEN 
						case 
						when len(ltrim(rtrim(b.tercero)))>0 then b.tercero
						when len(ltrim(rtrim(c.tercero)))>0 then c.tercero
						else
						a.codigoTercero
						end
                    ELSE 
                      CASE 
                        WHEN signo = 2 THEN 
                           case 
									when len(ltrim(rtrim(b.terceroCredito)))>0 then b.terceroCredito
									when len(ltrim(rtrim(c.terceroCredito)))>0 then c.terceroCredito
									else
									a.codigoTercero
									end
                        ELSE 
								   case 
									when len(ltrim(rtrim(b.tercero)))>0 then b.tercero
									when len(ltrim(rtrim(c.tercero)))>0 then c.tercero
									else
									a.codigoTercero
									end
                        END 
                      END 
                  END 
              , '') terceroContable, 
       CASE 
         WHEN a.signo <> 2 THEN a.valortotal 
		 else 0
       END                  debito, 
       CASE 
         WHEN a.signo = 2 THEN a.valortotal 
         ELSE 0 
       END           credito, 
       a.entidadeps, 
       a.entidadpension, 
       a.entidadarp, 
       a.entidadcaja, 
       a.entidadsena, 
       a.entidadcesantias, 
       ''              entidadFS, 
	   a.entidadICBF,
	   ''			   entidadAdicional,
       a.mccostolote, 
       a.accostolote, 
       a.lotedesarrollo,
	   a.baseCesantias,--baseCesantias bit,
	   a.basePrimas,--basePrimas bit ,
	   a.baseIntereses,--baseIntereses bit,
	   a.baseVacaciones,--baseVacaciones bit,
	   a.baseEmbargo,--baseEmbargos bit,
	   a.baseCajaCompensacion,--baseCajaCompensacion bit,
	   a.baseSeguridadSocial,--baseSeguridadSocial bit
	   a.tipoConcepto,
	   a.ConceptoReferencia,
	   @estado,
	   @fechaT,
	   getdate(),
	   @usuario
FROM   #tmpNomina a 
       LEFT JOIN cparametrocontanomi b 
              ON a.Concepto = b.concepto 
                 AND a.tiponovedad = 'N' 
                 AND a.empresa = b.empresa 
                 AND b.clase = @clase 
                 AND a.cccostonomina = b.ccosto 
				 and len(ltrim(rtrim(b.departamento)) )=0
       LEFT JOIN cparametrocontanomi c 
              ON a.tiponovedad + a.novedadagronomica = c.concepto and c.concepto is not null and c.concepto<>'' 
                 AND a.tiponovedad = 'L' 
                 AND a.empresa = c.empresa 
                 AND c.clase = @clase 
                 AND a.cccostonomina = c.ccosto 
				 and len(ltrim(rtrim(c.departamento)) )=0
WHERE  a.empresa = @empresa and a.valorTotal>0
if @cuentaCruce<>''
begin
set @maxRegistro = isnull((select max(registro) from cprecontabilizacion where tipo=@tipo and año=@año and mes=@mes and empresa=@empresa  ),0)
-- Contrapartida  ---  con @cuentaCruce
insert cprecontabilizacion	
SELECT a.empresa, 
       @tipo                    tipo, 
       a.año, 
       @mes, 
       a.periodocontable,
	   ROW_NUMBER()  over (order by  a.empresa   asc) + @maxRegistro registro , 
       a.terceroempleado, 
       a.codigoTercero, 
       a.tiponomina, 
       a.numeronomina, 
       a.contrato, 
       a.periodonomina, 
       a.clasecontrato, 
       a.manejalc, 
       a.manejahe, 
       '', 
       '', 
       '', 
       '', 
       '', 
       Isnull(@cuentaCruce, '') cuentaContable, 
	   CASE 
         WHEN Len(Ltrim(Rtrim(Isnull(@mCcostoCruceContable, '')))) != 0 THEN 
         @mCcostoCruceContable end   mCcostoContable, 
       CASE 
         WHEN Len(Ltrim(Rtrim(Isnull(@aCcostoCruceContable, '')))) != 0 THEN 
         @aCcostoCruceContable end       aCcostoContable, 
						a.codigoTercero       terceroContable, 
       CASE 
         WHEN a.signo = 1 THEN 0 
         ELSE a.valortotal 
       END  debito, 
       CASE 
         WHEN a.signo = 1 THEN a.valortotal 
         ELSE 0 
       END  credito, 
       a.entidadeps, 
       a.entidadpension, 
       a.entidadarp, 
       a.entidadcaja, 
       a.entidadsena, 
       a.entidadcesantias, 
       ''                       entidadFS, 
	     a.entidadICBF,
	   '' entidadAdicional,
       a.mccostolote, 
       a.accostolote, 
       a.lotedesarrollo,
	    a.baseCesantias,--baseCesantias bit,
	   a.basePrimas,--basePrimas bit ,
	   a.baseIntereses,--baseIntereses bit,
	   a.baseVacaciones,--baseVacaciones bit,
	   a.baseEmbargo,--baseEmbargos bit,
	   a.baseCajaCompensacion,--baseCajaCompensacion bit,
	   a.baseSeguridadSocial,--baseSeguridadSocial bit
	   a.tipoConcepto,
	   a.concepto,
	   @estado,
	   @fechaT,
	   getdate(),
	   @usuario
FROM   #tmpNomina a 
       LEFT JOIN cparametrocontanomi b 
              ON a.Concepto = b.concepto 
                 AND a.tiponovedad = 'N' 
                 AND a.empresa = b.empresa 
                 AND b.clase = @clase 
                 AND a.cccostonomina = b.ccosto 
				 and len(ltrim(rtrim(b.departamento)) )=0
       LEFT JOIN cparametrocontanomi c 
              ON a.tiponovedad + a.novedadagronomica = c.concepto 
                 AND a.tiponovedad = 'L' 
                 AND a.empresa = c.empresa 
                 AND c.clase = @clase 
                 AND a.cccostonomina = c.ccosto
				 and len(ltrim(rtrim(c.departamento)) )=0 
WHERE  a.empresa = @empresa and a.valorTotal>0  
end
end
if @tipo	in	('PR')
begin
set @maxRegistro = isnull((select max(registro) from cprecontabilizacion where tipo=@tipo and año=@año and mes=@mes and empresa=@empresa  ),0)
-- debito
insert cprecontabilizacion
SELECT a.empresa, 
       @tipo           tipo, 
       a.año, 
       a.mes, 
       a.periodocontable, 
        ROW_NUMBER()  over (order by  a.empresa   asc) + @maxRegistro registro ,
       a.terceroempleado, 
       a.codigoTercero, 
       a.tiponomina, 
       a.numeronomina, 
       a.contrato, 
       a.periodonomina, 
       a.clasecontrato, 
       a.manejalc, 
       a.manejahe, 
       a.mccostonomina, 
       a.cccostonomina, 
       a.departamento, 
       a.Concepto, 
       '', 
       Isnull(CASE 
                WHEN b.manejaentidad = 1 THEN 
				CASE WHEN a.tipoConcepto=@tipoInAccidenteTrabajo  and a.concepto=@conceptoIncapacidad then  
				  (SELECT vEntidadArp.cuenta 
                                                  FROM   vEntidadArp 
                                                  WHERE  codigo = a.entidadArp
                                                         AND empresa = @empresa and vEntidadArp.activo=1) 
				  else 
                  CASE 
                    WHEN b.entidad = 'EEPS' THEN (SELECT ventidadeps.cuenta 
                                                  FROM   ventidadeps 
                                                  WHERE  codigo = a.entidadeps and ventidadeps.activo=1
                                                         AND empresa = @empresa) 
                    WHEN b.entidad = 'EP' THEN (SELECT ventidadpension.cuenta 
                                                FROM   ventidadpension 
                                                WHERE  codigo = a.entidadpension  and ventidadpension.activo=1
                                                       AND empresa = @empresa) 
                  END 
				  END
                ELSE 
                  CASE 
                    WHEN lotedesarrollo = 1 THEN 
                    Isnull(b.cuentaactivo, c.cuentaactivo) 
                    ELSE 
                      CASE 
                        WHEN a.signo = 2 THEN 
                          CASE 
						  when len(rtrim(ltrim(a.cuentaCdepartamento)))> 0  then a.cuentaCdepartamento   
                            WHEN 
                      Len(Ltrim(Rtrim(Isnull(b.cuentacredito, '')))) = 0 
                      AND Len(Ltrim(Rtrim(Isnull(c.cuentacredito, '')))) = 0  
                          THEN 
                           case when len(rtrim(ltrim(a.cuentaDdepartamento)))> 0  then a.cuentaDdepartamento else   b.cuentagasto end 
                            ELSE Isnull(b.cuentacredito, c.cuentacredito) 
                          END 
                        ELSE 
						case when len(rtrim(ltrim(a.cuentaDdepartamento)))> 0  then a.cuentaDdepartamento else 
						Isnull(b.cuentagasto, c.cuentagasto)  end
                      END 
                  END 
	          END, '') cuentaContable, 
	  Isnull(CASE 
                WHEN  len(ltrim(rtrim(a.mccostolote)))>0  THEN a.mccostolote 
                ELSE 
                  CASE 
                    WHEN a.signo = 2 THEN 
					case when len(rtrim(ltrim(a.mccostoCdepartamento)))>0 then a.mccostoCdepartamento else
					Isnull(Isnull(b.ccostomayorcredito, c.ccostomayorcredito), '')  end
                    ELSE 
					case when len(rtrim(ltrim(a.accostoDdepartamento)))>0 then a.mcostoDdepartamento else
				   Isnull(Isnull(b.ccostomayorsigo, c.ccostomayorsigo), '') end
                  END 
              END, '') mCcostoContable, 
       Isnull(CASE 
                 WHEN  len(ltrim(rtrim(a.aCcostoLote)))>0  THEN a.accostolote 
                ELSE 
                  CASE 
                    WHEN a.signo = 2 THEN 
					case when len(rtrim(ltrim(a.accostoCdepartamento)))>0 then a.accostoCdepartamento else
					Isnull( 
                    Isnull(b.ccostocredito, c.ccostocredito), '')  end
					ELSE 
					case when len(rtrim(ltrim(a.accostoDdepartamento)))>0 then a.accostoDdepartamento else
				   Isnull(Isnull(b.cCostoSigo, c.cCostoSigo), '')  end
					end
					END, '') aCcostoContable,  
         Isnull(CASE 
                WHEN b.manejaentidad = 1 THEN 
                  CASE 
                    WHEN b.entidad = 'EEPS' THEN (SELECT ventidadeps.codigo 
                                                  FROM   ventidadeps 
                                                  WHERE  codigo = a.entidadeps AND ventidadeps.activo=1
                                                         AND empresa = @empresa) 
                    WHEN b.entidad = 'EP' THEN (SELECT ventidadpension.codigo 
                                                FROM   ventidadpension 
                                                WHERE  codigo = a.entidadpension  AND ventidadpension.activo=1
                                                       AND empresa = @empresa) 
                  END 
                ELSE 
                  CASE 
                    WHEN lotedesarrollo = 1 THEN 
						case 
						when len(ltrim(rtrim(b.tercero)))>0 then b.tercero
						when len(ltrim(rtrim(c.tercero)))>0 then c.tercero
						else
						a.codigoTercero
						end
                    ELSE 
                      CASE 
                        WHEN signo = 2 THEN 
                           case		when len(ltrim(rtrim(a.terceroCdepartamento)))>0 then a.terceroCdepartamento
									when len(ltrim(rtrim(b.terceroCredito)))>0 then b.terceroCredito
									when len(ltrim(rtrim(c.terceroCredito)))>0 then c.terceroCredito
									else
									a.codigoTercero
									end
                        ELSE 
								   case 
								   when len(ltrim(rtrim(a.terceroDdepartamento)))>0 then a.terceroDdepartamento
									when len(ltrim(rtrim(b.tercero)))>0 then b.tercero
									when len(ltrim(rtrim(c.tercero)))>0 then c.tercero
									else
									a.codigoTercero
									end
                        END 
                      END 
                  END 
              , '') terceroContable, 
      round( CASE 
         WHEN a.signo = 2 THEN 0 
         ELSE a.valortotal 
       END          * (case when isnuLL(b.tipoDato,c.tipoDato)=2 then isnull(b.valorTipoDato,c.valorTipoDato)/100 else 1 end)  ,0)        debito, 
      round( CASE 
         WHEN a.signo = 2 THEN a.valortotal 
         ELSE 0 
       END         * (case when isnuLL(b.tipoDato,c.tipoDato)=2 then isnull(b.valorTipoDato,c.valorTipoDato)/100 else 1 end) ,0)          credito, 
       a.entidadeps, 
       a.entidadpension, 
       a.entidadarp, 
       a.entidadcaja, 
       a.entidadsena, 
       a.entidadcesantias, 
       ''              entidadFS, 
	   a.entidadICBF,
	   ''			   entidadAdicional,
       a.mccostolote, 
       a.accostolote, 
       a.lotedesarrollo,
	   a.baseCesantias,--baseCesantias bit,
	   a.basePrimas,--basePrimas bit ,
	   a.baseIntereses,--baseIntereses bit,
	   a.baseVacaciones,--baseVacaciones bit,
	   a.baseEmbargo,--baseEmbargos bit,
	   a.baseCajaCompensacion,--baseCajaCompensacion bit,
	   a.baseSeguridadSocial,--baseSeguridadSocial bit
	   a.tipoConcepto,
	   a.ConceptoReferencia,
	   @estado,
	   @fechaT,
	   getdate(),
	   @usuario
FROM   #tmpProvision a 
       LEFT JOIN cparametrocontanomi b 
              ON a.concepto = b.concepto 
                 AND a.tiponovedad = 'N' 
                 AND a.empresa = b.empresa 
                 AND b.clase = @clase 
                 AND a.cccostonomina = b.ccosto and  len(rtrim(rtrim( b.departamento)))=0
       LEFT JOIN cparametrocontanomi c 
              ON a.tiponovedad + a.novedadagronomica = c.concepto 
                 AND a.tiponovedad = 'L' 
                 AND a.empresa = c.empresa 
                 AND c.clase = @clase 
                 AND a.cccostonomina = c.ccosto and  len(rtrim(rtrim( c.departamento)))=0
WHERE  a.empresa = @empresa and a.valorTotal>0 
set @maxRegistro = isnull((select max(registro) from cprecontabilizacion where tipo=@tipo and año=@año and mes=@mes and empresa=@empresa ),0)
-- credito
insert cprecontabilizacion
SELECT a.empresa, 
       @tipo           tipo, 
       a.año, 
       a.mes, 
       a.periodocontable, 
        ROW_NUMBER()  over (order by  a.empresa   asc) + @maxRegistro registro ,
       a.terceroempleado, 
       a.codigoTercero, 
       a.tiponomina, 
       a.numeronomina, 
       a.contrato, 
       a.periodonomina, 
       a.clasecontrato, 
       a.manejalc, 
       a.manejahe, 
       a.mccostonomina, 
       a.cccostonomina, 
       a.departamento, 
       a.Concepto, 
       '', 
       Isnull(CASE 
                WHEN b.manejaentidad = 1 THEN 
                  CASE 
                    WHEN b.entidad = 'EEPS' THEN (SELECT ventidadeps.cuenta 
                                                  FROM   ventidadeps 
                                                  WHERE  codigo = a.entidadeps and  ventidadeps.activo=1
                                                         AND empresa = @empresa) 
                    WHEN b.entidad = 'EP' THEN (SELECT ventidadpension.cuenta 
                                                FROM   ventidadpension 
                                                WHERE  codigo = a.entidadpension  and ventidadpension.activo=1
                                                       AND empresa = @empresa) 
                  END 
                ELSE 
                      CASE 
                        WHEN a.signo = 1 THEN 
                          CASE 
                            WHEN 
                      Len(Ltrim(Rtrim(Isnull(b.cuentacredito, '')))) = 0 
                      AND Len(Ltrim(Rtrim(Isnull(c.cuentacredito, '')))) = 0 
                          THEN 
						  case when len(rtrim(ltrim(a.cuentaDdepartamento)))>0 then a.cuentaDdepartamento
						  else
                            b.cuentagasto  end
                            ELSE 
							 case when len(rtrim(ltrim(a.cuentaCdepartamento)))>0 then a.cuentaCdepartamento else
							Isnull(b.cuentacredito, c.cuentacredito)  end
                          END 
                        ELSE
						case when len(rtrim(ltrim(a.cuentaDdepartamento)))> 0  then a.cuentaDdepartamento else 
						 Isnull(b.cuentagasto, c.cuentagasto)  end
                      END 
                  END 
              , '') cuentaContable, 
	   Isnull(CASE 
                WHEN a.mccostolote IS NOT NULL THEN a.mccostolote 
                ELSE 
                  CASE 
                    WHEN a.signo = 1 THEN 
					case when len(rtrim(ltrim(a.mccostoCdepartamento)))>0 then a.mccostoCdepartamento
					else
					Isnull( 
                    Isnull(b.ccostomayorcredito, c.ccostomayorcredito), '')  end
                    ELSE 
					case when len(rtrim(ltrim(a.mcostoDdepartamento)))>0 then a.mcostoDdepartamento else
              Isnull(Isnull(b.ccostomayorsigo, c.ccostomayorsigo), '') end
                  END 
              END, '') mCcostoContable, 
       Isnull(CASE 
                WHEN a.accostolote IS NOT NULL THEN a.accostolote 
                ELSE 
                  CASE 
                    WHEN a.signo = 1 THEN
					case when len(rtrim(ltrim(a.accostoCdepartamento)))>0 then a.accostoCdepartamento else
					 Isnull( 
                    Isnull(b.ccostocredito, c.ccostocredito), '')  end
                    ELSE 
					case when len(rtrim(ltrim(a.accostoDdepartamento)))>0 then a.accostoDdepartamento else
					Isnull(Isnull(b.ccostosigo, c.ccostosigo), '') end
                  END 
              END, '') aCcostoContable, 
          Isnull(CASE 
                WHEN b.manejaentidad = 1 THEN 
                  CASE 
                    WHEN b.entidad = 'EEPS' THEN (SELECT ventidadeps.codigo 
                                                  FROM   ventidadeps 
                                                  WHERE  codigo = a.entidadeps 
                                                         AND empresa = @empresa) 
                    WHEN b.entidad = 'EP' THEN (SELECT ventidadpension.codigo 
                                                FROM   ventidadpension 
                                                WHERE  codigo = a.entidadpension 
                                                       AND empresa = @empresa) 
                  END 
                ELSE 
                  CASE 
                    WHEN lotedesarrollo = 1 THEN 
						case 
						when len(ltrim(rtrim(b.tercero)))>0 then b.tercero
						when len(ltrim(rtrim(c.tercero)))>0 then c.tercero
						else
						a.codigoTercero
						end
                    ELSE 
                      CASE 
                        WHEN signo = 2 THEN 
                           case 
									when len(ltrim(rtrim(a.terceroCdepartamento)))>0 then a.terceroCdepartamento
									when len(ltrim(rtrim(b.terceroCredito)))>0 then b.terceroCredito
									when len(ltrim(rtrim(c.terceroCredito)))>0 then c.terceroCredito
									else
									a.codigoTercero
									end
                        ELSE 
								   case 
								    when len(ltrim(rtrim(a.terceroDdepartamento)))>0 then a.terceroDdepartamento
									when len(ltrim(rtrim(b.tercero)))>0 then b.tercero
									when len(ltrim(rtrim(c.tercero)))>0 then c.tercero
									else
									a.codigoTercero
									end
                        END 
                      END 
                  END 
              , '') terceroContable, 
      round( CASE 
         WHEN a.signo = 1 THEN 0 
         ELSE a.valortotal 
       END       * (case when isnuLL(b.tipoDato,c.tipoDato)=2 then isnull(b.valorTipoDato,c.valorTipoDato)/100 else 1 end) ,0)      debito, 
     round(  CASE 
         WHEN a.signo = 1 THEN a.valortotal 
         ELSE 0 
       END        * (case when isnuLL(b.tipoDato,c.tipoDato)=2 then isnull(b.valorTipoDato,c.valorTipoDato)/100 else 1 end)  ,0)            credito , 
       a.entidadeps, 
       a.entidadpension, 
       a.entidadarp, 
       a.entidadcaja, 
       a.entidadsena, 
       a.entidadcesantias, 
       ''              entidadFS, 
	   a.entidadICBF,
	   ''			   entidadAdicional,
       a.mccostolote, 
       a.accostolote, 
       a.lotedesarrollo,
	   a.baseCesantias,--baseCesantias bit,
	   a.basePrimas,--basePrimas bit ,
	   a.baseIntereses,--baseIntereses bit,
	   a.baseVacaciones,--baseVacaciones bit,
	   a.baseEmbargo,--baseEmbargos bit,
	   a.baseCajaCompensacion,--baseCajaCompensacion bit,
	   a.baseSeguridadSocial,--baseSeguridadSocial bit
	   a.tipoConcepto,
	   a.ConceptoReferencia,
	   @estado,
	     @fechaT,
	   getdate(),
	   @usuario
FROM   #tmpProvision a 
       LEFT JOIN cparametrocontanomi b 
              ON a.concepto = b.concepto 
                 AND a.tiponovedad = 'N' 
                 AND a.empresa = b.empresa 
                 AND b.clase = @clase 
                 AND a.cccostonomina = b.ccosto  and  len(rtrim(rtrim( b.departamento)))=0
       LEFT JOIN cparametrocontanomi c 
              ON a.tiponovedad + a.novedadagronomica = c.concepto 
                 AND a.tiponovedad = 'L' 
                 AND a.empresa = c.empresa 
                 AND c.clase = @clase 
                 AND a.cccostonomina = c.ccosto and  len(rtrim(rtrim( c.departamento)))=0
WHERE  a.empresa = @empresa  and a.valorTotal>0 
end
if @tipo	=	'SS'
begin
	set @maxRegistro = isnull((select max(registro) from cprecontabilizacion where tipo=@tipo and año=@año and mes=@mes and empresa=@empresa  ),0)

	-- credito
	insert cprecontabilizacion
	  SELECT  a.empresa, 
       @tipo           tipo, 
       a.año, 
       a.mes, 
       a.periodocontable, 
        ROW_NUMBER()  over (order by  a.periodocontable   asc) + @maxRegistro registro ,
       a.terceroempleado, 
       a.codigoTercero, 
       a.tiponomina, 
       a.numeronomina, 
       a.contrato, 
       a.mes, 
       a.clasecontrato, 
       a.manejalc, 
       a.manejahe, 
       a.mccostonomina, 
       a.cccostonomina, 
       a.departamento, 
       a.concepto, 
       a.novedadagronomica,
	         Isnull(CASE 
                WHEN isnull(b.manejaentidad,d.manejaEntidad) = 1 THEN 
                  CASE 
                    WHEN isnull(b.entidad,d.entidad) = 'EEPS' THEN (SELECT ventidadeps.cuenta 
                                                  FROM   ventidadeps 
                                                  WHERE  codigo = a.entidadeps  and ventidadeps.activo=1
                                                         AND empresa = @empresa) 
                    WHEN isnull(b.entidad,d.entidad) = 'EP' THEN (SELECT ventidadpension.cuenta 
                                                FROM   ventidadpension 
                                                WHERE  codigo = a.entidadpension and ventidadpension.activo=1
												 AND empresa = @empresa)
                    when isnull(b.entidad,d.entidad) ='EARP' then  (SELECT vEntidadArp.cuenta 
                                                FROM   vEntidadArp 
                                                WHERE  codigo = a.entidadArp and vEntidadArp.activo=1
												 AND empresa = @empresa)
					when isnull(b.entidad,d.entidad) ='ECAJA' then  (SELECT vEntidadCaja.cuenta 
                                                FROM   vEntidadCaja  
                                                WHERE  codigo = a.entidadCaja  and vEntidadCaja.activo=1
												 AND empresa = @empresa)
					when isnull(b.entidad,d.entidad) ='EICBF' then  (SELECT vEntidadIcbf.cuenta 
                                                FROM   vEntidadIcbf 
                                                WHERE  codigo = a.entidadICBF  and vEntidadIcbf.activo=1
												 AND empresa = @empresa)
					when isnull(b.entidad,d.entidad) ='ESENA' then  (SELECT vEntidadSena.cuenta 
                                                FROM   vEntidadSena 
                                                WHERE  codigo = a.entidadSena and vEntidadSena.activo=1
												 AND empresa = @empresa)
					when isnull(b.entidad,d.entidad)  ='EFONDO' then  (SELECT ventidadpension.cuenta 
                                                FROM   ventidadpension 
                                                WHERE  codigo = a.entidadFondoS  and ventidadpension.activo=1
												 AND empresa = @empresa)                       
                  END 
                ELSE 
                  CASE 
                    WHEN lotedesarrollo = 1 THEN 
                    isnull(Isnull(b.cuentaactivo, c.cuentaactivo),d.cuentaActivo) 
                    ELSE 
                      CASE 
                        WHEN a.signo = 2 THEN 
                          CASE 
                            WHEN 
                      Len(Ltrim(Rtrim(Isnull(b.cuentacredito, '')))) = 0 
                      AND Len(Ltrim(Rtrim(Isnull(c.cuentacredito, '')))) = 0 
                          THEN 
                           ''--isnull(b.cuentagasto ,d.cuentaGasto''
                            ELSE isnull(Isnull(b.cuentacredito, c.cuentacredito) , d.cuentaCredito)
                          END 
                        ELSE isnull(Isnull(b.cuentagasto, c.cuentagasto) ,d.cuentaGasto)
                      END 
                  END 
              END, '') cuentaContable, 
			        case when signo=2 then  Isnull(Isnull(b.cCostoMayorCredito, c.cCostoMayorCredito), '') else '' end mCcostoContable, 
                    case when signo=2 then  isnull(Isnull(b.cCostoCredito, c.ccostocredito), '') else '' end aCcostoContable,  
       Isnull(CASE 
                WHEN b.manejaentidad = 1 THEN 
                  CASE 
                    WHEN b.entidad = 'EEPS' THEN (SELECT ventidadeps.codigo 
                                                  FROM   ventidadeps 
                                                  WHERE  codigo = a.entidadeps  and ventidadeps.activo=1
                                                         AND empresa = @empresa) 
                    WHEN b.entidad = 'EP' THEN (SELECT ventidadpension.codigo 
                                                FROM   ventidadpension 
                                                WHERE  codigo = a.entidadpension and ventidadpension.activo=1
												 AND empresa = @empresa)
                    when b.entidad ='EARP' then  (SELECT vEntidadArp.codigo 
                                                FROM   vEntidadArp 
                                                WHERE  codigo = a.entidadArp and vEntidadArp.activo=1
												 AND empresa = @empresa)
					when b.entidad ='ECAJA' then  (SELECT vEntidadCaja.codigo 
                                                FROM   vEntidadCaja 
                                                WHERE  codigo = a.entidadCaja and vEntidadCaja.activo=1
												 AND empresa = @empresa)
					when b.entidad ='EICBF' then  (SELECT vEntidadIcbf.codigo 
                                                FROM   vEntidadIcbf 
                                                WHERE  codigo = a.entidadICBF and vEntidadIcbf.activo=1
												 AND empresa = @empresa)
					when b.entidad ='ESENA' then  (SELECT vEntidadSena.codigo 
                                                FROM   vEntidadSena 
                                                WHERE  codigo = a.entidadSena and vEntidadSena.activo=1
												 AND empresa = @empresa)
					when b.entidad ='EFONDO' then  (SELECT ventidadpension.codigo 
                                                FROM   ventidadpension 
                                                WHERE  codigo = a.entidadFondoS and ventidadpension.activo=1
												 AND empresa = @empresa)  
                  END 
                ELSE 
                  CASE 
                    WHEN lotedesarrollo = 1 THEN 
                      CASE 
                        WHEN @xTercero = 1 THEN a.codigoTercero 
                        ELSE Isnull(Isnull(b.tercero, c.tercero), '') 
                      END 
                    ELSE 
                      CASE 
                        WHEN signo = 1 THEN 
                          CASE 
                            WHEN @xTercero = 1 THEN a.codigoTercero 
                            ELSE Isnull(Isnull(b.tercerocredito, 
                                        b.tercerocredito), '') 
                          END 
                        ELSE 
                          CASE 
                            WHEN @xTercero = 1 THEN a.codigoTercero 
                            ELSE Isnull(b.tercero, c.tercerocredito) 
                          END 
                      END 
                  END 
              END, '') terceroContable, 
	   0 debito,
       a.valortotal credito , 
       a.entidadeps, 
       a.entidadpension, 
       a.entidadarp, 
       a.entidadcaja, 
       a.entidadsena, 
       a.entidadcesantias, 
       ''              entidadFS, 
	   a.entidadICBF,
	   ''			   entidadAdicional,
       a.mccostolote, 
       a.accostolote, 
       a.lotedesarrollo,
	   a.baseCesantias,--baseCesantias bit,
	   a.basePrimas,--basePrimas bit ,
	   a.baseIntereses,--baseIntereses bit,
	   a.baseVacaciones,--baseVacaciones bit,
	   a.baseEmbargo,--baseEmbargos bit,
	   a.baseCajaCompensacion,--baseCajaCompensacion bit,
	   a.baseSeguridadSocial,--baseSeguridadSocial bit
	   a.tipoConcepto,
	   a.ConceptoReferencia,
	   @estado estado,
	     @fechaT,
	   getdate(),
	   @usuario
FROM   #tmpNomina a 
       LEFT JOIN cparametrocontanomi b 
              ON a.Concepto = b.concepto 
                 AND a.tiponovedad = 'N' 
                 AND a.empresa = b.empresa 
                 AND b.clase = @clase 
                 AND a.cccostonomina = b.ccosto and rtrim(ltrim(b.departamento)) = 0 
	   LEFT JOIN cparametrocontanomi c 
              ON a.tiponovedad + a.novedadagronomica = c.concepto 
                 AND a.tiponovedad = 'L' 
                 AND a.empresa = c.empresa 
                 AND c.clase = @clase 
                 AND a.cccostonomina = c.ccosto 
	   LEFT JOIN cparametrocontanomi d 
              ON a.Concepto = d.concepto 
                 AND a.tiponovedad = 'N' 
                 AND a.empresa = d.empresa 
                 AND d.clase = @clase 
                 AND a.cccostonomina = d.ccosto  and rtrim(ltrim(d.departamento)) > 0  --and aa.electivaProduccion=1
				 and a.departamento=d.departamento
	WHERE  a.empresa = @empresa and a.valorTotal>0
	--debito departamento
	set @maxRegistro = isnull((select max(registro) from cprecontabilizacion where tipo=@tipo and año=@año and mes=@mes and empresa=@empresa  ),0)
	insert cprecontabilizacion
		SELECT a.empresa, 
       @tipo           tipo, 
       a.año, 
       a.mes, 
       a.periodocontable, 
        ROW_NUMBER()  over (order by  a.empresa   asc) + @maxRegistro registro ,
       a.terceroEmpleado, 
       a.codigoTercero, 
       a.tiponomina, 
       a.numeronomina, 
       a.contrato, 
       @mes, 
       a.clasecontrato, 
       a.manejalc, 
       a.manejahe, 
       a.mccostonomina, 
       a.cccostonomina, 
       a.departamento, 
       a.Concepto, 
       a.novedadagronomica,
	         Isnull(CASE 
                WHEN isnull(b.manejaentidad,'') = 0 THEN 
                  CASE 
                    WHEN isnull(b.entidad,'') = 'EEPS' THEN (SELECT ventidadeps.cuenta 
                                                  FROM   ventidadeps 
                                                  WHERE  codigo = a.entidadeps  and ventidadeps.activo=1
                                                         AND empresa = @empresa) 
                    WHEN isnull(b.entidad,'') = 'EP' THEN (SELECT ventidadpension.cuenta 
                                                FROM   ventidadpension 
                                                WHERE  codigo = a.entidadpension and ventidadpension.activo=1
												 AND empresa = @empresa)
                    when isnull(b.entidad,'') ='EARP' then  (SELECT vEntidadArp.cuenta 
                                                FROM   vEntidadArp 
                                                WHERE  codigo = a.entidadArp and vEntidadArp.activo=1
												 AND empresa = @empresa)
					when isnull(b.entidad,'') ='ECAJA' then  (SELECT vEntidadCaja.cuenta 
                                                FROM   vEntidadCaja 
                                                WHERE  codigo = a.entidadCaja and vEntidadCaja.activo=1
												 AND empresa = @empresa)
					when isnull(b.entidad,'') ='EICBF' then  (SELECT vEntidadIcbf.cuenta 
                                                FROM   vEntidadIcbf 
                                                WHERE  codigo = a.entidadICBF and vEntidadIcbf.activo=1
												 AND empresa = @empresa)
					when isnull(b.entidad,'') ='ESENA' then  (SELECT vEntidadSena.cuenta 
                                                FROM   vEntidadSena 
                                                WHERE  codigo = a.entidadSena and vEntidadSena.activo=1
												 AND empresa = @empresa)
					when isnull(b.entidad,'')  ='EFONDO' then  (SELECT ventidadpension.cuenta 
                                                FROM   ventidadpension 
                                                WHERE  codigo = a.entidadFondoS and ventidadpension.activo=1
												 AND empresa = @empresa)                       
                  END 
                ELSE 
                   isnull(Isnull(b.cuentagasto, '') ,'')
              END, '') cuentaContable, 
	   Isnull(CASE 
                WHEN  len(ltrim(rtrim(a.mccostolote)))>0  THEN a.mccostolote 
                ELSE 
                  CASE 
                    WHEN a.signo = 2 THEN Isnull( 
                    Isnull(b.ccostomayorcredito, ''), '') 
                    ELSE 
				   Isnull(Isnull(b.ccostomayorsigo, ''), '') 
                  END 
              END, '') mCcostoContable, 
       Isnull(CASE 
                 WHEN  len(ltrim(rtrim(a.aCcostoLote)))>0  THEN a.mccostolote 
                ELSE 
                  CASE 
                    WHEN a.signo = 2 THEN Isnull( 
                    Isnull(b.ccostocredito, ''), '') 
					ELSE 
				   Isnull(Isnull(b.cCostoSigo, ''), '') 
					end
					END, '') aCcostoContable,  
       Isnull(CASE 
                WHEN b.manejaentidad = 1 THEN 
                  CASE 
                    WHEN b.entidad = 'EEPS' THEN (SELECT ventidadeps.codigo 
                                                  FROM   ventidadeps 
                                                  WHERE  codigo = a.entidadeps and ventidadeps.activo=1
                                                         AND empresa = @empresa) 
                    WHEN b.entidad = 'EP' THEN (SELECT ventidadpension.codigo 
                                                FROM   ventidadpension 
                                                WHERE  codigo = a.entidadpension and ventidadpension.activo=1
												 AND empresa = @empresa)
                    when b.entidad ='EARP' then  (SELECT vEntidadArp.codigo 
                                                FROM   vEntidadArp 
                                                WHERE  codigo = a.entidadArp and vEntidadArp.activo=1
												 AND empresa = @empresa)
					when b.entidad ='ECAJA' then  (SELECT vEntidadCaja.codigo 
                                                FROM   vEntidadCaja 
                                                WHERE  codigo = a.entidadCaja and vEntidadCaja.activo=1
												 AND empresa = @empresa)
					when b.entidad ='EICBF' then  (SELECT vEntidadIcbf.codigo 
                                                FROM   vEntidadIcbf 
                                                WHERE  codigo = a.entidadICBF and vEntidadIcbf.activo=1
												 AND empresa = @empresa)
					when b.entidad ='ESENA' then  (SELECT vEntidadSena.codigo 
                                                FROM   vEntidadSena 
                                                WHERE  codigo = a.entidadSena and vEntidadSena.activo=1
												 AND empresa = @empresa)
					when b.entidad ='EFONDO' then  (SELECT ventidadpension.codigo 
                                                FROM   ventidadpension 
                                                WHERE  codigo = a.entidadFondoS and ventidadpension.activo=1
												 AND empresa = @empresa)  
                  END 
                ELSE 
                  CASE 
                    WHEN lotedesarrollo = 1 THEN 
                      CASE 
                        WHEN @xTercero = 1 THEN a.codigoTercero 
                        ELSE Isnull(Isnull(b.tercero, ''), '') 
                      END 
                    ELSE 
                      CASE 
                        WHEN signo = 1 THEN 
                          CASE 
                            WHEN @xTercero = 1 THEN a.codigoTercero 
                            ELSE Isnull(Isnull(b.tercerocredito, 
                                        b.tercerocredito), '') 
                          END 
                        ELSE 
                          CASE 
                            WHEN @xTercero = 1 THEN a.codigoTercero 
                            ELSE Isnull(b.tercero, '') 
                          END 
                      END 
                  END 
              END, '') terceroContable, 
	   a.valortotal debito,
       0 credito , 
       a.entidadeps, 
       a.entidadpension, 
       a.entidadarp, 
       a.entidadcaja, 
       a.entidadsena, 
       a.entidadcesantias, 
       ''              entidadFS, 
	   a.entidadICBF,
	   ''			   entidadAdicional,
       a.mccostolote, 
       a.accostolote, 
       a.lotedesarrollo,
	   a.baseCesantias,--baseCesantias bit,
	   a.basePrimas,--basePrimas bit ,
	   a.baseIntereses,--baseIntereses bit,
	   a.baseVacaciones,--baseVacaciones bit,
	   a.baseEmbargo,--baseEmbargos bit,
	   a.baseCajaCompensacion,--baseCajaCompensacion bit,
	   a.baseSeguridadSocial,--baseSeguridadSocial bit
	   a.tipoConcepto,
	   a.ConceptoReferencia,
	   @estado ,
	     @fechaT,
	   getdate(),
	   @usuario
FROM   #tmpNomina a 
       LEFT JOIN cparametrocontanomi b 
              ON a.Concepto = b.concepto 
                 AND a.tiponovedad = 'N' 
                 AND a.empresa = b.empresa 
                 AND b.clase = @clase 
                 AND a.cccostonomina = b.ccosto and a.departamento=b.departamento 
	WHERE  a.empresa = @empresa and a.valorTotal>0  and rtrim(ltrim(b.departamento)) > 0 
	-- debito restanter
	set @maxRegistro = isnull((select max(registro) from cprecontabilizacion where tipo=@tipo and año=@año and mes=@mes and empresa=@empresa  ),0)
	insert cprecontabilizacion
	SELECT  a.empresa, 
       @tipo           tipo, 
       a.año, 
       a.mes, 
       a.periodocontable, 
        ROW_NUMBER()  over (order by  a.periodocontable   asc) + @maxRegistro registro ,
       a.terceroempleado, 
       a.codigoTercero, 
       a.tiponomina, 
       a.numeronomina, 
       a.contrato, 
       a.mes, 
       a.clasecontrato, 
       a.manejalc, 
       a.manejahe, 
       a.mccostonomina, 
       a.cccostonomina, 
       a.departamento, 
       a.Concepto, 
       a.novedadagronomica,
	         Isnull(CASE 
                WHEN isnull(b.manejaentidad,'') = 0 THEN 
                  CASE 
                    WHEN isnull(b.entidad,'') = 'EEPS' THEN (SELECT ventidadeps.cuenta 
                                                  FROM   ventidadeps 
                                                  WHERE  codigo = a.entidadeps 
                                                         AND empresa = @empresa) 
                    WHEN isnull(b.entidad,'') = 'EP' THEN (SELECT ventidadpension.cuenta 
                                                FROM   ventidadpension 
                                                WHERE  codigo = a.entidadpension 
												 AND empresa = @empresa)
                    when isnull(b.entidad,'') ='EARP' then  (SELECT vEntidadArp.cuenta 
                                                FROM   vEntidadArp 
                                                WHERE  codigo = a.entidadArp 
												 AND empresa = @empresa)
					when isnull(b.entidad,'') ='ECAJA' then  (SELECT vEntidadCaja.cuenta 
                                                FROM   vEntidadCaja 
                                                WHERE  codigo = a.entidadCaja 
												 AND empresa = @empresa)
					when isnull(b.entidad,'') ='EICBF' then  (SELECT vEntidadIcbf.cuenta 
                                                FROM   vEntidadIcbf 
                                                WHERE  codigo = a.entidadICBF 
												 AND empresa = @empresa)
					when isnull(b.entidad,'') ='ESENA' then  (SELECT vEntidadSena.cuenta 
                                                FROM   vEntidadSena 
                                                WHERE  codigo = a.entidadSena 
												 AND empresa = @empresa)
					when isnull(b.entidad,'')  ='EFONDO' then  (SELECT ventidadpension.cuenta 
                                                FROM   ventidadpension 
                                                WHERE  codigo = a.entidadFondoS 
												 AND empresa = @empresa)                       
                  END 
                ELSE 
                  CASE 
                    WHEN lotedesarrollo = 1 THEN 
                    isnull(Isnull(b.cuentaactivo, c.cuentaactivo),'') 
                    ELSE 
                      CASE 
                        WHEN a.signo = 2 THEN 
                          CASE 
                            WHEN 
                      Len(Ltrim(Rtrim(Isnull(b.cuentacredito, '')))) = 0 
                      AND Len(Ltrim(Rtrim(Isnull(c.cuentacredito, '')))) = 0 
                          THEN 
                           isnull(b.cuentagasto ,'')
                            ELSE isnull(Isnull(b.cuentacredito, c.cuentacredito) , '')
                          END 
                        ELSE isnull(Isnull(b.cuentagasto, c.cuentagasto) ,'')
                      END 
                  END 
              END, '') cuentaContable, 
	   Isnull(CASE 
                WHEN len(ltrim(rtrim(a.accostolote)))>0THEN a.mccostolote 
                else
              Isnull(Isnull(b.ccostomayorsigo, c.ccostomayorsigo), '') 
              END, '') mCcostoContable, 
       Isnull(CASE 
                WHEn len(ltrim(rtrim(a.accostolote)))>0 THEN a.accostolote 
                ELSE 
                     Isnull(Isnull(b.ccostosigo, c.ccostosigo), '') 
                  END 
              , '') aCcostoContable, 
       Isnull(CASE 
                WHEN b.manejaentidad = 1 THEN 
                  CASE 
                    WHEN b.entidad = 'EEPS' THEN (SELECT ventidadeps.codigo 
                                                  FROM   ventidadeps 
                                                  WHERE  codigo = a.entidadeps 
                                                         AND empresa = @empresa) 
                    WHEN b.entidad = 'EP' THEN (SELECT ventidadpension.codigo 
                                                FROM   ventidadpension 
                                                WHERE  codigo = a.entidadpension 
												 AND empresa = @empresa)
                    when b.entidad ='EARP' then  (SELECT vEntidadArp.codigo 
                                                FROM   vEntidadArp 
                                                WHERE  codigo = a.entidadArp 
												 AND empresa = @empresa)
					when b.entidad ='ECAJA' then  (SELECT vEntidadCaja.codigo 
                                                FROM   vEntidadCaja 
                                                WHERE  codigo = a.entidadCaja 
												 AND empresa = @empresa)
					when b.entidad ='EICBF' then  (SELECT vEntidadIcbf.codigo 
                                                FROM   vEntidadIcbf 
                                                WHERE  codigo = a.entidadICBF 
												 AND empresa = @empresa)
					when b.entidad ='ESENA' then  (SELECT vEntidadSena.codigo 
                                                FROM   vEntidadSena 
                                                WHERE  codigo = a.entidadSena 
												 AND empresa = @empresa)
					when b.entidad ='EFONDO' then  (SELECT ventidadpension.codigo 
                                                FROM   ventidadpension 
                                                WHERE  codigo = a.entidadFondoS 
												 AND empresa = @empresa)  
                  END 
                ELSE 
                  CASE 
                    WHEN lotedesarrollo = 1 THEN 
                      CASE 
                        WHEN @xTercero = 1 THEN a.codigoTercero 
                        ELSE Isnull(Isnull(b.tercero, c.tercero), '') 
                      END 
                    ELSE 
                      CASE 
                        WHEN signo = 1 THEN 
                          CASE 
                            WHEN @xTercero = 1 THEN a.codigoTercero 
                            ELSE Isnull(Isnull(b.tercerocredito, 
                                        b.tercerocredito), '') 
                          END 
                        ELSE 
                          CASE 
                            WHEN @xTercero = 1 THEN a.codigoTercero 
                            ELSE Isnull(b.tercero, c.tercerocredito) 
                          END 
                      END 
                  END 
              END, '') terceroContable, 
	   a.valortotal  debito,
       0 credito , 
       a.entidadeps, 
       a.entidadpension, 
       a.entidadarp, 
       a.entidadcaja, 
       a.entidadsena, 
       a.entidadcesantias, 
       ''              entidadFS, 
	   a.entidadICBF,
	   ''			   entidadAdicional,
       a.mccostolote, 
       a.accostolote, 
       a.lotedesarrollo,
	   a.baseCesantias,--baseCesantias bit,
	   a.basePrimas,--basePrimas bit ,
	   a.baseIntereses,--baseIntereses bit,
	   a.baseVacaciones,--baseVacaciones bit,
	   a.baseEmbargo,--baseEmbargos bit,
	   a.baseCajaCompensacion,--baseCajaCompensacion bit,
	   a.baseSeguridadSocial,--baseSeguridadSocial bit
	   a.tipoConcepto,
	   a.ConceptoReferencia,
	   @estado estado,
	     @fechaT,
	   getdate(),
	   @usuario
FROM   #tmpNomina a 
       LEFT JOIN cparametrocontanomi b 
              ON a.Concepto = b.concepto 
                 AND a.tiponovedad = 'N' 
                 AND a.empresa = b.empresa 
                 AND b.clase = @clase 
                 AND a.cccostonomina = b.ccosto and rtrim(ltrim(b.departamento)) = 0 
	   LEFT JOIN cparametrocontanomi c 
              ON a.tiponovedad + a.novedadagronomica = c.concepto 
                 AND a.tiponovedad = 'L' 
                 AND a.empresa = c.empresa 
                 AND c.clase = @clase 
                 AND a.cccostonomina = c.ccosto 
	WHERE  a.empresa = @empresa and a.valorTotal>0 --and a.terceroEmpleado=1110
	and   
	ISNULL(b.cCosto,'') + ISNULL(b.concepto,'') + ISNULL(convert(varchar(50), a.terceroempleado),'') not in 
	(select  accostoNomina + codigoConcepto + convert(varchar(50), codigoempleado) from cprecontabilizacion where tipo=@tipo 
	and año=@año and mes=@mes and periodoNomina =@periodo and debito>0 and empresa=@empresa)
end
if @tipo	=	'PA'
begin
  -- debito
  set @maxRegistro = isnull((select max(registro) from cprecontabilizacion where tipo=@tipo and año=@año and mes=@mes and empresa=@empresa  ),0)
  insert cprecontabilizacion
  SELECT  a.empresa, 
       @tipo           tipo, 
       a.año, 
       a.mes, 
       a.periodocontable, 
        ROW_NUMBER()  over (order by  a.periodocontable   asc) + @maxRegistro registro ,
       a.terceroempleado, 
       a.codigoTercero, 
       a.tiponomina, 
       a.numeronomina, 
       a.contrato, 
       a.periodoNomina, 
       a.clasecontrato, 
       a.manejalc, 
       a.manejahe, 
       a.mccostonomina, 
       a.cccostonomina, 
       a.departamento, 
       a.concepto, 
       a.novedadagronomica,
       Isnull(CASE 
                WHEN b.manejaentidad = 1 THEN
				  CASE WHEN a.tipoConcepto=@tipoInAccidenteTrabajo and a.concepto=@conceptoIncapacidad then  
				  (SELECT vEntidadArp.cuenta 
                                                  FROM   vEntidadArp 
                                                  WHERE  codigo = a.entidadArp
                                                         AND empresa = @empresa and vEntidadArp.activo=1) 
				  else 
                  CASE 
                    WHEN b.entidad = 'EEPS' THEN (SELECT ventidadeps.cuenta 
                                                  FROM   ventidadeps 
                                                  WHERE  codigo = a.entidadEps
                                                         AND empresa = @empresa and ventidadeps.activo=1) 
                    WHEN b.entidad = 'EP' THEN (SELECT ventidadpension.cuenta 
                                                FROM   ventidadpension 
                                                WHERE  codigo = a.entidadpension 
                                                       AND empresa = @empresa and ventidadpension.activo=1) 
                  END
				  END else  b.cuentagasto end ,'')     cuentacontable,
       isnull(b.cCostoMayorSigo, '') mCcostoContable, 
       isnull(b.ccostosigo,  '')     aCcostoContable, 
      case when len(b.tercero)>0 then b.tercero else  a.codigoTercero end terceroContable, 
	   valorTotal debito,
       0 credito , 
       a.entidadeps, 
       a.entidadpension, 
       a.entidadarp, 
       a.entidadcaja, 
       a.entidadsena, 
       a.entidadcesantias, 
       ''              entidadFS, 
	   a.entidadICBF,
	   ''			   entidadAdicional,
       a.mccostolote, 
       a.accostolote, 
       a.lotedesarrollo,
	   a.baseCesantias,--baseCesantias bit,
	   a.basePrimas,--basePrimas bit ,
	   a.baseIntereses,--baseIntereses bit,
	   a.baseVacaciones,--baseVacaciones bit,
	   a.baseEmbargo,--baseEmbargos bit,
	   a.baseCajaCompensacion,--baseCajaCompensacion bit,
	   a.baseSeguridadSocial,--baseSeguridadSocial bit
	   a.tipoConcepto,
	   a.ConceptoReferencia,
	   @estado estado,
	     @fechaT,
	   getdate(),
	   @usuario
FROM   #tmpPagoNomina a 
       LEFT JOIN cparametrocontanomi b 
              ON a.Concepto = b.concepto 
                 AND a.tiponovedad = 'N' 
                 AND a.empresa = b.empresa 
                 AND b.clase = @clase 
                 AND a.mccostoNomina = b.cCostoMayor 
	WHERE  a.empresa = @empresa 
  -- credito
  set @maxRegistro = isnull((select max(registro) from cprecontabilizacion where tipo=@tipo and año=@año and mes=@mes and empresa=@empresa  ),0)
  insert cprecontabilizacion
  SELECT  a.empresa, 
       @tipo           tipo, 
       a.año, 
       a.mes, 
       a.periodocontable, 
        ROW_NUMBER()  over (order by  a.periodocontable   asc) + @maxRegistro registro ,
       a.terceroempleado, 
       a.codigoTercero, 
       a.tiponomina, 
       a.numeronomina, 
       a.contrato, 
       a.periodoNomina, 
       a.clasecontrato, 
       a.manejalc, 
       a.manejahe, 
       a.mccostonomina, 
       a.cccostonomina, 
       a.departamento, 
       a.concepto, 
       a.novedadagronomica,
        Isnull(CASE 
                WHEN b.manejaentidad = 1 THEN
				  CASE WHEN a.tipoConcepto=@tipoInAccidenteTrabajo and a.concepto=@conceptoIncapacidad then  
				  (SELECT vEntidadArp.cuenta 
                                                  FROM   vEntidadArp 
                                                  WHERE  codigo = a.entidadArp
                                                         AND empresa = @empresa and vEntidadArp.activo=1) 
				  else 
                  CASE 
                    WHEN b.entidad = 'EEPS' THEN (SELECT ventidadeps.cuenta 
                                                  FROM   ventidadeps 
                                                  WHERE  codigo = a.entidadEps
                                                         AND empresa = @empresa and ventidadeps.activo=1) 
                    WHEN b.entidad = 'EP' THEN (SELECT ventidadpension.cuenta 
                                                FROM   ventidadpension 
                                                WHERE  codigo = a.entidadpension 
                                                       AND empresa = @empresa and ventidadpension.activo=1) 
                  END
				  END else  b.cuentaCredito end ,'')      cuentacontable,
       isnull(b.cCostoMayorCredito, '') mCcostoContable, 
       isnull(b.cCostoCredito,  '')     aCcostoContable, 
       case when len(b.terceroCredito)>0 then b.terceroCredito else  a.codigoTercero end terceroContable, 
	   0 debito,
       valorTotal credito , 
       a.entidadeps, 
       a.entidadpension, 
       a.entidadarp, 
       a.entidadcaja, 
       a.entidadsena, 
       a.entidadcesantias, 
       ''              entidadFS, 
	   a.entidadICBF,
	   ''			   entidadAdicional,
       a.mccostolote, 
       a.accostolote, 
       a.lotedesarrollo,
	   a.baseCesantias,--baseCesantias bit,
	   a.basePrimas,--basePrimas bit ,
	   a.baseIntereses,--baseIntereses bit,
	   a.baseVacaciones,--baseVacaciones bit,
	   a.baseEmbargo,--baseEmbargos bit,
	   a.baseCajaCompensacion,--baseCajaCompensacion bit,
	   a.baseSeguridadSocial,--baseSeguridadSocial bit
	   a.tipoConcepto,
	   a.ConceptoReferencia,
	   @estado estado,
	     @fechaT,
	   getdate(),
	   @usuario
FROM   #tmpPagoNomina a 
       LEFT JOIN cparametrocontanomi b 
              ON a.Concepto = b.concepto 
                 AND a.tiponovedad = 'N' 
                 AND a.empresa = b.empresa 
                 AND b.clase = @clase 
                 AND a.mccostoNomina = b.cCostoMayor 
	WHERE  a.empresa = @empresa and a.valorTotal>0 
end
if @tipo	=	'CC'
begin
set @maxRegistro = isnull((select max(registro) from cprecontabilizacion where tipo=@tipo and año=@año and mes=@mes and empresa=@empresa  ),0)
-- Contabilizacion contratista
insert cprecontabilizacion
SELECT a.empresa, 
       @tipo           tipo, 
       a.año, 
       @mes, 
       a.periodocontable, 
        ROW_NUMBER()  over (order by  a.empresa   asc) + @maxRegistro registro ,
       a.terceroempleado, 
       a.codigoTercero, 
       a.tiponomina, 
       a.numeronomina, 
       a.contrato, 
       a.periodonomina, 
       a.clasecontrato, 
       a.manejalc, 
       a.manejahe, 
       a.mccostonomina, 
       a.cccostonomina, 
       a.departamento, 
       a.concepto, 
       a.novedadagronomica, 
       Isnull(CASE 
                WHEN b.manejaentidad = 1 THEN 
                  CASE 
                    WHEN b.entidad = 'EEPS' THEN (SELECT ventidadeps.cuenta 
                                                  FROM   ventidadeps 
                                                  WHERE  codigo = a.entidadeps 
                                                         AND empresa = @empresa) 
                    WHEN b.entidad = 'EP' THEN (SELECT ventidadpension.cuenta 
                                                FROM   ventidadpension 
                                                WHERE  codigo = a.entidadpension 
                                                       AND empresa = @empresa) 
                  END 
                ELSE 
                  CASE 
                    WHEN lotedesarrollo = 1 THEN 
                    Isnull(b.cuentaactivo, c.cuentaactivo) 
                    ELSE 
                      CASE 
                        WHEN a.signo = 2 THEN 
                          CASE 
                            WHEN 
                      Len(Ltrim(Rtrim(Isnull(b.cuentacredito, '')))) = 0 
                      AND Len(Ltrim(Rtrim(Isnull(c.cuentacredito, '')))) = 0 
                          THEN 
                            isnull(b.cuentagasto, c.cuentaGasto)
                            ELSE Isnull(b.cuentacredito, c.cuentacredito) 
                          END 
                        ELSE Isnull(b.cuentagasto, c.cuentagasto) 
                      END 
                  END 
              END, '') cuentaContable, 
	   Isnull(CASE 
                WHEN len( ltrim( rtrim( a.mccostolote)))>0 THEN a.mccostolote 
                ELSE 
                  CASE 
                    WHEN a.signo = 2 THEN Isnull( 
                    Isnull(b.ccostomayorcredito, c.ccostomayorcredito), '') 
                    ELSE 
              Isnull(Isnull(b.ccostomayorsigo, c.ccostomayorsigo), '') 
                  END 
              END, '') mCcostoContable, 
       Isnull(CASE 
                WHEN len( ltrim( rtrim( a.accostolote)))>0  THEN a.accostolote 
                ELSE 
                  CASE 
                    WHEN a.signo = 2 THEN Isnull( 
                    Isnull(b.ccostocredito, c.ccostocredito), '') 
                    ELSE Isnull(Isnull(b.ccostosigo, c.ccostosigo), '') 
                  END 
              END, '') aCcostoContable, 
       Isnull(CASE 
                WHEN b.manejaentidad = 1 THEN 
                  CASE 
                    WHEN b.entidad = 'EEPS' THEN (SELECT ventidadeps.codigo 
                                                  FROM   ventidadeps 
                                                  WHERE  codigo = a.entidadeps 
                                                         AND empresa = @empresa) 
                    WHEN b.entidad = 'EP' THEN (SELECT ventidadpension.codigo 
                                                FROM   ventidadpension 
                                                WHERE  codigo = a.entidadpension 
                                                       AND empresa = @empresa) 
                  END 
                ELSE 
                  CASE 
                    WHEN lotedesarrollo = 1 THEN 
                      CASE 
                        WHEN @xTercero = 1 THEN a.codigoTercero 
                        ELSE Isnull(Isnull(b.tercero, c.tercero), '') 
                      END 
                    ELSE 
                      CASE 
                        WHEN signo = 2 THEN 
                          CASE 
                            WHEN @xTercero = 1 THEN a.codigoTercero 
                            ELSE Isnull(Isnull(b.tercerocredito, 
                                        b.tercerocredito), '') 
                          END 
                        ELSE 
                          CASE 
                            WHEN @xTercero = 1 THEN a.codigoTercero 
                            ELSE Isnull(b.tercero, c.tercerocredito) 
                          END 
                      END 
                  END 
              END, '') terceroContable, 
       CASE 
         WHEN a.signo <> 2 THEN a.valortotal 
		 else 0
       END                  debito, 
       CASE 
         WHEN a.signo = 2 THEN a.valortotal 
         ELSE 0 
       END           credito, 
       a.entidadeps, 
       a.entidadpension, 
       a.entidadarp, 
       a.entidadcaja, 
       a.entidadsena, 
       a.entidadcesantias, 
       ''              entidadFS, 
	   a.entidadICBF,
	   ''			   entidadAdicional,
       a.mccostolote, 
       a.accostolote, 
       a.lotedesarrollo,
	   a.baseCesantias,--baseCesantias bit,
	   a.basePrimas,--basePrimas bit ,
	   a.baseIntereses,--baseIntereses bit,
	   a.baseVacaciones,--baseVacaciones bit,
	   a.baseEmbargo,--baseEmbargos bit,
	   a.baseCajaCompensacion,--baseCajaCompensacion bit,
	   a.baseSeguridadSocial,--baseSeguridadSocial bit
	   a.tipoConcepto,
	   a.ConceptoReferencia,
	   @estado ,
	     @fechaT,
	   getdate(),
	   @usuario
FROM   #tmpNomina a 
       LEFT JOIN cparametrocontanomi b 
              ON a.Concepto = b.concepto 
                 AND a.tiponovedad = 'N' 
                 AND a.empresa = b.empresa 
                 AND b.clase = @clase 
       LEFT JOIN cparametrocontanomi c 
              ON a.tiponovedad + a.novedadagronomica = c.concepto 
                 AND a.tiponovedad = 'L' 
                 AND a.empresa = c.empresa 
                 AND c.clase = @clase 
WHERE  a.empresa = @empresa 
if @cuentaCruce<>''
begin
set @maxRegistro = isnull((select max(registro) from cprecontabilizacion where tipo=@tipo and año=@año and mes=@mes and empresa=@empresa  ),0)
-- Contrapartida  ---  con @cuentaCruce
insert cprecontabilizacion	
SELECT a.empresa, 
       @tipo                    tipo, 
       a.año, 
       @mes, 
       a.periodocontable, 
        ROW_NUMBER()  over (order by  a.empresa   asc) + @maxRegistro registro ,                    
       a.terceroempleado, 
       a.codigoTercero, 
       a.tiponomina, 
       a.numeronomina, 
       a.contrato, 
       a.periodonomina, 
       a.clasecontrato, 
       a.manejalc, 
       a.manejahe, 
       a.mccostonomina, 
       a.cccostonomina, 
       a.departamento, 
       a.Concepto, 
       a.novedadagronomica, 
       Isnull(@cuentaCruce, '') cuentaContable, 
	   CASE 
         WHEN Len(Ltrim(Rtrim(Isnull(@mCcostoCruceContable, '')))) != 0 THEN 
         @mCcostoCruceContable 
         ELSE Isnull(CASE 
                       WHEN a.mccostolote IS NOT NULL THEN a.mccostolote 
                       ELSE 
                         CASE 
                           WHEN a.signo = 2 THEN 
                           Isnull(Isnull(b.ccostomayorcredito, 
                                  c.ccostomayorcredito), '') 
                           ELSE Isnull(Isnull(b.ccostomayorsigo, 
                                       c.ccostomayorsigo), '' 
                                ) 
                         END 
                     END, '') 
       END                      mCcostoContable, 
       CASE 
         WHEN Len(Ltrim(Rtrim(Isnull(@aCcostoCruceContable, '')))) != 0 THEN 
         @mCcostoCruceContable 
         ELSE Isnull(CASE 
                       WHEN a.accostolote IS NOT NULL THEN a.accostolote 
                       ELSE 
                         CASE 
                           WHEN a.signo = 2 THEN Isnull( 
                           Isnull(b.ccostocredito, c.ccostocredito), '') 
                           ELSE Isnull(Isnull(b.ccostosigo, c.ccostosigo), '') 
                         END 
                     END, '') 
       END                      aCcostoContable, 
       Isnull(CASE 
                WHEN b.manejaentidad = 1 THEN 
                  CASE 
                    WHEN b.entidad = 'EEPS' THEN (SELECT ventidadeps.codigo 
                                                  FROM   ventidadeps 
                                                  WHERE  codigo = a.entidadeps 
                                                         AND empresa = @empresa) 
                    WHEN b.entidad = 'EP' THEN (SELECT ventidadpension.codigo 
                                                FROM   ventidadpension 
                                                WHERE  codigo = a.entidadpension 
                                                       AND empresa = @empresa) 
                  END 
                ELSE 
                  CASE 
                    WHEN lotedesarrollo = 1 THEN 
                      CASE 
                        WHEN @xTercero = 1 THEN a.codigoTercero
                        ELSE Isnull(Isnull(b.tercero, c.tercero), '') 
                      END 
                    ELSE 
                      CASE 
                        WHEN signo = 2 THEN 
                          CASE 
                            WHEN @xTercero = 1 THEN a.codigoTercero 
                            ELSE Isnull(Isnull(b.tercerocredito, 
                                        b.tercerocredito), '') 
                          END 
                        ELSE 
                          CASE 
                            WHEN @xTercero = 1 THEN a.codigoTercero 
                            ELSE Isnull(b.tercero, c.tercerocredito) 
                          END 
                      END 
                  END 
              END, '')          terceroContable, 
       CASE 
         WHEN a.signo = 1 THEN 0 
         ELSE a.valortotal 
       END  debito, 
       CASE 
         WHEN a.signo = 1 THEN a.valortotal 
         ELSE 0 
       END  credito, 
       a.entidadeps, 
       a.entidadpension, 
       a.entidadarp, 
       a.entidadcaja, 
       a.entidadsena, 
       a.entidadcesantias, 
       ''                       entidadFS, 
	     a.entidadICBF,
	   '' entidadAdicional,
       a.mccostolote, 
       a.accostolote, 
       a.lotedesarrollo,
	    a.baseCesantias,--baseCesantias bit,
	   a.basePrimas,--basePrimas bit ,
	   a.baseIntereses,--baseIntereses bit,
	   a.baseVacaciones,--baseVacaciones bit,
	   a.baseEmbargo,--baseEmbargos bit,
	   a.baseCajaCompensacion,--baseCajaCompensacion bit,
	   a.baseSeguridadSocial,--baseSeguridadSocial bit
	   a.tipoConcepto,
	   a.ConceptoReferencia,
	   @estado,
	     @fechaT,
	   getdate(),
	   @usuario 
FROM   #tmpNomina a 
       LEFT JOIN cparametrocontanomi b 
              ON a.Concepto = b.concepto 
                 AND a.tiponovedad = 'N' 
                 AND a.empresa = b.empresa 
                 AND b.clase = @clase 
       LEFT JOIN cparametrocontanomi c 
              ON a.tiponovedad + a.novedadagronomica = c.concepto 
                 AND a.tiponovedad = 'L' 
                 AND a.empresa = c.empresa 
                 AND c.clase = @clase 
WHERE  a.empresa = @empresa and a.valorTotal>0 

end
end
if @tipo	=	'CI'
begin
  -- debito
  set @maxRegistro = isnull((select max(registro) from cprecontabilizacion where tipo=@tipo and año=@año and mes=@mes and empresa=@empresa  ),0)
  insert cprecontabilizacion
  SELECT  a.empresa, 
       @tipo           tipo, 
       a.año, 
       a.mes, 
       a.periodocontable, 
        ROW_NUMBER()  over (order by  a.periodocontable   asc) + @maxRegistro registro ,
       a.terceroempleado, 
       a.codigoTercero, 
       a.tiponomina, 
       a.numeronomina, 
       a.contrato, 
       a.periodoNomina, 
       a.clasecontrato, 
       a.manejalc, 
       a.manejahe, 
       a.mccostonomina, 
       a.cccostonomina, 
       a.departamento, 
       a.concepto, 
       a.novedadagronomica,
        CASE WHEN a.tipoConcepto=@tipoInAccidenteTrabajo and a.concepto=@conceptoIncapacidad 
		then  isnull(b.cuentaActivo,'') else isnull(b.cuentagasto ,'')  end    cuentacontable,
       isnull(b.cCostoMayorSigo, '') mCcostoContable, 
       isnull(b.ccostosigo,  '')     aCcostoContable, 
       Isnull(CASE 
                WHEN b.manejaentidad = 1 THEN
				  CASE WHEN a.tipoConcepto=@tipoInAccidenteTrabajo and a.concepto=@conceptoIncapacidad then  
				  (SELECT vEntidadArp.codigo 
                                                  FROM   vEntidadArp 
                                                  WHERE  codigo = a.entidadArp
                                                         AND empresa = @empresa and vEntidadArp.activo=1) 
				  else 
                  CASE 
                    WHEN b.entidad = 'EEPS' THEN (SELECT ventidadeps.codigo 
                                                  FROM   ventidadeps 
                                                  WHERE  codigo = a.entidadEps
                                                         AND empresa = @empresa and ventidadeps.activo=1) 
                    WHEN b.entidad = 'EP' THEN (SELECT ventidadpension.codigo 
                                                FROM   ventidadpension 
                                                WHERE  codigo = a.entidadpension 
                                                       AND empresa = @empresa and ventidadpension.activo=1) 
                  END
				  END 
                ELSE a.codigoTercero end,'')  terceroContable , 
	   valorTotal debito,
       0 credito , 
       a.entidadeps, 
       a.entidadpension, 
       a.entidadarp, 
       a.entidadcaja, 
       a.entidadsena, 
       a.entidadcesantias, 
       ''              entidadFS, 
	   a.entidadICBF,
	   ''			   entidadAdicional,
       a.mccostolote, 
       a.accostolote, 
       a.lotedesarrollo,
	   a.baseCesantias,--baseCesantias bit,
	   a.basePrimas,--basePrimas bit ,
	   a.baseIntereses,--baseIntereses bit,
	   a.baseVacaciones,--baseVacaciones bit,
	   a.baseEmbargo,--baseEmbargos bit,
	   a.baseCajaCompensacion,--baseCajaCompensacion bit,
	   a.baseSeguridadSocial,--baseSeguridadSocial bit
	   a.tipoConcepto,
	   a.ConceptoReferencia,
	   @estado estado,
	     @fechaT,
	   getdate(),
	   @usuario
FROM   #tmpNomina a 
       LEFT JOIN cparametrocontanomi b  on
              --ON a.Concepto = b.concepto 
                 a.tiponovedad = 'N' 
                 AND a.empresa = b.empresa 
                 AND b.clase = @clase 
                 AND a.mccostoNomina = b.cCostoMayor 
	WHERE  a.empresa = @empresa 
  -- credito
  set @maxRegistro = isnull((select max(registro) from cprecontabilizacion where tipo=@tipo and año=@año and mes=@mes and empresa=@empresa  ),0)
  insert cprecontabilizacion
  SELECT  a.empresa, 
       @tipo           tipo, 
       a.año, 
       a.mes, 
       a.periodocontable, 
        ROW_NUMBER()  over (order by  a.periodocontable   asc) + @maxRegistro registro ,
       a.terceroempleado, 
       a.codigoTercero, 
       a.tiponomina, 
       a.numeronomina, 
       a.contrato, 
       a.periodoNomina, 
       a.clasecontrato, 
       a.manejalc, 
       a.manejahe, 
       a.mccostonomina, 
       a.cccostonomina, 
       a.departamento, 
       a.concepto, 
       a.novedadagronomica,
       isnull(b.cuentaCredito ,'')     cuentacontable,
       isnull(b.cCostoMayorCredito, '') mCcostoContable, 
       isnull(b.cCostoCredito,  '')     aCcostoContable, 
       Isnull(CASE 
                WHEN b.manejaentidad = 0 THEN
				  CASE WHEN a.tipoConcepto=@tipoInAccidenteTrabajo and a.concepto=@conceptoIncapacidad then  
				  (SELECT vEntidadArp.cuenta 
                                                  FROM   vEntidadArp 
                                                  WHERE  codigo = a.entidadArp
                                                         AND empresa = @empresa and vEntidadArp.activo=1) 
				  else 
                  CASE 
                    WHEN b.entidad = 'EEPS' THEN (SELECT ventidadeps.cuenta 
                                                  FROM   ventidadeps 
                                                  WHERE  codigo = a.entidadEps
                                                         AND empresa = @empresa and ventidadeps.activo=1) 
                    WHEN b.entidad = 'EP' THEN (SELECT ventidadpension.cuenta 
                                                FROM   ventidadpension 
                                                WHERE  codigo = a.entidadpension 
                                                       AND empresa = @empresa and ventidadpension.activo=1) 
                  END
				  END 
                ELSE a.codigoTercero end,'')  terceroContable, 
	   0 debito,
       valorTotal credito , 
       a.entidadeps, 
       a.entidadpension, 
       a.entidadarp, 
       a.entidadcaja, 
       a.entidadsena, 
       a.entidadcesantias, 
       ''              entidadFS, 
	   a.entidadICBF,
	   ''			   entidadAdicional,
       a.mccostolote, 
       a.accostolote, 
       a.lotedesarrollo,
	   a.baseCesantias,--baseCesantias bit,
	   a.basePrimas,--basePrimas bit ,
	   a.baseIntereses,--baseIntereses bit,
	   a.baseVacaciones,--baseVacaciones bit,
	   a.baseEmbargo,--baseEmbargos bit,
	   a.baseCajaCompensacion,--baseCajaCompensacion bit,
	   a.baseSeguridadSocial,--baseSeguridadSocial bit
	   a.tipoConcepto,
	   a.ConceptoReferencia,
	   @estado estado,
	     @fechaT,
	   getdate(),
	   @usuario
FROM   #tmpNomina a 
       LEFT JOIN cparametrocontanomi b on
              --ON a.Concepto = b.concepto 
                  a.tiponovedad = 'N' 
                 AND a.empresa = b.empresa 
                 AND b.clase = @clase 
                 AND a.mccostoNomina = b.cCostoMayor 
	WHERE  a.empresa = @empresa and a.valorTotal>0 
end
end
if @@ERROR = 0
begin	
commit tran cprecontabilizacion
end
else
begin
set @retorno=1
rollback tran cprecontabilizacion
end
--go

--declare @retorno int
--exec [dbo].[spPrecontabilizaNominaTipoPeriodo] 
----- parametros
--2016, 
--25,
--'pr',
--1,
--'29/07/2016',
--'sistema',
--@retorno  output