CREATE proc [dbo].[spSeleccionaNovedadPrecios]
@año int,
@empresa int
as

if exists(select * from  anovedadloteprecio where año=@año  and empresa=@empresa) 
begin
	select distinct @año año , b.codigo  novedad,b.descripcion desNovedad, isnull(precioDestajo,0)precioDestajo, 
	isnull(precioContratistas,0) precioContratistas, isnull(precioOtros,0)precioOtros, isnull(porcentaje,0)porcentaje,
	isnull(modificado,0)modificado,isnull(baseSueldo,0)baseSueldo  
	from anovedad b 
	left  join anovedadloteprecio a on a.novedad=b.codigo and a.empresa=b.empresa and a.año=@año 
	where b.empresa=@empresa and b.activo=1
end
else
begin
	select distinct @año año, a.codigo novedad, a.descripcion desNovedad, 0 precioDestajo,
	0 precioContratistas, 0 precioOtros, 0 porcentaje,cast(0 as bit) baseSueldo from anovedad a 
	where a.empresa=@empresa and a.activo=1
end