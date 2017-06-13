CREATE PROCEDURE [dbo].[spEjecutaFormulaProduccion]
	@producto	varchar(50),	
	@movimiento	varchar(50),	
	@objVar		varchar(8000),
	@modo		char(1),
	@fecha		date,
	@empresa	int
AS
/***************************************************************************
Nombre: spEjecutaFormulaProduccion
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tegnologia SAS

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
			@uMedida	varchar(50),
			@decimal		bit
	
	exec spRetornaFrutaPromedio @fecha, @empresa	
		
	declare curResultado insensitive cursor for	
	select  a.formula,b.descripcion nombre, a.movimiento,a.mDecimal  from
 	pProductoMovimiento a join iitems b on b.codigo=a.movimiento and b.empresa=a.empresa and b.tipo='M' and b.activo=1
 	where producto=@producto and movimiento=@movimiento	and resultado=1	and a.empresa=@empresa
 	order by a.prioridad
 	 
 	
	open curResultado
	fetch curResultado into @formula,@resultado,@variable,@decimal
	
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

				set @cadena = @cadena + CONVERT( varchar(MAX),dbo.fValorFormulaP(@var,@objVar,@modo,@fecha,@empresa ) )								
			end
			else
			begin
				set @i = @len + 1	
			end			
					
			set @i = @i + 1
		end	
							
		set @cadena = 'select  convert(decimal(18,6) ,' + 
		case when @decimal = 0 then 'round(' + @cadena +',0)'
		else  @cadena  end   + ') as resultado,' + CHAR( 39 ) + @resultado + CHAR( 39 ) + ' as variable,' + + CHAR( 39 ) + @variable + CHAR( 39 ) + ' as codigo'
	
		EXECUTE( @cadena )
											
		fetch curResultado into @formula,@resultado,@variable,@decimal	
	end					
	
	close curResultado
	deallocate curResultado