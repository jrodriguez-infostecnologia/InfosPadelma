
create proc [dbo].[spSeleccionaNoPeriodosAñoNomina]
@año int,
@empresa int,
@noPeriodo int output
as
set @noPeriodo = isnull((select count(noPeriodo) from nPeriodoDetalle
where año=@año  and empresa=@empresa),0)