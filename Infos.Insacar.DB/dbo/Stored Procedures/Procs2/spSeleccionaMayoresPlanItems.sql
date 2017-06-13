create proc spSeleccionaMayoresPlanItems
@plan varchar(50),
@empresa int
as


select * from iMayorItem
where planes=@plan and empresa=@empresa