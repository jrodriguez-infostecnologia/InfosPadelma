create proc spSeleccionaCriteriosItem
@empresa int,
@item int

as



select * from iItemsCriterios
where empresa=@empresa and item=@item