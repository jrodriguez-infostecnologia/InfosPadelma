create proc spSeleccionaPeriodoDetalle
@año int,
@empresa int
as

select * from nPeriodoDetalle
where empresa=@empresa and año=@año