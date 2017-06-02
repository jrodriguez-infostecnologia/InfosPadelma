
CREATE proc [dbo].[spVerificaFechaVacaciones]
@empresa int,
@empleado int,
@fecha date,
@retorno int output
as

set @retorno=0

if exists (select * from nVacaciones where @fecha between fechaSalida and dateadd(day,-1,fechaRetorno) and empleado=@empleado and anulado=0 and empresa=@empresa)
begin
set @retorno = 1
end

if exists (select * from nIncapacidad
where @fecha between fechaInicial and fechaFinal
and tercero=@empleado and empresa=@empresa and anulado=0)
begin
set @retorno = 2
end