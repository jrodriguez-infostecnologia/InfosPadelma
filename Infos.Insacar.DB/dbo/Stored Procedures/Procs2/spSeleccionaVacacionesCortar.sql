create proc spSeleccionaVacacionesCortar
@tercero int,
@empresa int,
@fechainicial date,
@fechaFinal date,
@registro int
as


select año,periodo, empleado from nVacaciones
where empresa=@empresa and empleado=@tercero and periodoInicial=@fechainicial and periodoFinal =@fechaFinal
and registro=@registro