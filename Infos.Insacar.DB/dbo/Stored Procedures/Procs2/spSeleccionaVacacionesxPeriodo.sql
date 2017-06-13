CREATE proc spSeleccionaVacacionesxPeriodo
@empresa int,
@año int,
@periodo int
as

select * from vvacaciones
where añoPago=@año and periodo=@periodo  
and anulado=0 and empresa=@empresa