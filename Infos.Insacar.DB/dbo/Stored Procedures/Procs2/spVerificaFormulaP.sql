-- Batch submitted through debugger: SQLQuery7.sql|0|0|C:\Users\ADMINI~1.CIA\AppData\Local\Temp\3\~vs7F52.sql
CREATE PROCEDURE [dbo].[spVerificaFormulaP]	
	@jerarquia	varchar(50),
	@formula	varchar(8000),
	@modo		char(1),
	@empresa	int,
	@expresion	varchar(1000) output	
AS
/***************************************************************************
Nombre: spVerificaFormulaP
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tacnologia SAS
Fecha: 06/02/2015


Argumentos de entrada: Jerarquía, variable, modo
Argumentos de salida: Expresión, resultado
Descripción: Verifica la fórmula registrada para la variable y jerarquía de
			 producción seleccionadas.
*****************************************************************************/

	declare @len	int,
			@i		int,
			@pos1	int,
			@pos2	int,
			@var	varchar(2500),
			@cadena	varchar(5000)			
			
	set @i = 1		
	set @pos1 = 0
	set @pos2 = 0		
	set @cadena = ''
		
	select @len = LEN( @formula )			
	
	while( @i <= @len )
	begin	
	
		select @pos1 = CHARINDEX( CHAR(124),@formula,@pos2 + 1 )				
		select @pos2 = CHARINDEX( CHAR(124),@formula,@pos1 + 1 )						
	
		if( @pos1 <> 0 )
		begin
			select @var = SUBSTRING( @formula,@pos1 + 1,@pos2 - @pos1 - 1 )					
			set @cadena = @cadena + CONVERT( varchar(5000),dbo.fValorFormulaP(@var,'',@modo,GETDATE(),@empresa ) )						
		end
		else
		begin
			set @i = @len + 1		
		end
				
		set @i = @i + 1
	end		
	
	select @expresion = @cadena
	
	set @cadena = 'select ' + @cadena
		
	begin try		
		execute( @cadena )
	end try		
	begin catch
		if( @@ERROR <> 8134 )
		begin
			execute( @cadena )
		end
	end catch