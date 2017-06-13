CREATE proc [dbo].[spSeleccionaLaboresLoteFecha]
@fi date,
@ff date,
@empresa int
as


select codGrupoLabor codCCosto,nombreGrupoLabor nombreCCosto,codLote,nombreLote,nombreLabor,codLabor,SUM(cantidadTercero) cantidad,uMedida,
SUM(valorTotalTercero) valorTotal, precioLabor, fechaLabor, DATENAME(month, fechaLabor) nombreMes, DATEPART(month,fechaLabor) mes,
añoSiembra, palmasBrutas, palmasProduccion
from vTransaccionAgronomico 
where convert(date,fechaTransaccion) between @fi and @ff and codEmpresa=@empresa and anulado=0
group by codGrupoLabor,nombreGrupoLabor,codLote,nombreLote,nombreLabor,codLabor,uMedida,precioLabor, fechaLabor,añoSiembra, palmasBrutas, palmasProduccion