CREATE FUNCTION fRetornaNombreMes(@mes int)
RETURNS varchar(50)
AS
BEGIN
	
	DECLARE @nombreMes varchar(50)

	if(@mes=1)
		set @nombreMes='Enero'
	if(@mes=2)
		set @nombreMes='Febrero'
	if(@mes=3)
		set @nombreMes='Marzo'
	if(@mes=4)
		set @nombreMes='Abril'
	if(@mes=5)
		set @nombreMes='Mayo'
	if(@mes=6)
		set @nombreMes='Junio'
	if(@mes=7)
		set @nombreMes='Julio'
	if(@mes=8)
		set @nombreMes='Agosto'
	if(@mes=9)
		set @nombreMes='Septiembre'
	if(@mes=10)
		set @nombreMes='Octubre'
	if(@mes=11)
		set @nombreMes='Noviembre'
	if(@mes=12)
		set @nombreMes='Diciembre'

	RETURN @nombreMes

END