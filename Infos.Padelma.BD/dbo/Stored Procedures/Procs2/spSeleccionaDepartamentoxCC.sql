
create proc [dbo].[spSeleccionaDepartamentoxCC]
@empresa int,
@ccosto varchar(50)
as

select * from nDepartamento
where ccosto=@ccosto and empresa=@empresa