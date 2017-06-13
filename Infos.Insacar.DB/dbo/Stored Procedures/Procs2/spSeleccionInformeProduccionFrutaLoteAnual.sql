CREATE proc [dbo].[spSeleccionInformeProduccionFrutaLoteAnual]
@empresa int,
@año int
as

select a.añoSiembra,a.codLote,a.nombreLote,a.palmasProduccion palmas,a.hNetas noHas, sum(cantidadLabor) kilos,SUM(racimoLabor)racimos,sum(cantidadLabor) /SUM(racimoLabor) pesoPromedio,
YEAR(a.fecha) año,month(a.fecha) mes,dbo.fRetornaNombreMes(month(a.fecha)) nombreMes
from vSeleccionLaboresProuduccion a
where a.empresa=@empresa and a.claseLabor=2 and year(a.fecha)=@año and a.anulado=0 
group by  añoSiembra,codLote,nombreLote,palmasProduccion,hNetas,year(fecha),MONTH(fecha)