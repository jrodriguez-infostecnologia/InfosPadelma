
CREATE FUNCTION [dbo].[fValorFormulaLab]
	( @jerarquia	varchar(50),
	  @sentencia	varchar(250),
	  @objVar		varchar(500),
	  @modo			char(1),
	  @fecha		date,
	  @empresa int )
RETURNS varchar(250)
AS
/***************************************************************************
Nombre: fValorFormulaP
Tipo: Función
Desarrollado: Alirio Noche Arzuza
Fecha: 03/04/2013

Argumentos de entrada: Jerarquia, sentencia, objeto variable, modo de operación,
					   fecha
Argumentos de salida: Valor sentencia
Descripción: Retorna el valor de la sentencia indicada.
***************************************************************************/
BEGIN

	declare @valor	varchar(max),
			@var	varchar(max),
			@tipoFecha varchar(50),
			@char	char(1),					
			@len	int,
			@lenV	int,
			@lenV1	int,
			@i		int,
			@pos1	int,
			@pos2	int
	
	set @valor = ''	
	set @len = LEN( @sentencia )
	set @lenV = LEN( @objVar )
	set @i = 0
	set @pos1 = 0
	set @pos2 = 0	
	set @char = CHAR(39)

	if( SUBSTRING( @sentencia,1,1 ) = 'C' )
	begin
		select @valor = CONVERT( varchar(max),valor )	
		from pJerarquiaCaracteristica
		where
		jerarquia = @jerarquia and
		caracteristica = REPlACE( REPLACE( SUBSTRING( @sentencia,2,LEN( @sentencia ) ),'(','' ),')','' )
		
		set @valor = CONVERT( varchar(max),CONVERT( numeric(28,13),@valor ) )
	end
	else
	begin
		if( SUBSTRING( @sentencia,1,1 ) = 'V' )
		begin
			if( @modo = 'V' )
			begin
				set @valor = 1
			end				
			else
			begin
				while( @i <= @lenV )
				begin							
					select @pos1 = CHARINDEX( CHAR(124),@objVar,@pos2 + 1 )				
					select @pos2 = CHARINDEX( CHAR(124),@objVar,@pos1 + 1 )						
	
					if( @pos1 <> 0 )
					begin
						set @var = SUBSTRING( @objVar,@pos1 + 1,@pos2 - @pos1 - 1 )							
						set @lenV1 = LEN( @var )
						
						if( SUBSTRING( @var,1,CHARINDEX( CHAR(40),@var,0 ) - 1 ) = 
							REPlACE( REPLACE( SUBSTRING( @sentencia,2,LEN( @sentencia ) ),'(','' ),')','' ) )
						begin
							set @valor = SUBSTRING( 
								@var,
								CHARINDEX( CHAR(40),@var,0 ) + 1,
								@lenV1 - CHARINDEX( CHAR(40),@var,0 ) - 1 )
							
							set @valor = REPLACE( @valor,' ','' )							
							set @valor = CONVERT( varchar(max),CONVERT( numeric(28,13),@valor ) )							
						end								
					end
					else
					begin
						set @i = @lenV + 1		
					end
							
					set @i = @i + 1									
				end		
			end
		end
		else
		begin
			if( SUBSTRING( @sentencia,1,1 ) = 'N' )
			begin
				set @valor = SUBSTRING( @sentencia,2,@len - 1 )				
				set @valor = CONVERT( varchar(max),CONVERT( numeric(28,13),@valor ) )
			end
			else
			begin
				if( SUBSTRING( @sentencia,1,1 ) = 'S' )
				begin
					set @valor = SUBSTRING( @sentencia,2,@len - 1 )
				end
				else
				begin
					if( SUBSTRING( @sentencia,1,1 ) = 'F' )
					begin
						if( @modo = 'V' )
						begin
							set @valor = SUBSTRING( @sentencia,2,@len - 1 )
						end
						else
						begin
							if( SUBSTRING( @sentencia,1,4 ) = 'Fdbo' )
								begin
								set @len = LEN(@sentencia)
								set @sentencia = SUBSTRING( @sentencia,2,@len - 1 )				
								set @pos1 = 0									
								set @pos1 = CHARINDEX( char(44),@sentencia,@pos1 )
								set @pos1 = CHARINDEX( char(44),@sentencia,@pos1 + 1 )
								set @pos1 = CHARINDEX( char(44),@sentencia,@pos1 + 1 )	
								set @tipoFecha =substring(@sentencia,@pos1+2,@len-8)
								SET @tipoFecha = replace(@tipoFecha,@char,'')
								SET @tipoFecha = replace(@tipoFecha,char(44),'')
								SET @tipoFecha = replace(@tipoFecha,convert(varchar(50),@empresa),'')
								set @valor = SUBSTRING( @sentencia,1,@pos1 )	
								
								if (@tipoFecha='FAN')
									set @fecha= dateadd(day,-1,@fecha)

								if (@tipoFecha='FSI')
									set @fecha= dateadd(day,1,@fecha)
							
								set @valor = @valor + @char + CONVERT( varchar(50),@fecha ) + @char	+ char(44)+ @char + convert(varchar(50),@empresa) + @char
							
							end
							else
							begin
								set @valor = SUBSTRING( @sentencia,2,@len - 1 )
							end								
						end							
						end
						else if( SUBSTRING( @sentencia,1,1 ) = 'L' )
						begin
						
							if( SUBSTRING( @sentencia,1,4 ) = 'Ldbo' )
							begin
								set @len = LEN(@sentencia)
								set @sentencia = SUBSTRING( @sentencia,2,@len - 1 )				
								set @pos1 = 0 
								set @pos1 = CHARINDEX( char(44),@sentencia,@pos1 )
								set @pos1 = CHARINDEX( char(44),@sentencia,@pos1 + 1 )
								set @pos1 = CHARINDEX( char(44),@sentencia,@pos1 + 1 )									
								--set @pos1 = CHARINDEX( char(40),@sentencia,@pos1 + 1 )						
								set @valor = SUBSTRING( @sentencia,1,@pos1 )	   																				
								set @valor = @valor 					
							
							end
							
						end
				end
			end				
		end			
	end				

	return @valor
	
END