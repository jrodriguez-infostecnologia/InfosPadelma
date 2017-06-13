CREATE FUNCTION [dbo].[fRetornaUltimodiaMes](@mes int, @año int,@tercero int , @SLN varchar(1))
RETURNS int
AS
BEGIN
	
	declare @dia int,@totalDias int

	set @totalDias = case when @SLN='X' then 30 else (select SUM(Dias_Cotizados_Salud) from vDatosSeguridadSocialParaRedondeo where mes=@mes and año=@año and codigo_Empleado=@tercero) end 
	set @dia = 30 -  case when @totalDias>30 then @totalDias else 30 end
	
	RETURN  @dia

END