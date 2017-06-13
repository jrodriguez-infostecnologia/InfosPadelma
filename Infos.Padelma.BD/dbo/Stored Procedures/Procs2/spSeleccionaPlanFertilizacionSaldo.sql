CREATE proc [dbo].[spSeleccionaPlanFertilizacionSaldo]
@empresa int
as
select DISTINCT CONVERT(varchar(50), a.fecha,112) +'-' + convert(varchar(50), a.fechaFinal,112) periodo ,a.fecha fechaI, a.fechaFinal fechaF , a.finca , e.descripcion desfinca, b.lote, 
b.item, d.descripcion desitem, b.uMedida, b.noPalmas, b.dosis,b.cantidad, a.tipo, a.numero, b.saldo , b.registro,  añoSiembra,
year(getdate()) - añoSiembra edad, f.hNetas, g.descripcion variedad,
isnull((select sum(isnull(resta,0) - isnull(suma,0) ) from atransaccionItemSaldo w where w.referencia = a.numero and w.empresa=a.empresa and b.lote=w.lote),0) ejecutado
from aTransaccion a  
join aTransaccionItem  b 
on a.tipo=b.tipo and a.numero=b.numero and a.empresa=b.empresa
join aTransaccionItem c on a.tipo=b.tipo and a.numero=b.numero and a.empresa=c.empresa
join iItems d on b.item = d.codigo and d.empresa=b.empresa
join aFinca e on a.finca=e.codigo and e.empresa=a.empresa
join aLotes f on b.lote=f.codigo and f.empresa=a.empresa
join aVariedad g on f.variedad=g.codigo and g.empresa=f.empresa
where anulado=0 and A.tipo='PFA' 
and a.empresa=@empresa
order by edad