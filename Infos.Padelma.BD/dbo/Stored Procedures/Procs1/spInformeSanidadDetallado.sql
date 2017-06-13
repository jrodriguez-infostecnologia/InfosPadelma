create proc spInformeSanidadDetallado
@empresa int,
@fechaInicial date,
@fechaFinal date
as

select * from [dbo].[vTransaccionesSanidad]
where empresa=@empresa and fechaT between @fechaInicial and @fechaFinal