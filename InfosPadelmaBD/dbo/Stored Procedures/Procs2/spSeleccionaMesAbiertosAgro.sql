create proc [dbo].[spSeleccionaMesAbiertosAgro]
@año int,
@empresa int
as


select mes, DATENAME(month,convert(date,(cast(año as char(4))+'/'+cast(mes as varchar(50))+'/01')))descripcion from aperiodo
where cerrado=0 and año=@año and empresa=@empresa and mes<> 13
order by mes