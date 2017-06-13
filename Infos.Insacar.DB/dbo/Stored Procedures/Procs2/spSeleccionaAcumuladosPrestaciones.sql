CREATE proc [dbo].[spSeleccionaAcumuladosPrestaciones]
@empresa int,
@añoInicial int,
@añoFinal int,
@periodoInicial int,
@periodoFinal int
as


select 1 tipo, 'Base Primas' conceptoPS ,a.tercero,c.descripcion nombreTercero,a.concepto,b.descripcion nombreConcepto,
		sum(a.cantidad) cantidad,sum(case when b.signo=2 then a.valorTotal*-1 else a.valorTotal end ) valorTotal ,MAX(d.id) 
		 from nLiquidacionNominaDetalle a
	join nConcepto b on b.codigo=a.concepto and b.empresa=a.empresa
	join cTercero c on c.id=a.tercero and c.empresa=a.empresa
	join nContratos d on d.tercero =a.tercero and a.contrato=d.id and d.empresa=a.empresa
	join nLiquidacionNomina e on e.numero=a.numero and e.tipo=a.tipo and e.anulado=0 and a.empresa=e.empresa
	where  a.empresa=@empresa and b.basePrimas=1 and  e.anulado=0
	and (a.año>=@añoInicial and a.noPeriodo>=@periodoInicial)
	and (a.año<=@añoFinal and a.noPeriodo<=@periodoFinal)
	group by a.tercero,c.descripcion,a.concepto,b.descripcion
	union
	select 2, 'Base Vacaciones' conceptoPS ,a.tercero,c.descripcion nombreTercero,a.concepto,b.descripcion nombreConcepto,
		sum(a.cantidad) cantidad,sum(case when b.signo=2 then a.valorTotal*-1 else a.valorTotal end ) valorTotal ,MAX(d.id) 
		 from nLiquidacionNominaDetalle a
	join nConcepto b on b.codigo=a.concepto and b.empresa=a.empresa
	join cTercero c on c.id=a.tercero and c.empresa=a.empresa
	join nContratos d on d.tercero =a.tercero and a.contrato=d.id and d.empresa=a.empresa
	join nLiquidacionNomina e on e.numero=a.numero and e.tipo=a.tipo and e.anulado=0 and a.empresa=e.empresa
	where  a.empresa=@empresa and b.baseVacaciones=1 and  e.anulado=0
	and (a.año>=@añoInicial and a.noPeriodo>=@periodoInicial)
	and (a.año<=@añoFinal and a.noPeriodo<=@periodoFinal)
	group by a.tercero,c.descripcion,a.concepto,b.descripcion
		union
	select 3, 'Base Cesantias' conceptoPS ,a.tercero,c.descripcion nombreTercero,a.concepto,b.descripcion nombreConcepto,
		sum(a.cantidad) cantidad,sum(case when b.signo=2 then a.valorTotal*-1 else a.valorTotal end ) valorTotal ,MAX(d.id) 
		 from nLiquidacionNominaDetalle a
	join nConcepto b on b.codigo=a.concepto and b.empresa=a.empresa
	join cTercero c on c.id=a.tercero and c.empresa=a.empresa
	join nContratos d on d.tercero =a.tercero and a.contrato=d.id and d.empresa=a.empresa
	join nLiquidacionNomina e on e.numero=a.numero and e.tipo=a.tipo and e.anulado=0 and a.empresa=e.empresa
	where  a.empresa=@empresa and b.baseCesantias=1 and  e.anulado=0
	and (a.año>=@añoInicial and a.noPeriodo>=@periodoInicial)
	and (a.año<=@añoFinal and a.noPeriodo<=@periodoFinal)
	group by a.tercero,c.descripcion,a.concepto,b.descripcion
	union
	select 4, 'Base ISS' conceptoPS ,a.tercero,c.descripcion nombreTercero,a.concepto,b.descripcion nombreConcepto,
		sum(a.cantidad) cantidad,sum(case when b.signo=2 then a.valorTotal*-1 else a.valorTotal end ) valorTotal ,MAX(d.id) 
		 from nLiquidacionNominaDetalle a
	join nConcepto b on b.codigo=a.concepto and b.empresa=a.empresa
	join cTercero c on c.id=a.tercero and c.empresa=a.empresa
	join nContratos d on d.tercero =a.tercero and a.contrato=d.id and d.empresa=a.empresa
	join nLiquidacionNomina e on e.numero=a.numero and e.tipo=a.tipo and e.anulado=0 and a.empresa=e.empresa
	where  a.empresa=@empresa and b.baseSeguridadSocial=1 and  e.anulado=0
	and (a.año>=@añoInicial and a.noPeriodo>=@periodoInicial)
	and (a.año<=@añoFinal and a.noPeriodo<=@periodoFinal)
	group by a.tercero,c.descripcion,a.concepto,b.descripcion
	union
	select 5, 'Base Caja Comp.' conceptoPS,
	a.tercero,c.descripcion nombreTercero,a.concepto,b.descripcion nombreConcepto,
		sum(a.cantidad) cantidad,sum(case when b.signo=2 then a.valorTotal*-1 else a.valorTotal end ) valorTotal ,MAX(d.id) 
		 from nLiquidacionNominaDetalle a
	join nConcepto b on b.codigo=a.concepto and b.empresa=a.empresa
	join cTercero c on c.id=a.tercero and c.empresa=a.empresa
	join nContratos d on d.tercero =a.tercero and a.contrato=d.id and d.empresa=a.empresa
	join nLiquidacionNomina e on e.numero=a.numero and e.tipo=a.tipo and e.anulado=0 and a.empresa=e.empresa
	where  a.empresa=@empresa and b.baseCajaCompensacion=1 and  e.anulado=0
	and (a.año>=@añoInicial and a.noPeriodo>=@periodoInicial)
	and (a.año<=@añoFinal and a.noPeriodo<=@periodoFinal)
	group by a.tercero,c.descripcion,a.concepto,b.descripcion