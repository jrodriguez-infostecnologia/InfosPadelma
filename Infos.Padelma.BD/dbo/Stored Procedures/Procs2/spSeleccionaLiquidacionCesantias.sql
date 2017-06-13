create proc [dbo].[spSeleccionaLiquidacionCesantias]
@empresa int,
@año int
as

select a.*,b.codigo identificacionTercero,b.descripcion nombreTercero,c.ccosto,d.descripcion nombreCcosto,
e.codigo ccostoMayor,e.descripcion nombreccostoMayor from nLiquidacionCesantiaDetalle a
join cTercero b on b.id=a.tercero and b.empresa=a.empresa
join nContratos c on c.id=a.contrato and c.tercero=a.tercero and c.empresa=a.empresa
join cCentrosCosto d on d.codigo=c.ccosto and d.empresa=c.empresa
left join cCentrosCosto e on e.codigo=d.mayor and e.empresa=d.empresa
where a.empresa=@empresa and a.año=@año