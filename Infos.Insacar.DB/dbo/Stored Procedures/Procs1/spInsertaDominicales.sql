create procedure [dbo].[spInsertaDominicales]
	@ano	varchar(10),
	@empresa int
AS
/***************************************************************************
Nombre: spInsertaDominicales
Descripción: Inserta los dominicales en la tabla nFestivo 
*****************************************************************************/

	declare @contador	int,
			@fecha		date,
			@epifania	date,
			@sanJose	date,
			@sanPedro	date,
			@asuncion	date,
			@santos		date,
			@raza		date,
			@cartagena	date
	
	delete nFestivo
	where
	DATEPART(year,fecha) = @ano
	and empresa=@empresa
	
	set @contador = DATENAME( DAYOFYEAR,'31/12/' + LTRIM( rtrim( @ano ) ) ) - 1
	set @fecha = '01/01/' + LTRIM( rtrim( @ano ) )	

		
	while( @contador > 0 )
	begin	
		set @fecha = DATEADD( day,1,@fecha )
		
		if( DATENAME( WEEKDAY,@fecha ) = 'Domingo' )
		begin
			begin tran Inserta
				insert nFestivo(
					fecha,
					empresa
					)
				select
					@fecha,
					@empresa
					
			if( @@ERROR = 0 )
				commit tran Inserta
			else
				rollback tran Inserta														
		end		
		
		set @contador = @contador - 1
	end
	
	begin tran InsertaFijos	
	
		if( not exists( select fecha from nFestivo
						where
						fecha = '01/01/' + ltrim( rtrim( @ano ) )
						and empresa=@empresa ) )
		begin					
			insert nFestivo(
				fecha,
				empresa
				)
			select
				'01/01/' + ltrim( rtrim( @ano ) ),
				@empresa
		end				
			
		if( not exists( select fecha from nFestivo
						where
						fecha = '08/12/' + ltrim( rtrim( @ano ) ) 
						and 
						empresa=@empresa) )
		begin			
			insert nFestivo(
				fecha,
				empresa
				)
			select
				'08/12/' + ltrim( rtrim( @ano ) ),
				@empresa
		end
						
		if( not exists( select fecha from nFestivo
						where
						fecha = '25/12/' + ltrim( rtrim( @ano ) ) 
						and empresa=@empresa) )
		begin						
			insert nFestivo(
				fecha,
				empresa
				)
			select
				'25/12/' + ltrim( rtrim( @ano ) ),
				@empresa					
		end		
						
		if( not exists( select fecha from nFestivo
						where
						fecha = '01/05/' + ltrim( rtrim( @ano ) )
						and empresa=@empresa ) )
		begin				
			insert nFestivo(
				fecha,
				empresa
				)
			select
				'01/05/' + ltrim( rtrim( @ano ) ),
				@empresa			
		end				
				
		if( not exists( select fecha from nFestivo
						where
						fecha = '20/07/' + ltrim( rtrim( @ano ) )and
						empresa=@empresa ) )
		begin				
			insert nFestivo(
				fecha,
				empresa
				)
			select
				'20/07/' + ltrim( rtrim( @ano ) ),
				@empresa			
		end				
		
		if( not exists( select fecha from nFestivo
						where
						fecha = '07/08/' + ltrim( rtrim( @ano ) ) 
						and
						empresa=@empresa) )
		begin				
			insert nFestivo(
				fecha,
				empresa
				)
			select
				'07/08/' + ltrim( rtrim( @ano ) ),
				@empresa			
				
		end				
	
	if( @@ERROR = 0 )
		commit tran InsertaFijos
	else
		rollback tran InsertaFijos			
		
	select @epifania = '06/01/' + LTRIM( rtrim( @ano ) )
	select @sanJose = '19/03/' + LTRIM( rtrim( @ano ) )
	select @sanPedro = '29/06/' + LTRIM( rtrim( @ano ) )
	select @asuncion = '15/08/' + LTRIM( rtrim( @ano ) )
	select @santos = '01/11/' + LTRIM( rtrim( @ano ) )
	select @raza = '12/10/' + LTRIM( rtrim( @ano ) )
	select @cartagena = '11/11/' + LTRIM( rtrim( @ano ) )
	
	execute spRetornaPrimerLunes @epifania,@epifania output
	
	begin tran Inserta
		insert nFestivo(
			fecha,
			empresa )
		select 
		@epifania,
		@empresa
		
	if( @@ERROR = 0 )
		commit tran Inserta					
			
	execute spRetornaPrimerLunes @sanJose,@sanJose output
	
	begin tran Inserta
		insert nFestivo(
			fecha,
			empresa )
		select 
		@sanJose,
		@empresa
		
	if( @@ERROR = 0 )
		commit tran Inserta
		
	execute spRetornaPrimerLunes @sanPedro,@sanPedro output
	
	begin tran Inserta
		insert nFestivo(
			fecha,
			empresa )
		select 
		@sanPedro,
		 @empresa
		
	if( @@ERROR = 0 )
		commit tran Inserta					
		
	execute spRetornaPrimerLunes @asuncion,@asuncion output
	
	begin tran Inserta
		insert nFestivo(
			fecha ,
			empresa)
		select 
		@asuncion,
		@empresa
		
	if( @@ERROR = 0 )
		commit tran Inserta		
		
	execute spRetornaPrimerLunes @santos,@santos output
	
	begin tran Inserta
		insert nFestivo(
			fecha,
			empresa )
		select 
		@santos,
		@empresa
		
	if( @@ERROR = 0 )
		commit tran Inserta		
		
	execute spRetornaPrimerLunes @raza,@raza output
	
	begin tran Inserta
		insert nFestivo(
			fecha,
			empresa )
		select 
		@raza,
		@empresa
		
	if( @@ERROR = 0 )
		commit tran Inserta		
	
	execute spRetornaPrimerLunes @cartagena,@cartagena output
	
	begin tran Inserta
		insert nFestivo(
			fecha,
			empresa)
		select 
		@cartagena,
		@empresa
		
	if( @@ERROR = 0 )
		commit tran Inserta