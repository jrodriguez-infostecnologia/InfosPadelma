CREATE proc [dbo].[spSeleccionaResumenPrenomina]
@empresa int

as


select b.empresa,b.mayor,c.descripcion nombreMayor, b.codigo codigoCentroCostoClase,b.descripcion nombreCentroCostoClase,a.concepto, d.descripcion nombreConcepto,
CASE WHEN d.noMostrar = 1 THEN Sum(a.cantidadPadelma) ELSE sum(a.cantidad) END AS cantidad, 
case when a.signo=1 then CASE WHEN d.noMostrar = 1 THEN sum(a.valorPadelma) ELSE sum(a.valorTotal) END else 0 end valorDebito,
case when a.signo=2 then CASE WHEN d.noMostrar = 1 THEN sum(a.valorPadelma) ELSE sum(a.valorTotal) END else 0 end valorCredito,a.signo ,a.noPeriodo, COUNT(a.tercero) noTrabajador,
 a.fecha, a.fechaInical, a.fechaFinal, a.año, a.mes, CONVERT(varchar(4), a.año) + RTRIM(RIGHT('00' + RTRIM(a.mes), 2)) AS periodoUnido, DATENAME(MONTH, a.fecha) AS nombreMes 
 from tmpliquidacionNomina a
 join cCentrosCosto b on b.codigo=a.ccosto and b.empresa=a.empresa
 join cCentrosCosto c on c.codigo=b.mayor and c.empresa=b.empresa
 join nConcepto d on d.codigo=a.concepto and d.empresa=a.empresa
where a.empresa=@empresa 
group by b.empresa,b.mayor,c.descripcion, b.codigo,b.descripcion,a.concepto,a.noPeriodo, d.descripcion ,a.signo, a.fecha, a.fechaInical, a.fechaFinal, a.año, a.mes,d.noMostrar