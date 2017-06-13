create proc spSeleccionaPeriodosNomina
 @año int, @empresa int
as


select noPeriodo, 
cast(año as varchar) + ' - ' + cast(noPeriodo as varchar) + ' del ' + CAST(fechaInicial as varchar) + ' al ' +  CAST(fechaFinal as varchar)
descripcion
 from nPeriodoDetalle
where año=@año and empresa=@empresa