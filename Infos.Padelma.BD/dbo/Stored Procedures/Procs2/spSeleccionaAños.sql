create proc [dbo].[spSeleccionaAños]
@empresa int
as

select distinct año from cperiodo
where empresa=@empresa