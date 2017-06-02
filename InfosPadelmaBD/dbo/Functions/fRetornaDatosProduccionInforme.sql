CREATE FUNCTION [dbo].[fRetornaDatosProduccionInforme]
	( @item		varchar(50),
	  @producto	varchar(10),
	  @movimiento		varchar(50),
	  @fecha	date,
	  @empresa int )
RETURNS float
AS

BEGIN

	declare @dato float, @INI float, @FR float, @FP float 
	declare @año char(6)=year(@fecha),@PP FLOAT,@PTP float,@planta varchar(50)
	
	
	set @dato = 0
	
	--select @planta=planta from pPlantaProducto
	--where producto=@producto

	


	if( @item = 'D' )
	begin
	
	if( @movimiento in ('EX') )
	begin
			
	if (@producto='CPO' OR @producto='ADPA')		
	begin
		 set @PP= (select  SUM( valor )
		from vTransaccionesProduccion 
		where refProducto='FRU' AND refMovimiento='FP' and
		fecha=@fecha and empresa=@empresa)
	end
	else
	begin
		select  @PP= SUM( valor )
		from vTransaccionesProduccion 
		where refMovimiento='AP' and refProducto='ADPA' AND
		fecha=@fecha and empresa=@empresa
	end

		select  @PTP= SUM( valor )
		from vTransaccionesProduccion 
		where refProducto=@producto and refMovimiento='PRO' and
		fecha=@fecha and empresa=@empresa
		
	
		set @dato=isnull((@PTP/nullif(@PP,0)),0)*100
			
	end
	ELSE
	BEGIN
		set @dato =(select top 1 valor
		from vTransaccionesProduccion	
		where
		refProducto = @producto and
		refMovimiento = @movimiento and
		CONVERT( date,fecha ) = @fecha and empresa=@empresa)
	END
	end	
		
	
	if( @item = 'S' )
	begin	
	
		if	@movimiento='INI'
		BEGIN
		select top 1 @dato = valor
		from vTransaccionesProduccion	
		where
		refproducto = @producto and
		refMovimiento = @movimiento and empresa=@empresa and
		fecha=(select min( b.fecha )
				  from vTransaccionesProduccion b
				  where
					producto = b.producto and empresa=@empresa and
				  DATEPART( WEEK,b.fecha ) =  DATEPART( WEEK,@fecha ) and
				  DATEPART(MONTH,convert(date,fecha))= DATEPART(MONTH,convert(date,@fecha))  
				)	and
		 DATEPART(week,convert(date,fecha))= DATEPART(week,convert(date,@fecha)) and 
		DATEPART(MONTH,convert(date,fecha))= DATEPART(MONTH,convert(date,@fecha))  
		END
		
		if	@movimiento='INISLL'
		BEGIN
		select top 1 @dato = valor
		from vTransaccionesProduccion	
		where
		refproducto = @producto and
		refmovimiento = @movimiento and empresa=@empresa and
		fecha=(select min( b.fecha )
				  from vTransaccionesProduccion b
				  where
					producto = b.producto and empresa=@empresa and
				  DATEPART( WEEK,b.fecha ) =  DATEPART( WEEK,@fecha ) and
				  DATEPART(MONTH,convert(date,fecha))= DATEPART(MONTH,convert(date,@fecha))  
				)	and
		 DATEPART(week,convert(date,fecha))= DATEPART(week,convert(date,@fecha)) and 
		DATEPART(MONTH,convert(date,fecha))= DATEPART(MONTH,convert(date,@fecha))  
		END
		
			if	@movimiento='INISV'
		BEGIN
		select top 1 @dato = valor
		from vTransaccionesProduccion	
		where
		refproducto = @producto and
		refmovimiento = @movimiento and empresa=@empresa and
		fecha=(select min( b.fecha )
				  from vTransaccionesProduccion b
				  where
					producto = b.producto and empresa=@empresa and
				  DATEPART( WEEK,b.fecha ) =  DATEPART( WEEK,@fecha ) and
				  DATEPART(MONTH,convert(date,fecha))= DATEPART(MONTH,convert(date,@fecha))  
				)	and
		 DATEPART(week,convert(date,fecha))= DATEPART(week,convert(date,@fecha)) and 
		DATEPART(MONTH,convert(date,fecha))= DATEPART(MONTH,convert(date,@fecha))  
		END
		
	if( @movimiento = 'EX' )
	Begin		
		
	if (@producto='CPO' OR @producto='ADPA')		
	begin
		select  @PP= SUM( valor )
		from vTransaccionesProduccion a
		where refproducto='FRU' AND refMovimiento='FP' and
			DATEPART(week,convert(date,fecha))= DATEPART(week,convert(date,@fecha)) and 
		DATEPART(MONTH,convert(date,fecha))= DATEPART(MONTH,convert(date,@fecha)) and empresa=@empresa
	end
	else
	begin
		select  @PP= SUM( valor )
		from vTransaccionesProduccion a
		where a.refmovimiento='AP' and a.refproducto='ADPA' AND
		DATEPART(week,convert(date,fecha))= DATEPART(week,convert(date,@fecha)) and 
		DATEPART(MONTH,convert(date,fecha))= DATEPART(MONTH,convert(date,@fecha)) and empresa=@empresa
	end
		
		select  @PTP= SUM( valor )
		from vTransaccionesProduccion a
		where A.refproducto=@producto and a.refmovimiento='PRO' and
		DATEPART(week,convert(date,fecha))= DATEPART(week,convert(date,@fecha)) and 
		DATEPART(MONTH,convert(date,fecha))= DATEPART(MONTH,convert(date,@fecha)) and empresa=@empresa
		
		set @dato=(@PTP/@PP)*100
		
		end	
	
		if	@movimiento<>'INI' AND @movimiento<>'IFSV' AND @movimiento<>'INISLL' AND @movimiento<>'INISV' AND @movimiento<>'IFSLL' AND @movimiento<>'EX' AND @movimiento<>'IF' AND (select almacena from pProductoMovimiento where @movimiento=movimiento and producto=@producto)  <>1
		BEGIN
		select @dato = sum(isnull(valor,0))
		from vTransaccionesProduccion	
		where
		refproducto = @producto and
		refMovimiento = @movimiento and
		DATEPART(week,convert(date,fecha))= DATEPART(week,convert(date,@fecha)) and 
		DATEPART(MONTH,convert(date,fecha))= DATEPART(MONTH,convert(date,@fecha))   and empresa=@empresa
		END
			
	
		if	@movimiento='IF'
		BEGIN
		select @dato= isnull(valor,0)
		from vTransaccionesProduccion	
		where
		refProducto = @producto and
		refMovimiento = @movimiento and empresa=@empresa and
		fecha=(select max( b.fecha )
				  from vTransaccionesProduccion b
				  where
					producto = b.producto and empresa=@empresa and
				  DATEPART( WEEK,b.fecha ) =  DATEPART( WEEK,@fecha ) and
				  YEAR( b.fecha ) = YEAR( @fecha ) )
		  and
		DATEPART(week,convert(date,fecha))= DATEPART(week,convert(date,@fecha)) and 
		DATEPART(MONTH,convert(date,fecha))= DATEPART(MONTH,convert(date,@fecha))
		END
		
		if	@movimiento='IFSV' 
		BEGIN
		select @dato= isnull(valor,0)
		from vTransaccionesProduccion	
		where
		refproducto = @producto and
		refMovimiento = @movimiento and empresa=@empresa and
		fecha=(select max( b.fecha )
				  from vTransaccionesProduccion b
				  where
					producto = b.producto and empresa=@empresa and
				  DATEPART( WEEK,b.fecha ) =  DATEPART( WEEK,@fecha ) and
				  YEAR( b.fecha ) = YEAR( @fecha ) )
		  and
		DATEPART(week,convert(date,fecha))= DATEPART(week,convert(date,@fecha)) and 
		DATEPART(MONTH,convert(date,fecha))= DATEPART(MONTH,convert(date,@fecha))
		END
		
		if	@movimiento='IFSLL' 
		BEGIN
		select @dato= isnull(valor,0)
		from vTransaccionesProduccion	
		where
		refproducto = @producto and
		refmovimiento = @movimiento and empresa=@empresa and
		fecha=(select max( b.fecha )
				  from vTransaccionesProduccion b
				  where
					producto = b.producto and empresa=@empresa and
				  DATEPART( WEEK,b.fecha ) =  DATEPART( WEEK,@fecha ) and
				  YEAR( b.fecha ) = YEAR( @fecha ) )
		  and
		DATEPART(week,convert(date,fecha))= DATEPART(week,convert(date,@fecha)) and 
		DATEPART(MONTH,convert(date,fecha))= DATEPART(MONTH,convert(date,@fecha))
		END
			
				end	
				
					
	return @dato

END