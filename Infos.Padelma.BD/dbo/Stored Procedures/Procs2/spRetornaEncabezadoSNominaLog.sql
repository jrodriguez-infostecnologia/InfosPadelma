CREATE proc [dbo].[spRetornaEncabezadoSNominaLog]
@empresa int,
@fechaInicial date,
@fechaFinal date
as

select * from sLogNomina
where empresa=@empresa and CONVERT(date, fechaRegistro) between @fechaInicial and @fechaFinal