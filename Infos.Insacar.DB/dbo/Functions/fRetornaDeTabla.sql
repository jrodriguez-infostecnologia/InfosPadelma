CREATE FUNCTION [dbo].[fRetornaDeTabla]
	(  
	@tipo varchar(50),
	@producto varchar(50),
	@movimiento varchar(50),
	@empresa int,
	@variable float
	
	  )
RETURNS float
AS

BEGIN

declare @valor float

if @tipo='TDT'
begin

set @valor = ISNULL((select densidad from pDensidad	
where temperatura = convert(int,@variable) and item =@producto and empresa =@empresa),0)
end


if @tipo='ZER'
begin

if @variable>0
	set @valor =1
else
	set @valor =0
	
end

if @tipo='TAT'
begin
	declare @metros int, @centimetro int, @milimetro int
	set @metros = convert(int,(convert(int,@variable)/10))*10
	set @centimetro = convert(int,(convert(int,@variable) - @metros))
	set @milimetro = round(((@variable-convert(int,@variable))*10),0)
	
	if not exists(select * from pCalibracionTanque where movimiento=@movimiento and tipo='CI'
	and empresa=@empresa  and altura=@metros)
	begin
		
		set @milimetro =(@variable)*10 
		set @valor = isnull((select volumen from pCalibracionTanque 
		where movimiento=@movimiento and altura =@milimetro and tipo='FO' and empresa=@empresa),0)
	end
	else
	begin
		set @valor = isnull((select volumen from pCalibracionTanque 
		where movimiento=@movimiento and altura =@metros and tipo='CI' and empresa=@empresa),0)
		
		set @valor = @valor + isnull((select volumen from pCalibracionTanque 
		where movimiento=@movimiento and altura =@centimetro and tipo='CM' and empresa=@empresa),0)
		
		set @valor = @valor + isnull((select volumen from pCalibracionTanque 
		where movimiento=@movimiento and altura =@milimetro and tipo='MM' and empresa=@empresa),0)
	end
end


return @valor

END