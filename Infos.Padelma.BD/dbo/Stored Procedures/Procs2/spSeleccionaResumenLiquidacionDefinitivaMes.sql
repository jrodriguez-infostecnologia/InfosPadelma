CREATE proc [dbo].[spSeleccionaResumenLiquidacionDefinitivaMes]
@empresa int,
@año int,
@mes int
as

select a.empresa,a.mayor,c.descripcion nombreMayor, a.codCCosto codigoCentroCostoClase,a.nombreCcosto nombreCentroCostoClase,a.codConcepto concepto, d.descripcion nombreConcepto,
 SUM(a.cantidad) cantidad, case when a.signo=1 then SUM(a.valorTotal) else 0 end valorDebito,
 case when a.signo=2 then SUM(a.valorTotal) else 0 end valorCredito,a.signo ,
  COUNT(a.codtercero) noTrabajador,
 a.fecha, a.fechaInicial, a.fechaFinal, a.año, a.mes, 
 CONVERT(varchar(4), a.año) + RTRIM(RIGHT('00' + RTRIM(a.mes), 2)) AS periodoUnido, DATENAME(MONTH, a.fecha) AS nombreMes 
 from vSeleccionaLiquidacionDefinitiva a
join cCentrosCosto c on c.codigo=a.mayor and c.empresa=a.empresa
join nConcepto d on d.codigo=a.codconcepto and d.empresa=a.empresa
where a.empresa=@empresa and a.mes=@mes and a.año=@año  and a.anulado=0
group by a.empresa,a.mayor,c.descripcion, a.codCCosto,a.nombreCcosto,a.codconcepto,a.mes,
 d.descripcion ,a.signo, a.fecha, a.fechaInicial, a.fechaFinal, a.año, a.mes