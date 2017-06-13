CREATE proc [dbo].[spSeleccionaSesionesFinca]
@empresa int,
@finca varchar(50)
as

select * from aSecciones
where empresa=@empresa and finca=@finca
and activo=1