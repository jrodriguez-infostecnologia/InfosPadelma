CREATE proc [dbo].[spSeleccionaAñosAbiertos]
@empresa int
as

select distinct año from cperiodo
where cerrado=0 and empresa=@empresa