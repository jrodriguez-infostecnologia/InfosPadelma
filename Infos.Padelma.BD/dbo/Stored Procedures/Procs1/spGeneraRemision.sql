
create PROCEDURE [dbo].[spGeneraRemision]
	@nroRemision	int,
	@usuario		varchar(50),
	@empresa int,
	@retorno		int output
	
AS
/***************************************************************************
Nombre: spGeneraRemision
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS
Fecha: 13/11/2014

Argumentos de entrada: Nro. de remisiones a generar, usuario
Argumentos de salida: 0 Si es exitoso,
					  1 Si no es exitoso.
Descripción: Genera el número de remisiones asignado por el usuario.
*****************************************************************************/

	declare @primero		varchar(50),			
			@fecha			datetime,
			@error			int
	
	set @error = 0
	set @fecha = GETDATE()	
	
	select @primero = right( replicate( '0',10 ) + ltrim( rtrim( isnull( MAX( codigo + 1 ),'1' ) ) ),10 )
	from bRemision	
	where empresa=@empresa	
	
	begin tran Inserta
	
		while( @nroRemision > 0 )
		begin		
		
			insert bRemision(
			codigo,
			fechaAsignacion,
			fechaCreacion,
			fechaImpresion,
			usuario,
			funcionarioAsignado,
			estado, empresa
			)
			select
			@primero,
			null,
			@fecha,
			null,
			@usuario,
			'',
			'G', @empresa
			
			set @error = ( @error + @@ERROR )
			
			select @primero = right( replicate( '0',10 ) + ltrim( rtrim( isnull( MAX( codigo + 1 ),'1' ) ) ),10 )
			from bRemision	
			where empresa=@empresa			
		
			set @nroRemision = ( @nroRemision - 1 )
		end
		
	if( @error = 0 )
	begin
		commit tran Inserta
		set @retorno = 0
	end
	else
	begin
		rollback tran Inserta
		set @retorno = 1
	end