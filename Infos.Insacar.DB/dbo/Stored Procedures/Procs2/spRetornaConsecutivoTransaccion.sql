
CREATE PROCEDURE [dbo].[spRetornaConsecutivoTransaccion]
	@tipoTransaccion 	varchar(50)	,
	@empresa int,
	@consecutivo			varchar(50) output
AS
/***************************************************************************
Nombre: spRetornaConsecutivoTransaccion
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tegnologia SAS

Argumentos de entrada: Tipo de transacción
Argumentos de salida: Consecutivo transación
Descripción: Obtiene el consecutivo de transacciones.
*****************************************************************************/

	declare @actual		numeric,
			@longitud		int,
			@longitudc	int,
			@prefijo		varchar(10),
			@numeracion	bit

	select @numeracion = numeracion  
	from gTipoTransaccion 
	where codigo = @tipotransaccion and empresa=@empresa

	if( @numeracion ) <> 0
	begin
		select @actual = actual,@longitud = longitud,@prefijo = prefijo
		from gTipoTransaccion
		where codigo = @tipotransaccion	and empresa=@empresa

		select @longitudc = len( convert( varchar(50),@actual + 1 ) )
		select @consecutivo = @prefijo + replicate( '0',@longitud - @longitudc ) + convert( varchar(50),@actual + 1 ) 
	end
	else
	begin
		select @consecutivo = ''
	end