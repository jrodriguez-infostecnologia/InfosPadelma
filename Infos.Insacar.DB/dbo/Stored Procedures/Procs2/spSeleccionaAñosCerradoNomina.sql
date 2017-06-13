create proc [dbo].[spSeleccionaAñosCerradoNomina]
@empresa int
as

select distinct año from nPeriodoDetalle
where cerrado=1 and empresa=@empresa