create proc [dbo].[spConsecutivoVacaciones]
@empresa int,
@empleado int,
@periodoInicial date,
@periodoFinal date,
@consecutivo int output
as

set @consecutivo = 
(
select max(registro) +1 from nVacaciones
where empresa=@empresa and empleado=@empleado 
and periodoInicial=@periodoInicial and periodoFinal=@periodoFinal
)

if @consecutivo is null
set @consecutivo=1