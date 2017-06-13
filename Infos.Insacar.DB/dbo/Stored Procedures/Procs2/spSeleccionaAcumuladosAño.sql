CREATE proc [dbo].[spSeleccionaAcumuladosAño]
@empresa int,
@año int,
@mes int
as

select a.año,a.mes, dbo.fRetornaNombreMes(a.mes) nombreMes,codTercero idEmpleado, identificacion Identificacion,
a.nombreTercero nombreEmpleado,sum(a.cantidad) cantidad, SUM(CASE WHEN a.signo=2 then a.valorTotal*-1 else a.valorTotal end ) valorTotal, codConcepto codConcepto, 
 nombreConcepto, a.signo
  from vSeleccionaLiquidacionDefinitiva a
where a.anulado=0 and a.año=@año and a.mes=@mes and a.empresa=@empresa
group by a.año,a.mes, codTercero, a.identificacion,a.nombreConcepto,codConcepto ,a.nombreTercero, a.signo