CREATE proc [dbo].[spSeleccionaResumenLiquidacionDefinitivaEtidades]
@empresa int,
@año int,
@periodo int,
@numero varchar(50)
as

select b.empresa,b.mayor,c.descripcion nombreMayor, b.codigo codigoCentroCostoClase,b.descripcion nombreCentroCostoClase,a.codConcepto  concepto, d.descripcion nombreConcepto,
 SUM(a.cantidad) cantidad, case when a.signo=1 then SUM(a.valorTotal) else 0 end valorDebito,
 case when a.signo=2 then SUM(a.valorTotal) else 0 end valorCredito,a.signo ,a.noPeriodo,
  COUNT(a.codtercero) noTrabajador,
 a.fecha, a.fechaInicial, a.fechaFinal, a.año, a.mes, CONVERT(varchar(4), a.año) + RTRIM(RIGHT('00' + RTRIM(a.mes), 2)) AS periodoUnido, DATENAME(MONTH, a.fecha) AS nombreMes 
 from vSeleccionaLiquidacionDefinitiva a
join cCentrosCosto b on b.codigo=a.codccosto and b.empresa=a.empresa
join cCentrosCosto c on c.codigo=b.mayor and c.empresa=b.empresa
join nConcepto d on d.codigo=a.codconcepto and d.empresa=a.empresa
where a.empresa=@empresa and a.noPeriodo=@periodo and a.año=@año and a.numero like '%'+@numero+'%' and a.anulado=0
group by b.empresa,b.mayor,c.descripcion, b.codigo,b.descripcion,a.codconcepto,a.noPeriodo, d.descripcion ,a.signo, a.fecha, a.fechaInicial, a.fechaFinal, a.año, a.mes