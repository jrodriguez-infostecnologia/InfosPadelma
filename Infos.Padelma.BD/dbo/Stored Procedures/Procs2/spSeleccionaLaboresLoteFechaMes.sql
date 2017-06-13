CREATE proc [dbo].[spSeleccionaLaboresLoteFechaMes]
@fi date,
@ff date,
@empresa int
as


select codCCosto,nombreCCosto,codLote,nombreLote,nombreLabor,codLabor,SUM(cantidadTercero) cantidad,uMedida,SUM(cantidadTercero)*precioLabor valorTotal, precioLabor, fechaLabor, DATENAME(month, fechaLabor) nombreMes, DATEPART(month,fechaLabor) mes,
b.añoSiembra, b.palmasBrutas, b.palmasProduccion
from vSeleccionaTransaccionesAgronomico a join aLotes  b on a.codLote=b.codigo and a.codEmpresa=b.empresa
where fechaLabor between @fi and @ff and codEmpresa=@empresa 
group by codCCosto,nombreCCosto,codLote,nombreLote,nombreLabor,codLabor,uMedida,precioLabor  , fechaLabor,b.añoSiembra, b.palmasBrutas, b.palmasProduccion