create proc [dbo].[spSeleccionaAñosAbiertosNomina]
@empresa int
as

select distinct año from nPeriodoDetalle
where cerrado=0 and empresa=@empresa