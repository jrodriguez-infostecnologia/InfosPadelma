CREATE proc [dbo].[spSeleccionaAcumuladosAñoEmpleado]
@empresa int,
@año int,
@mes int
as

select distinct codTercero idEmpleado, identificacion Identificacion,a.nombreTercero nombreEmpleado
  from vSeleccionaLiquidacionDefinitiva a
where a.anulado=0 and a.año=@año and a.mes=@mes and a.empresa=@empresa
group by a.año,a.mes, codTercero, a.identificacion,a.nombreConcepto,codConcepto ,a.nombreTercero, a.signo,a.noPeriodo
order by a.nombreTercero