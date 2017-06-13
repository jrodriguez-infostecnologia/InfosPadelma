create proc [spSeleccionaPrecontabilizaNominaTipoPeriodo]
@empresa int,
@año int,
@periodo int,
@tipo varchar(50)
as

select * from vPrecontabilizacionNomina
where empresa=@empresa and año=@año and periodoNomina = @periodo and tipo=@tipo