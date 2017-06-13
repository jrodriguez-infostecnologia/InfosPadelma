CREATE proc spSeleccionaPeriodosPlanFertilizacion
@empresa int
as

declare @tipotransaccon varchar(50) = 'PFA'

select DISTINCT  CONVERT(varchar(50), a.fecha,112) +'-' + convert(varchar(50), a.fechaFinal,112) periodo , 'Plan del ' + convert(varchar(50), a.fecha) + ' al ' + convert(varchar(50), a.fechaFinal) rango 
 from aTransaccion a  
join aTransaccionItem  b 
on a.tipo=b.tipo and a.numero=b.numero and a.empresa=b.empresa
join aTransaccionItem c on a.tipo=b.tipo and a.numero=b.numero and a.empresa=c.empresa
join iItems d on b.item = d.codigo and d.empresa=b.empresa
join aFinca e on a.finca=e.codigo and e.empresa=a.empresa
join aLotes f on b.lote=f.codigo and f.empresa=a.empresa
join aVariedad g on f.variedad=g.codigo and g.empresa=f.empresa
where anulado=0 and A.tipo=@tipotransaccon and b.saldo>0
and a.empresa=@empresa