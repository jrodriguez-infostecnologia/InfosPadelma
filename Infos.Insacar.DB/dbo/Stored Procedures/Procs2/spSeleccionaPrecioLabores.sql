create proc spSeleccionaPrecioLabores
@empresa int,
@año int
as

select a.*,b.descripcion from aNovedadLotePrecio a
join aNovedad b on b.codigo=a.novedad and b.empresa=a.empresa
where a. empresa=@empresa and año=@año