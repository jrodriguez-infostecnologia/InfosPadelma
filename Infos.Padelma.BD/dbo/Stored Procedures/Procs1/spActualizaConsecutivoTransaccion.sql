
create PROCEDURE [dbo].[spActualizaConsecutivoTransaccion]
	@tipo		varchar(50),
	@empresa int,
	@retorno	int output
AS
/***************************************************************************
Nombre: spActualizaConsecutivoTransaccion
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia

Argumentos de entrada: Tipo de transacción
Argumentos de salida: 0 Si es exitosa
					  1 Si no es exitosa.
Descripción: Actualiza el consecutivo de la transacción seleccionada.
*****************************************************************************/

	begin tran ActualizaTipoTransaccion
		update gTipoTransaccion
		set
		actual = ( actual + 1 )
		where
		codigo = @tipo
		and empresa=@empresa

	if( @@error = 0 )
	begin
		set @retorno = 0
		commit tran ActualizaTipoTransaccion
	end
	else
	begin
		set @retorno = 1
		rollback tran ActualizaTipoTransaccion
	end