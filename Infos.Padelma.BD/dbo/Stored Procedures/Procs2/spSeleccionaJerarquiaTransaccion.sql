
CREATE PROCEDURE [dbo].[spSeleccionaJerarquiaTransaccion]
	@transaccion	varchar(50),
	@jerarquia		varchar(50),
	@empresa		int
AS
/***************************************************************************
Nombre: spSeleccionaJerarquiaTransaccion
INFOS TECNOLOGIA S.A.S
*****************************/

	declare @analisis	varchar(MAX),			
			@formula	varchar(MAX),
			@cadena		varchar(MAX),			
			@var		varchar(MAX),	
			@char		char(1),									
			@lenV		int,
			@pos1		int,
			@pos2		int,
			@len		int,
			@i			int
			
	set @analisis = ''		
	set @char = CHAR(39)
	
		
											  
	

	declare @control bit,@campoResul bit , @resultado bit , @ana varchar(50)	
	
	declare curAnalisis insensitive cursor for
	select distinct	a.analisis,a.formula,a.resultado,a.campoResul, f.control from 
	lAnalisis f join pJerarquiaAnalisis a on f.codigo=a.analisis and a.empresa=f.empresa
	join lanalisisItem b on a.analisis = b.analisis and b.empresa=a.empresa
	join pJerarquia c on a.jerarquia = c.codigo  and c.empresa=a.empresa
	join gTipoTransaccionProducto d on b.item= d.producto and b.empresa=d.empresa
	where a.empresa=@empresa
	

	open curAnalisis
	fetch curAnalisis into @ana, @formula,@resultado,@campoResul,@control
	
	while( @@FETCH_STATUS = 0 )
	begin
	
	
	if (@campoResul=1 and @resultado=0) 
	begin	
		set	@formula= '|V('+@ana+')|' 
		set	@len = LEN(	@formula )
		set	@pos1 =	0
		set	@pos2 =	0
		set	@i = 0

		while( @i <= @len )
		begin	
	
			select @pos1 = CHARINDEX( CHAR(124),@formula,@pos2 + 1 )				
			select @pos2 = CHARINDEX( CHAR(124),@formula,@pos1 + 1 )						
		
			if(	@pos1 <> 0 )
			begin
			
				set	@var = SUBSTRING( @formula,@pos1 + 1,@pos2 - @pos1 - 1 )
				set	@lenV =	LEN( @var )
				
				if(	SUBSTRING( @var,1,1	) =	'V'	)
				begin
				
					set	@var = SUBSTRING( @var,CHARINDEX( CHAR(40),@var,0 )	+ 1,@lenV -	CHARINDEX( CHAR(40),@var,0 ) - 1 )								
					set	@var = RTRIM( LTRIM( @var )	)
					
					if(	( select resultado
						  from pJerarquiaAnalisis
						  where
						  jerarquia	= @jerarquia and
						  analisis = @var )	= 0	)
					begin
											  
						set	@analisis =	@analisis +	@char +	@var + @char + ','
						
					end						
				
				end				
				
			end
			else
			begin
				set	@i = @len +	1		
			end
					
			set	@i = @i	+ 1
		end	
		
		end	
	else 
	begin
	
	if (@resultado=1) 
	begin	
		set @len = LEN( @formula )
		set @pos1 = 0
		set @pos2 = 0
		set @i = 0

		while( @i <= @len )
		begin	
	
			select @pos1 = CHARINDEX( CHAR(124),@formula,@pos2 + 1 )				
			select @pos2 = CHARINDEX( CHAR(124),@formula,@pos1 + 1 )						
		
			if( @pos1 <> 0 )
			begin
			
				set @var = SUBSTRING( @formula,@pos1 + 1,@pos2 - @pos1 - 1 )
				set @lenV = LEN( @var )
				
				if( SUBSTRING( @var,1,1 ) = 'V' )
				begin
				
					set @var = SUBSTRING( @var,CHARINDEX( CHAR(40),@var,0 ) + 1,@lenV - CHARINDEX( CHAR(40),@var,0 ) - 1 )								
					set @var = RTRIM( LTRIM( @var ) )
					
					if( ( select resultado
						  from pJerarquiaAnalisis
						  where
						  jerarquia = @jerarquia and
						  analisis = @var ) = 0 )
					begin
											  
						set @analisis = @analisis + @char + @var + @char + ','
						
					end						
				
				end				
				
			end
			else
			begin
				set @i = @len + 1		
			end
					
			set @i = @i + 1
		end	
		
		end	
	
		

	
		
	
	end
	
	fetch curAnalisis into @ana, @formula,@resultado,@campoResul,@control
	
	end
	
	close curAnalisis
	deallocate curAnalisis

	set @lenV = LEN( @analisis )
	
	if( @lenV <> 0 )
	begin
	
		set @analisis = SUBSTRING( @analisis,1,@lenV - 1 )
		
	end
	else
	begin
	
		set @analisis = @char + @char
	
	end
			
	set @cadena =  
	'select distinct b.codigo as analisis,b.descripcion as nombre,c.descripcion uMedida,b.orden
	 from lAnalisis b   join gUnidadMedida c on b.uMedida=c.codigo
	 where
	 b.codigo in ( ' + @analisis + ' )
	 and b.empresa= '+convert(varchar(2), @empresa)+'order by b.orden'
	 
	execute( @cadena )