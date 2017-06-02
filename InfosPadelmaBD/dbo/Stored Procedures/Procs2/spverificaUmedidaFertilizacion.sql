create proc spverificaUmedidaFertilizacion
@umedida varchar(50),
@empresa int,
@retorno int output
as

if @umedida = 'BUL'
begin
	set @retorno=1
end
else
begin
set @retorno=0
end