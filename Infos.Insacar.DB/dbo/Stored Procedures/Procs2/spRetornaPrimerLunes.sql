create procedure [dbo].[spRetornaPrimerLunes]
	@fecha	date,
	@fechaR	date output
AS
/***************************************************************************
Nombre: spRetornaPrimerLunes
Tipo: Procedimiento Almacenado
INFOS TECNOLOGIA S.A.S
Descripción: Retorna la fecha del primer lunes despues de una fecha determinada
*****************************************************************************/

	declare @dia	varchar(10)
	
	select @dia = DATENAME( weekday,@fecha )	

	if( @dia = 'Lunes' )
	begin
		set @fechaR = @fecha
	end
	
	if( @dia = 'Martes' )
	begin
		set @fechaR = dateadd( day,6,@fecha )
	end
	
	if( @dia = 'Miércoles' )
	begin
		set @fechaR = dateadd( day,5,@fecha )
	end		
	
	if( @dia = 'Jueves' )
	begin
		set @fechaR = dateadd( day,4,@fecha )
	end	
	
	if( @dia = 'Viernes' )
	begin
		set @fechaR = dateadd( day,3,@fecha )
	end	
	
	if( @dia = 'Sábado' )
	begin
		set @fechaR = dateadd( day,2,@fecha )
	end	
	
	if( @dia = 'Domingo' )
	begin
		set @fechaR = dateadd( day,1,@fecha )
	end