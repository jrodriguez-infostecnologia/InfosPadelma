
create PROCEDURE [dbo].[spAnulaTrnProduccion]
	@empresa	int,
	@tipo		varchar(50),
	@numero		varchar(50),
	@usuario	varchar(50),
	@retorno	int output
AS
/***************************************************************************
Nombre: spAnulaTrnAlmacen
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Periodo, tipo, número, usuario
Argumentos de salida: 0 Si es exitoso,
					  1 Si no es exitoso
Descripción: Anula la transacción de almacén seleccionada.
*****************************************************************************/

	declare @error		int
		
	

	set @error = 0 

	begin tran Anulacion
	
		update pTransaccion
		set observacion = observacion + '**ANULADO**',
		anulado=1,
		usuarioAnulado=@usuario,
		fechaAnulado=GETDATE()
		where
		tipo = @tipo and
		numero = @numero
		and empresa=@empresa
		
		set @error = @@ERROR

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