create proc [dbo].[spSeleccionaAñosAbiertosAgro]
@empresa int
as

select distinct año from aperiodo
where cerrado=0 and empresa=@empresa