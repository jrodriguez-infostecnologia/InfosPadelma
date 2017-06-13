CREATE PROCEDURE [dbo].[spAnulaTrnAgronomico]
	@tipo		varchar(50),
	@numero		varchar(50),
	@usuario	varchar(50),
	@empresa	int,
	@retorno	int output
AS
/***************************************************************************
Nombre: spAnulaTrnAlmacen
Tipo: Procedimiento Almacenado
Desarrollado: Ricardo A. Matíz Gómez
Fecha: 24/10/2012

Argumentos de entrada: Periodo, tipo, número, usuario
Argumentos de salida: 0 Si es exitoso,
					  1 Si no es exitoso
Descripción: Anula la transacción de almacén seleccionada.
*****************************************************************************/

	declare @fecha		datetime,
			@referencia	varchar(50),
			@error		int	
	
	set @fecha = GETDATE()
	set @error = 0 

	begin tran Anulacion
	
		update atransaccion
		set observacion = '**ANULADO**' + observacion,
		anulado=1,
		usuarioAnulado=@usuario,
		fechaAnulado=getdate()
		where
		tipo = @tipo and
		numero = @numero and empresa=@empresa
		
		set @error = @@ERROR
		
		update atransaccionnovedad
		set
		saldo = 0			
		where
		tipo = @tipo and
		numero = @numero and 
		empresa= @empresa
		
		set @error = @error + @@ERROR
				
		
		
		select @referencia=referencia
		from atransaccion
		where
		tipo = @tipo and
		numero = @numero and 
		empresa =@empresa
		 
		set @referencia= isnull(@referencia,'')
		
			update atransaccionnovedad
			set
			ejecutado = 0,
			saldo=cantidad		
			where
			numero = @referencia 
		
			set @error = @error + @@ERROR
		
					
	if( @error = 0 )
	begin
		commit tran Anulacion
		set @retorno = 0
	end
	else
	begin
		rollback tran Anulacion
		set @retorno = 1
	end