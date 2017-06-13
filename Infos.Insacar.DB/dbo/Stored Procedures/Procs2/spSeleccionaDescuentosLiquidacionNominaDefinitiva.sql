CREATE proc [dbo].[spSeleccionaDescuentosLiquidacionNominaDefinitiva]
@empresa int,
@año int,
@periodo int
as

select a.identificacion, a.codTercero, a.nombreTercero, a.codCCosto, a.nombreCcosto, a.sueldo, a.nombreCargo, a.codConcepto,
 a.nombreConcepto, a.cantidad,a.valorConcepto, case when  a.saldo=0 then null else a.saldo end saldo, a.noPeriodo, 
 case when a.mostrarFecha=1 then a.fechaLabor else null end fecha, a.fechaInicial, a.fechaFinal, a.año,
  a.mes, a.periodoUnido, a.nombreMes, a.nombreDepartamento, a.codDepto, a.signo, a.empresa, a.entidadEps, a.entidadPension, a.nombreEPS,
   a.nombrePension, a.prioridad, a.mostrarFecha, a.noMostrar, 
   isnull(b.labor, case when a.mostrarDetalle=1 then a.codConcepto else 'NA' end )labor,
   isnull(b.cantidad,a.cantidad) cantLabor,
	b.precioLabor precioLabor,isnull(b.desLabor,a.nombreConcepto) desLabor,b.lote,isnull(b.fechaLabor,a.fechaLabor )fechaLabor,b.jornales, 
(select sum(valorConcepto) from  vSeleccionaInformeLiquidacionDefinitiva where codTercero=a.codTercero and empresa=a.empresa and signo=1 and anulado=0 and año=a.año and mes=a.mes and noPeriodo=a.noPeriodo) TotalDevendado,
(select sum(valorConcepto) from  vSeleccionaInformeLiquidacionDefinitiva where codTercero=a.codTercero and empresa=a.empresa and signo=2 and anulado=0 and año=a.año and mes=a.mes and noPeriodo=a.noPeriodo) TotalDeducido,
b.umedida,isnull(b.diaSemana, datename(WEEKDAY,a.fechaLabor)) diaSemana, isnull((b.precioLabor * b.cantidad * (case when b.signo=2 then -1 else 1 end)),a.valorConcepto) TotalLabor,
convert (int,substring(b.numero,4,len(b.numero))) numero,b.tipo,c.mayor cCostoMayor,
p.fechaInicial fip,p.fechaFinal ffp, a.tipoConcepto, a.desTipoConcepto
from vSeleccionaInformeLiquidacionDefinitiva a
join cCentrosCosto c on c.codigo=a.codCCosto and c.empresa=a.empresa
join nPeriodoDetalle p on p.noPeriodo=a.noPeriodo and p.año=a.año and p.empresa=a.empresa
 left join vSeleccionaLaboresTerceroLiquida b on b.empresa=a.empresa 
 and b.fecha between a.fechaInicial and a.fechaFinal and b.concepto=a.codConcepto 
 and a.codTercero=b.tercero --and a.signo=b.signo
where  a.empresa=@empresa and a.noPeriodo=@periodo and a.año=@año and a.anulado=0 
and a.tipo like '%LQN%'
and a.signo=2