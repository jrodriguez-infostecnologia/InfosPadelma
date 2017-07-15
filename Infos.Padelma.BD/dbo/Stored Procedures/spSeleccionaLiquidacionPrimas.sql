CREATE proc [dbo].[spSeleccionaLiquidacionPrimas]
@empresa int = 2,
@año int = 2017,
@numero varchar(50) = 'PRI000000000003'
as

select 
a.*,
b.codigo identificacionTercero,
b.descripcion nombreTercero,
c.ccosto,
d.descripcion nombreCcosto,
e.codigo ccostoMayor,
e.descripcion nombreccostoMayor 
from nLiquidacionPrima x 
INNER JOIN nLiquidacionPrimaDetalle a on x.empresa= a.empresa and x.numero = a.numero and x.tipo = a.tipo
join cTercero b on b.id=a.tercero and b.empresa=a.empresa
join nContratos c on c.id=a.contrato and c.tercero=a.tercero and c.empresa=a.empresa
join cCentrosCosto d on d.codigo=c.ccosto and d.empresa=c.empresa
left join cCentrosCosto e on e.codigo=d.mayor and e.empresa=d.empresa
where a.empresa=@empresa
AND @año = x.año
AND a.numero = @numero