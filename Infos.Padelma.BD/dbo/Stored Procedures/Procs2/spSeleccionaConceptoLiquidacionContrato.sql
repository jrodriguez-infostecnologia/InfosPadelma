CREATE proc [dbo].[spSeleccionaConceptoLiquidacionContrato]
@empresa int
as
	select a.concepto codConcepto, b.descripcion desConcepto,sum(a.cantidad) cantidad, avg(a.valorUnitario) valorUnitario,sum(a.valorTotal)valorTotal,b.signo,b.prestacionsocial
	 from tmpliquidacionNomina a
	join nConcepto b on b.codigo=a.concepto and b.empresa=a.empresa
	join cTercero c on c.id=a.tercero and c.empresa=a.empresa
	where a.empresa=@empresa
	group by   a.concepto , b.descripcion , b.signo,b.prestacionSocial
	union
	select '9999', 'Total Liquidación',sum( case when a.signo=2 then  a.cantidad*-1 else a.cantidad end ) cantidad, avg(a.valorUnitario) valorUnitario,sum(case when a.signo=2 then  a.valorTotal*-1 else a.valorTotal end)valorTotal,0,0
	 from tmpliquidacionNomina a
	where a.empresa=@empresa
	order by codConcepto