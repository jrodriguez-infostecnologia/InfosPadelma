CREATE FUNCTION [dbo].[fRetornaDatosProduccionPeriodo]
	( @item		varchar(50),
	  @producto	varchar(10),
	  @movimiento		varchar(50),
	  @periodo	varchar(6),
	  @empresa	int,
	  @almacena bit )
RETURNS float
AS

BEGIN

	DECLARE @INI float,@FR	float,@VP float,@VLL float,@IF float,@HP float,@HPA float
	declare @dato float, @FP float 
	declare @PP FLOAT,@PTP float,@planta varchar(50)
	declare @mes varchar(2)=substring(@periodo,5,len(@periodo)),@año varchar(4)=substring(@periodo,1,4)
	declare @refProducto varchar(50) = (select referencia from iitems where codigo=@producto and empresa = @empresa AND tipo='P')

	
	
	set @dato = 0
	
	if( @item = 'M' )
	begin	
		 
		if	(@movimiento= 'INI' OR @movimiento='INII' OR @movimiento='INIP')
		BEGIN
			select @dato = valor from vTransaccionesProduccion	a
			where a.producto = @producto and a.anulado=0 and 
			a.refmovimiento = @movimiento and empresa=@empresa and
			convert(date,fecha)=convert(date,(select min( b.fecha )
				  from vTransaccionesProduccion b
				  where b.producto=@producto and b.refmovimiento=@movimiento and empresa=@empresa  
				  AND b.anulado=0 and MONTH(b.fecha) =  @mes and YEAR(b.fecha) = @año ) )
		END
		
	if( @movimiento in ('HCPO','HCPKO','ACPO','ACPKO') )
	begin	
	
	SET  @dato= ISNULL((select  AVG( valor ) from vTransaccionesProduccion a
		where producto =@producto AND a.refmovimiento=@movimiento and
		YEAR(fecha) =  @año and MONTH(fecha)=@mes and empresa=@empresa AND anulado=0),0)

	end	


							
	if( @movimiento in ('EXCPKO') )
	begin	
	
	select  @PP= SUM( valor )
		from vTransaccionesProduccion a
		where refproducto in ('ADPA') AND a.refmovimiento='AP' and
		YEAR(fecha) =  @año and MONTH(fecha)=@mes and empresa=@empresa 
		AND anulado=0

		select  @PTP= SUM( valor )
		from vTransaccionesProduccion a
		where A.refProducto='CPKO' and a.refMovimiento='PRO' and
		YEAR(fecha) =  @año and MONTH(fecha)=@mes and empresa=@empresa 
		AND anulado=0
		set @dato=isnull((@PTP/nullif(@PP,0)),0)*100
	end	

	if( @movimiento in ('EXTP') )
	begin	
	
	select  @PP= SUM( valor )
		from vTransaccionesProduccion a
		where refproducto in ('ADPA') AND a.refmovimiento='AP' and
		YEAR(fecha) =  @año and MONTH(fecha)=@mes and empresa=@empresa 
		AND anulado=0

		select  @PTP= SUM( valor )
		from vTransaccionesProduccion a
		where refProducto='TP' and a.refMovimiento='PRO' and
		YEAR(fecha) =  @año and MONTH(fecha)=@mes and empresa=@empresa 
		AND anulado=0
		set @dato=isnull((@PTP/nullif(@PP,0)),0)*100
	end	

					
	if( @movimiento in ('EX') )
	begin	
	
	if (@refproducto='CPO' OR @refproducto='ADPA')		
	begin
		select  @PP= SUM( valor )
		from vTransaccionesProduccion a
		where refproducto in ('FRU','FRUPAL') AND a.refmovimiento='FP' and
		YEAR(fecha) =  @año and MONTH(fecha)=@mes and empresa=@empresa 
		AND anulado=0
	end
	else
	begin
		select  @PP= SUM( valor )
		from vTransaccionesProduccion a
		where a.refMovimiento='AP' and a.refProducto='ADPA' AND
		YEAR(fecha) =  @año and MONTH(fecha)=@mes and empresa=@empresa 
	end

		select  @PTP= SUM( valor )
		from vTransaccionesProduccion a
		where A.producto=@producto and a.refMovimiento='PRO' and
		YEAR(fecha) =  @año and MONTH(fecha)=@mes and empresa=@empresa 
		AND anulado=0
		set @dato=isnull((@PTP/nullif(@PP,0)),0)*100
	end	
	
	if( @movimiento = 'PPV' )
	begin	
		set @FR=isnull((select   SUM( valor )
		from vTransaccionesProduccion a
		where producto=@producto AND a.refMovimiento='FP' and
		YEAR(fecha) =  @año and MONTH(fecha)=@mes and empresa=@empresa AND anulado=0 ),0)
		
		set @VP=isnull((select   SUM( valor )
		from vTransaccionesProduccion a
		where producto=@producto AND a.refMovimiento='VP' and
		YEAR(fecha) =  @año and MONTH(fecha)=@mes and empresa=@empresa AND anulado=0 ),0)
		
		set @dato=isnull(@FR/nullif(@VP,0),0)
	end	
	
	if( @movimiento = 'CPTHE' )
	begin
	
	if(@producto='FRU')
	begin			  
		SET @FR= ISNULL((select   SUM( valor )
		from vTransaccionesProduccion a
		where refProducto='FRU' AND a.refMovimiento='FP' and empresa=@empresa  and
		YEAR(fecha) =  @año and MONTH(fecha)=@mes),0)
			
		SET @HP=ISNULL((select   SUM( valor )
		from vTransaccionesProduccion a
		where refProducto='FRU' AND a.refMovimiento='HE'  and empresa=@empresa and
		YEAR(fecha) =  @año and MONTH(fecha)=@mes AND anulado=0),0)
	end
	
	if(@producto='CPKO')
	begin			  
		SET @FR= ISNULL((select   SUM( valor )
		from vTransaccionesProduccion a
		where refproducto='ADPA' AND a.refMovimiento='AP' and empresa=@empresa  and
		YEAR(fecha) =  @año and MONTH(fecha)=@mes AND anulado=0),0)
			
		SET @HP=ISNULL((select  SUM( valor )
		from vTransaccionesProduccion a
		where refProducto='CPKO' AND a.refMovimiento='HE' and empresa=@empresa  and
		YEAR(fecha) =  @año and MONTH(fecha)=@mes AND anulado=0),0)
	end
		
	IF @HP=0
	SET @dato=0
	ELSE
	set @dato=round(isnull((@FR/nullif(@HP,0)),0),0)
		
	end
	
	if( @movimiento = 'CPTHP' )
	begin
	if(@producto='FRU')
		begin	
		SET @FR= ISNULL((select   SUM( valor )
		from vTransaccionesProduccion a
		where refProducto='FRU' AND a.refMovimiento='FP'  and empresa=@empresa and
		YEAR(fecha) =  @año and MONTH(fecha)=@mes),0)
						
		SET @HP=ISNULL((select   SUM( valor )
		from vTransaccionesProduccion a
		where refProducto='FRU' AND a.refMovimiento='HP'  and empresa=@empresa and
		YEAR(fecha) =  @año and MONTH(fecha)=@mes),0)
		end
		if(@producto='CPKO')
	begin			  
		SET @FR= ISNULL((select   SUM( valor )
		from vTransaccionesProduccion a
		where refProducto='ADPA' AND a.refMovimiento='AP'  and empresa=@empresa and
		YEAR(fecha) =  @año and MONTH(fecha)=@mes),0)
			
		SET @HP=ISNULL((select  SUM( valor )
		from vTransaccionesProduccion a
		where refProducto='CPKO' AND a.refMovimiento='HP'  and empresa=@empresa and
		YEAR(fecha) =  @año and MONTH(fecha)=@mes),0)
	end
											  
	IF @HP=0
	SET @dato=0
	ELSE
	set @dato=round(isnull((@FR/nullif(@HP,0)),0),0)
	
	end
	
	IF (@movimiento='VLL' OR @movimiento='SEC')
	BEGIN
	select @dato = valor from vTransaccionesProduccion	a
		where a.refProducto = @producto and	a.refMovimiento = @movimiento  and empresa=@empresa and
		convert(date,fecha)=convert(date,(select MAX( b.fecha )
				  from vTransaccionesProduccion b
				  where b.refProducto=@producto  and empresa=@empresa and
					B.refMovimiento=@movimiento AND 
				MONTH(b.fecha) =  @mes and 
				  YEAR(b.fecha) = @año ) )
	END
	
						
	if	@almacena=1 and @dato=0
	BEGIN
		select @dato = valor
		from vTransaccionesProduccion a	where a.producto = @producto and
		a.refMovimiento = @movimiento  and empresa=@empresa and
		convert(date,fecha)=convert(date,(select MAX( b.fecha )
				  from vTransaccionesProduccion b		  where b.producto=@producto and
					B.refMovimiento=@movimiento and empresa=@empresa  AND MONTH(b.fecha) =  @mes and  YEAR(b.fecha) = @año ) )
	END
			
	if( @movimiento = 'NR' AND @producto='ADPA' )
	begin
	    SET @dato=ISNULL((SELECT SUM(VALOR) FROM vTransaccionesProduccion 
	    WHERE refProducto='NUEZFP' AND refMovimiento='FR' and empresa=@empresa  AND YEAR(fecha) =  @año and MONTH(fecha)=@mes),0)
	end
	    	
	IF(@movimiento='PN')
	BEGIN
	SET @FR= ISNULL((select   SUM( valor )
		from vTransaccionesProduccion a
		where refproducto='NUEZFP' AND a.refMovimiento='ANR' and empresa=@empresa  and
		YEAR(fecha) =  @año and MONTH(fecha)=@mes),0)
						
		SET @HP=ISNULL((select   SUM( valor )
		from vTransaccionesProduccion a
		where refProducto='NUEZFP' AND a.refMovimiento='FR' and empresa=@empresa  and
		YEAR(fecha) =  @año and MONTH(fecha)=@mes),0)
		
	IF @HP=0
	SET @dato=0
	ELSE
	set @dato=round(isnull((@FR/nullif(@HP,0)),0),0)
	
	END
	
	IF (@movimiento='IH')
	BEGIN
	SET @DATO=ISNULL((SELECT AVG(VALOR) from vTransaccionesProduccion
	where refProducto=@producto AND refMovimiento=@movimiento  and empresa=@empresa and
	YEAR(fecha) =  @año and MONTH(fecha)=@mes AND valor<>0),0)
	END	
	
	end
		
		if( @item = 'A' )
		begin	
		
		if	(@movimiento= 'INI' OR @movimiento='INII' OR @movimiento='INIP')
		BEGIN
		 select @dato = valor
		from vTransaccionesProduccion	
		where producto = @producto  and empresa=@empresa and
		refMovimiento = @movimiento and anulado=0 and 
		fecha=(	(select min( b.fecha ) from vTransaccionesProduccion b
				  where	producto =@producto and YEAR( b.fecha ) = @año and anulado=0
				  and refMovimiento=@movimiento  and empresa=@empresa and MONTH(fecha)<=@mes))
		END
		
		if( @movimiento = 'PPB' )
	begin	
		select  @FR= SUM( valor )
		from vTransaccionesProduccion a
		where refproducto=@producto AND a.refMovimiento='DESSLL' and empresa=@empresa  and
		YEAR(fecha) =  @año and MONTH(fecha)<=@mes
		
		select  @VP= SUM( valor )
		from vTransaccionesProduccion a
		where refProducto=@producto AND a.refMovimiento='DES' and empresa=@empresa  and
		YEAR(fecha) =  @año and MONTH(fecha)<=@mes
		
			set @dato=round(isnull(@VP/nullif(@FR,0),0),0)
	end	
	
		if( @movimiento in ('HCPO','HCPKO','ACPO','ACPKO') )
	begin	
	
	SET  @dato= ISNULL((select  AVG( valor ) from vTransaccionesProduccion a
		where producto =@producto AND a.refmovimiento=@movimiento and
		YEAR(fecha) =  @año and MONTH(fecha)<=@mes and empresa=@empresa AND anulado=0),0)

	end	

	IF (@movimiento='IH')
	BEGIN
	SET @DATO=ISNULL((SELECT AVG(VALOR) from vTransaccionesProduccion
	where refProducto=@producto AND refMovimiento=@movimiento  and empresa=@empresa and
	YEAR(fecha) =  @año and MONTH(fecha)<=@mes AND valor<>0),0)
	END	
	
		if( @movimiento = 'NR' AND @producto='ADPA' )
	    begin
	    SET @dato=ISNULL((SELECT SUM(VALOR) FROM vTransaccionesProduccion 
	    WHERE refProducto='NUEZFP' AND refMovimiento='FR'  and empresa=@empresa AND YEAR(fecha) =  @año and MONTH(fecha)<=@mes),0)
	    end
	    
		if( @movimiento = 'PPV' )
	    begin
		
		SET @FR= ISNULL((select   SUM( valor )
		from vTransaccionesProduccion a
		where refProducto='FRU' AND a.refMovimiento='FP'  and empresa=@empresa and
		YEAR(fecha) =  @año and MONTH(fecha)<=@mes),0)
		
		SET @VP=ISNULL((select SUM( valor )
		from vTransaccionesProduccion a
		where refProducto='FRU' AND a.refMovimiento='VP'  and empresa=@empresa and
		YEAR(fecha) =  @año and MONTH(fecha)<=@mes),0)
		
		IF @VP=0
		SET @dato=0
		ELSE
		set @dato=ROUND(isnull((@FR/nullif(@VP,0)),0),0)
	end	
	
	if( @movimiento = 'CPTHE' )
	begin
		if(@refProducto='FRU')
		begin	
		SET @FR= ISNULL((select   SUM( valor )
		from vTransaccionesProduccion a
		where refProducto='FRU' AND a.refMovimiento='FP' and empresa=@empresa  and
		YEAR(fecha) =  @año and MONTH(fecha)<=@mes),0)
						
		SET @HP=ISNULL((select   SUM( valor )
		from vTransaccionesProduccion a
		where refProducto='FRU' AND a.refMovimiento='HE' and empresa=@empresa  and
		YEAR(fecha) =  @año and MONTH(fecha)<=@mes),0)
		end
		if(@producto='CPKO')
	begin			  
		SET @FR= ISNULL((select   SUM( valor )
		from vTransaccionesProduccion a
		where refProducto='ADPA' AND a.refMovimiento='AP' and empresa=@empresa  and
		YEAR(fecha) =  @año and MONTH(fecha)<=@mes),0)
			
		SET @HP=ISNULL((select  SUM( valor )
		from vTransaccionesProduccion a
		where refProducto='CPKO' AND a.refMovimiento='HE' and empresa=@empresa  and
		YEAR(fecha) =  @año and MONTH(fecha)<=@mes),0)
	end
	
		
	IF @HP=0
	SET @dato=0
	ELSE
	set @dato=round(isnull((@FR/nullif(@HP,0)),0),0)
		
	end
	
	IF(@movimiento='PN')
	BEGIN
	SET @FR= ISNULL((select   SUM( valor )
		from vTransaccionesProduccion a
		where refProducto=@producto AND a.refMovimiento='ANR' and empresa=@empresa  and
		YEAR(fecha) =  @año and MONTH(fecha)<=@mes),0)
						
		SET @HP=ISNULL((select   SUM( valor )
		from vTransaccionesProduccion a
		where refProducto=@producto AND a.refMovimiento='FR' and empresa=@empresa  and
		YEAR(fecha) =  @año and MONTH(fecha)<=@mes),0)
		
	IF @HP=0
	SET @dato=0
	ELSE
	set @dato=round((@FR/@HP)*100,0)
	
	END
	
	
	
	if( @movimiento = 'CPTHP')
	begin
		if(@producto='FRU')
		begin	
		SET @FR= ISNULL((select   SUM( valor )
		from vTransaccionesProduccion a
		where refProducto='FRU' AND a.refMovimiento='FP' and empresa=@empresa  and
		YEAR(fecha) =  @año and MONTH(fecha)<=@mes),0)
						
		SET @HP=ISNULL((select   SUM( valor )
		from vTransaccionesProduccion a
		where refProducto='FRU' AND a.refMovimiento='HP' and empresa=@empresa  and
		YEAR(fecha) =  @año and MONTH(fecha)<=@mes),0)
		end
		if(@producto='CPKO')
	begin			  
		SET @FR= ISNULL((select   SUM( valor )
		from vTransaccionesProduccion a
		where refProducto='ADPA' AND a.refMovimiento='AP' and empresa=@empresa  and
		YEAR(fecha) =  @año and MONTH(fecha)<=@mes),0)
			
		SET @HP=ISNULL((select  SUM( valor )
		from vTransaccionesProduccion a
		where refProducto='CPKO' AND a.refMovimiento='HP' and empresa=@empresa  and
		YEAR(fecha) =  @año and MONTH(fecha)<=@mes),0)
	end
	
											  
	IF @HP=0
	SET @dato=0
	ELSE
	set @dato=round(isnull((@FR/nullif(@HP,0)),0),0)
	
	end
		
		
	if( @movimiento = 'EX' )
	begin		
	if (@refProducto IN ('CPO','ADPA'))		
	begin
		select  @PP= SUM( valor )
		from vTransaccionesProduccion a
		where refProducto LIKE 'FRU%' AND a.refMovimiento='FP' and empresa=@empresa  and
			YEAR(fecha) =  @año	and MONTH(fecha)<=@mes AND anulado=0 and anulado=0
	end
	else
	begin
		select  @PP= SUM( valor )
		from vTransaccionesProduccion a
		where a.movimiento='AP' and a.producto='ADPA' and empresa=@empresa  AND
		YEAR(fecha) =  @año	   and MONTH(fecha)<=@mes AND anulado=0 and anulado=0
	end
		
		select  @PTP= SUM( valor )
		from vTransaccionesProduccion a
		where A.refProducto=@producto and a.refMovimiento='PRO' and empresa=@empresa  and
		YEAR(fecha) =  @año	   and MONTH(fecha)<=@mes AND anulado=0
		
		set @dato=isnull((@PTP/nullif(@PP,0)),0)*100
		
	end	
	
	if	@almacena=1 and @dato=0
	BEGIN
		select @dato= isnull(valor,0)
		from vTransaccionesProduccion	
		where producto = @producto and
		refMovimiento = @movimiento and empresa=@empresa  and anulado=0 and 
		fecha=(select max( b.fecha )	  from vTransaccionesProduccion b
				  where producto = b.producto and b.anulado=0 and 
					refmovimiento=@movimiento and YEAR(b.fecha) = @año and empresa=@empresa  and MONTH(fecha)<=@mes )
	END
		
	end
	
	return @dato

	
end