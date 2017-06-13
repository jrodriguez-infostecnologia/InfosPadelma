create proc spSeleccionaProductosActivos
@empresa int
as
select * from iItems
where tipo='P' and activo=1 and empresa=@empresa