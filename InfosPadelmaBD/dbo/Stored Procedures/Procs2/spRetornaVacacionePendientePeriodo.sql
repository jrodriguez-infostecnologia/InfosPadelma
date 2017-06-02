CREATE proc [dbo].[spRetornaVacacionePendientePeriodo]
@empresa int,
@empleado int,
@periodoInicial date,
@periodoFinal date
as

if exists(
select top 1  * from nvacaciones
where empleado=@empleado and empresa=@empresa 
and periodoInicial = @periodoInicial and periodoFinal=@periodoFinal
and anulado<>1
order by fechaSalida desc, registro desc)
begin
select top 1  * from nvacaciones
where empleado=@empleado and empresa=@empresa 
and periodoInicial = @periodoInicial and periodoFinal=@periodoFinal
and anulado<>1 
order by fechaSalida desc
end
else
begin
select top 1  * from nvacaciones
where empleado=@empleado and empresa=@empresa 
and anulado<>1
order by periodoInicial desc
end