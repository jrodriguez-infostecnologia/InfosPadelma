
						
create PROCEDURE [dbo].[spEjecutaFormulaA]
	@jerarquia	varchar(50),	
	@variableP	varchar(50),	
	@objVar		varchar(500),
	@modo		char(1),
	@fecha		date,
	@empresa int
AS
/***************************************************************************
Nombre: spEjecutaFormulaA
Tipo: Procedimiento Almacenado
Desarrollado: Ricardo A. Matíz Gómez
Fecha: 02/05/2013

Argumentos de entrada: Jerarquía, variable, objeto variable, modo, fecha
Argumentos de salida: Expresión, resultado
Descripción: Ejecuta la fórmula registrada para el análisis y jerarquía de
			 producción seleccionadas.
*****************************************************************************/

	declare @len		int,
			@i			int,
			@pos1		int,
			@pos2		int,			
			@var		varchar(max),
			@resultado	varchar(max),
			@variable	varchar(max),
			@cadena		varchar(max),
			@formula	varchar(max),
			@uMedida	varchar(50)
		
	declare curResultado insensitive cursor for	
	select formula,descripcion as nombre,analisis,uMedida
	from pJerarquiaAnalisis,lAnalisis
	where
	analisis = codigo and	
	jerarquia = @jerarquia and
	analisis = @variableP and
	resultado = 1	
	and pJerarquiaAnalisis.empresa=@empresa 
	and lAnalisis.empresa=@empresa
	and pJerarquiaAnalisis.empresa=lAnalisis.empresa
	order by prioridad
	
	open curResultado
	fetch curResultado into @formula,@resultado,@variable,@uMedida
	
	while( @@FETCH_STATUS = 0 )
	begin		
		set @len = LEN( @formula )	
		set @i = 1		
		set @pos1 = 0
		set @pos2 = 0		
		set @cadena = ''
		
		while( @i <= @len )
		begin			
			set @pos1 = CHARINDEX( CHAR(124),@formula,@pos2 + 1 )					
			set @pos2 = CHARINDEX( CHAR(124),@formula,@pos1 + 1 )						
		
			if( @pos1 <> 0 )
			begin
				set @var = SUBSTRING( @formula,@pos1 + 1,@pos2 - @pos1 - 1 )														

				set @cadena = @cadena + CONVERT( varchar(MAX),dbo.[fValorFormulaLab](@jerarquia,@var,@objVar,@modo,@fecha,@empresa) )								
			end
			else
			begin
				set @i = @len + 1	
			end			
					
			set @i = @i + 1
		end	
							
		set @cadena = 'select  convert(decimal(18,3) ,' + @cadena + ') as resultado,' + CHAR( 39 ) + @resultado + CHAR( 39 ) + ' as variable,' + + CHAR( 39 ) + @variable + CHAR( 39 ) + ' as codigo,' + CHAR(39) + @uMedida + CHAR(39) + ' as uMedida'
	
		EXECUTE( @cadena )
											
		fetch curResultado into @formula,@resultado,@variable,@uMedida	
	end					
	
	close curResultado
	deallocate curResultado