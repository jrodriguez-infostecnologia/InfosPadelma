CREATE proc [dbo].[spSeleccionaMesAbiertosNomina]
@año int,
@empresa int
as select distinct mes, DATENAME(month,convert(date,(cast(año as char(4))+'/'+cast(mes as varchar(50))+'/01')))descripcion from nPeriodoDetalle
where cerrado=0 and 
año=@año and empresa=@empresa and mes<> 13
order by mes