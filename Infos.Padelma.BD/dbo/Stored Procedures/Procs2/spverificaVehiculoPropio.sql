create proc [dbo].[spverificaVehiculoPropio]
@vehiculo varchar(50),
@empresa int,
@retorno  int output
as

set @retorno=0

if exists(
select * from bVehiculo
where codigo=@vehiculo and empresa = @empresa)
begin
set @retorno= 1
end