CREATE proc [dbo].[spSeleccionaLaboresLoteFechaFertilizacion]
@fi date,
@ff date,
@empresa int
as


select numero,codGrupoLabor codCCosto,nombreGrupoLabor nombreCCosto,codLote,nombreLote,nombreLabor,codLabor,SUM(cantidadTercero) cantidad,a.uMedida,
SUM(valorTotalTercero) valorTotal, precioLabor, fechaLabor, DATENAME(month, fechaLabor) nombreMes, DATEPART(month,fechaLabor) mes,
añoSiembra, palmasBrutas, palmasProduccion, item iditem, c.descripcion desitem, b.cantidad cantidadItem, b.uMedida umedidaitem
from vTransaccionAgronomico a  join 
aTransaccionItem b on a.codtransaccion=b.tipo and a.numeroTransaccion=b.numero and a.codEmpresa=b.empresa
and a.codLote=b.lote
join iItems c on c.codigo=b.item and a.codEmpresa=c.empresa
where convert(date,fechaTransaccion) between @fi and @ff and codEmpresa=@empresa and anulado=0
group by numero,codGrupoLabor,nombreGrupoLabor,codLote,nombreLote,nombreLabor,codLabor,a.uMedida,precioLabor, fechaLabor,añoSiembra, palmasBrutas, palmasProduccion,
item , c.descripcion , b.cantidad,  b.uMedida