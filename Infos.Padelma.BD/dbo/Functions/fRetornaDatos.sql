
CREATE FUNCTION [dbo].[fRetornaDatos]
	( @item		varchar(50),
	  @producto	varchar(50),
	  @tipo		varchar(50),
	  @fecha	varchar(50),
	  @empresa  varchar(50) )
RETURNS float
AS
/***************************************************************************
Nombre: fRetornaDatos
Tipo: Función
Desarrollado: Infos Tacnologia SAS
Fecha: 06/02/2015

Argumentos de entrada: Producto, periodo
Argumentos de salida: Saldo Final
Descripción: 
***************************************************************************/
BEGIN

	

declare  @vehiculo varchar(50),
@remolque varchar(50), @pesoBruto int

declare @tabla2 table(
		vehiculo varchar(50),
		remolque varchar(50),
		pesoNeto int)
		
		declare @tabla1 table(
		vehiculo varchar(50),
		remolque varchar(50),
		pesoTara int)
		
		

if (@fecha in ('FAC','FAN'))
	set @fecha = convert(varchar(50),GETDATE())
	
	declare @dato float, @fechaN date = convert(date,@fecha)
	
	set @dato = 0

	if( @item = 'PND' )
	begin
	
	if (@tipo='DESSLL')
	begin
		set @dato = isnull((select  SUM( sacos )
		from bRegistroBascula
		where
		item = @producto and
		tipo = 'DPT' and
		CONVERT( date,fechaProceso ) = @fechaN
		and empresa=@empresa),0)
	end
	else
	begin
		set @dato = isnull((select  SUM( PesoNeto)
		from bRegistroBascula
		where
		item = @producto and
		tipo = @tipo and
		CONVERT( date,fechaProceso ) = @fechaN
		and empresa=@empresa),0)
	end	
	end

	if( @item = 'PDD' )
	begin
	
		set @dato = isnull((select  SUM( pesoDescuento )
		from bRegistroBascula
		where
		item = @producto and
		tipo = @tipo and
		CONVERT( date,fechaProceso ) = @fechaN
		and empresa=@empresa),0)
	
	end
	
	if( @item = 'VIN' )
	begin
		set @dato = isnull((select  SUM( valor )
		from vTransaccionProduccion
		where
		producto = @producto and
		movimiento = @tipo and
		CONVERT( date,fecha ) = @fechaN
		and empresa=@empresa),0)
	end	
	
	if( @item = 'PVA' )
	begin
		set @dato = isnull((select  valor
		from vTransaccionProduccion
		where
		producto = @producto and
		movimiento = @tipo and
		CONVERT( date,fecha ) = @fechaN
		and empresa=@empresa),0)
		
		if @dato=0
		begin
		set @dato = isnull((select  SUM( valor )
		from vTransaccionProduccion
		where
		producto = @producto and
		movimiento = 27 and
		CONVERT( date,fecha ) = @fechaN),0)
		end
		
	end	
	
		if( @item = 'FPD' )
	begin
	
	
	 
	 set @dato= ISNULL((select pesoneto from pFrutaEstimadaTmp
	 where fecha=@fechaN),0)
	 
	end	
	
	
		if( @item = 'NVP' )
	begin
		set @dato = isnull((select count(*) from  bRegistroBascula b where
		b.item = @producto and
		b.tipo = @tipo and
		CONVERT( date,b.fechaProceso ) = @fechaN
		and pesoNeto=0),0)
	end	
	
	if( @item = 'FDC' )
	begin
		set @dato = isnull((select sum(a.pesoNeto) from bRegistroBascula a
		where a.item = @producto and a.tipo = @tipo and
		CONVERT( date,a.fechaProceso) = @fechaN
		and a.fechaNeto < dateadd(HOUR,14,convert(datetime,dateadd(day,1,CONVERT(date, a.fechaProceso))))),0)
	end	
	
	if( @item = 'SED' )
	begin
		set @dato = isnull((select  SUM( PesoNeto )
		from bRegistroBascula
		where
		item = @producto and
		tipo = @tipo and
		CONVERT( date,fechaProceso ) = @fechaN),0)
	end	
	
		if( @item = 'FPF' )
	begin
		set @dato = isnull((select  SUM( valor )
		from vTransaccionProduccion
		where
		producto = @producto and
		movimiento = @tipo and
		CONVERT( date,fecha ) = @fechaN),0)
	end		
	
	if( @item = 'PNS' )
	begin	
		set @dato = isnull((select  SUM( pesoNeto )
		from bRegistroBascula
		where
		item = @producto and
		tipo = @tipo and
		DATEPART( WEEK,CONVERT( date,fechaProceso ) ) = DATEPART( WEEK,@fechaN ) and
		YEAR( fechaProceso ) = YEAR( @fechaN )),0)
	end		
	
	if( @item = 'PNM' )
		begin	
		set @dato = isnull((select  SUM( pesoNeto )
		from bRegistroBascula
		where
		item = @producto and
		tipo = @tipo and
		MONTH( CONVERT( date,fechaProceso ) ) = MONTH( @fechaN ) and
		YEAR( fechaProceso ) = YEAR( @fechaN )	),0)
	end		
	
	if( @item = 'PNA' )
	begin		
		set @dato = isnull((select  SUM( pesoNeto )
		from bRegistroBascula
		where
		item = @producto and
		tipo = @tipo and
		YEAR( CONVERT( date,fechaProceso ) ) = YEAR( @fechaN )),0)
	end		
	
	if( @item = 'SID' )
	begin	
		set @dato = isnull((select  sum( valor )
		from vTransaccionProduccion
		where
		producto = @producto and
		movimiento=@tipo and
		fecha =  @fechaN and empresa=@empresa),0)
	end		
	
	--if( @item = 'SOD' )
	--begin	
	--	set @dato = isnull((select  sum( saldoNuevo )
	--	from pSaldo
	--	where
	--	producto = @producto and
	--	fecha =  @fechaN),0)
	--end		
	
	--if( @item = 'SIS' )
	--begin	
	--	select @dato = sum( saldoAnterior )
	--	from pSaldo a
	--	where
	--	producto = @producto and
	--	fecha = ( select MIN( b.fecha )
	--			  from pSaldo b
	--			  where
	--			  a.producto = b.producto and
	--			  DATEPART( WEEK,b.fecha ) =  DATEPART( WEEK,@fechaN ) and
	--			  YEAR( b.fecha ) = YEAR( @fechaN ) )
	--end		
	
	--if( @item = 'SOS' )
	--begin	
	--	set @dato = isnull((select  sum( saldoNuevo )
	--	from pSaldo a
	--	where
	--	producto = @producto and
	--	fecha = ( select MAX( b.fecha )
	--			  from pSaldo b
	--			  where
	--			  a.producto = b.producto and
	--			  DATEPART( WEEK,b.fecha ) =  DATEPART( WEEK,@fechaN ) and
	--			  YEAR( b.fecha ) = YEAR( @fechaN ) )),0)
	--end		
	
	--if( @item = 'SIM' )
	--begin		
	--	set @dato = isnull((select  sum( saldoAnterior )
	--	from pSaldo a
	--	where
	--	producto = @producto and
	--	fecha = ( select MIN( b.fecha )
	--			  from pSaldo b
	--			  where
	--			  a.producto = b.producto and
	--			  MONTH( b.fecha ) =  MONTH( @fechaN ) and
	--			  YEAR( b.fecha ) = YEAR( @fechaN ) )),0)
	--end		
	
	--if( @item = 'SOM' )
	--begin		
	--	set @dato = isnull((select  sum( valor )
	--	from vTransaccionProduccion a
	--	where
	--	producto = @producto and
	--	fecha = ( select MAX( b.fecha )
	--			  from pSaldo b
	--			  where
	--			  a.producto = b.producto and
	--			  MONTH( b.fecha ) =  MONTH( @fechaN ) and
	--			  YEAR( b.fecha ) = YEAR( @fechaN ) )),0)
	--end
	
	--if( @item = 'SIA' )
	--begin			
	--	set @dato = isnull((select sum( saldoAnterior )
	--	from pSaldo a
	--	where
	--	producto = @producto and
	--	fecha = ( select MIN( b.fecha )
	--			  from pSaldo b
	--			  where
	--			  a.producto = b.producto and
	--			  YEAR( b.fecha ) = YEAR( @fechaN ) )),0)
	--end		
		
	--if( @item = 'SOA' )
	--begin		
	--	set @dato = isnull((select  sum( saldoNuevo )
	--	from pSaldo a
	--	where
	--	producto = @producto and
	--	fecha = ( select MAX( b.fecha )
	--			  from pSaldo b
	--			  where
	--			  a.producto = b.producto and
	--			  YEAR( b.fecha ) = YEAR( @fechaN ) )),0)
	-- end
	
	--if( @item = 'TND' )
	--begin
	--	select @dato = SUM( valor )
	--	from pTransaccion
	--	where
	--	producto = @producto and
	--	tipo = @tipo and
	--	CONVERT( date,fecha ) = @fechaN
	--end		
	
	--if( @item = 'TNS' )
	--begin	
	--	select @dato = SUM( valor )
	--	from pTransaccion
	--	where
	--	producto = @producto and
	--	tipo = @tipo and
	--	DATEPART( WEEK,CONVERT( date,fecha ) ) = DATEPART( WEEK,@fechaN ) and
	--	YEAR( fecha ) = YEAR( @fechaN )
	--end		
	
	--if( @item = 'TNM' )
	--	begin	
	--	select @dato = SUM( valor )
	--	from pTransaccion
	--	where
	--	producto = @producto and
	--	tipo = @tipo and
	--	MONTH( CONVERT( date,fecha ) ) = MONTH( @fechaN ) and
	--	YEAR( fecha ) = YEAR( @fechaN )	
	--end		
	
	--if( @item = 'TNA' )
	--begin		
	--	select @dato = SUM( valor )
	--	from pTransaccion
	--	where
	--	producto = @producto and
	--	tipo = @tipo and
	--	YEAR( CONVERT( date,fecha ) ) = YEAR( @fechaN )
	--end	
	
	return @dato

END