
CREATE PROCEDURE [dbo].[spActualizaNumeroLogistica]
	@consecutivo	varchar(50),
	@empresa		int,
	@numero			varchar(50),
	@estado			varchar(50),
	@retorno		int output
AS
/***************************************************************************
Nombre: spActualizaNumeroLogistica
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Consecutivo logística, numero de transacción
Argumentos de salida: 0 Si es exitoso
					  1 Si no es exitoso
Descripción: Actualiza el número de despacho en logística
*****************************************************************************/

	begin tran Actualiza
	
		update logProgramacionVehiculo
		set
		despacho = @numero,
		estado = @estado
		where
		numero = @consecutivo
		and empresa=@empresa
		
		
	if( @@ERROR = 0 )
	begin
		commit tran Actualiza
		set @retorno = 0
	end
	else
	begin
		rollback tran Actualiza
		set @retorno = 1
	end