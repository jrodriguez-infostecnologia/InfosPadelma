CREATE proc [dbo].[spSeleccionInformeProduccionFrutaLoteFecha]
@empresa int,
@fi date,
@ff date
as

select a.añoSiembra,a.codLote,a.nombreLote,a.palmasProduccion palmas,a.hNetas noHas, sum(cantidadLabor) kilos,SUM(racimoLabor)racimos,sum(cantidadLabor) /SUM(racimoLabor) pesoPromedio,
(select sum(cantidadLabor) from vSeleccionLaboresProuduccion
where empresa=@empresa and claseLabor=2 and year(fecha)=year(@fi) and fecha<=@ff and anulado=0 and codLote=a.codLote
group by  añoSiembra,codLote,nombreLote,palmasProduccion,hNetas) kilosAcumulado,
(select sum(racimoLabor) from vSeleccionLaboresProuduccion
where empresa=@empresa and claseLabor=2 and year(fecha)=year(@fi) and fecha<=@ff and anulado=0 and codLote=a.codLote
group by  añoSiembra,codLote,nombreLote,palmasProduccion,hNetas) RacimosAcumulados,
(select sum(cantidadLabor)/SUM(racimoLabor) from vSeleccionLaboresProuduccion
where empresa=@empresa and claseLabor=2 and year(fecha) =year(@fi) and fecha<=@ff and anulado=0 and codLote=a.codLote
group by  añoSiembra,codLote,nombreLote,palmasProduccion,hNetas) pesoPromedioAcumulado
from vSeleccionLaboresProuduccion a
where a.empresa=@empresa and a.claseLabor=2 and a.fecha between @fi and @ff and a.anulado=0 
group by  añoSiembra,codLote,nombreLote,palmasProduccion,hNetas