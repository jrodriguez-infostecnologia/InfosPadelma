
create PROCEDURE [dbo].[spCambioEstadoRemision]
	@codigo		varchar(50),
	@estado		char(1),
	@empresa    int,
	@retorno	int output
AS
/***************************************************************************
Nombre: spCambioEstadoRemision
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Código remisión, estado nuevo
Argumentos de salida: 0 Si es exitoso,
					  1 Si no es exitoso
Descripción: Cambia el estado de la remisión seleccionada
*****************************************************************************/

	begin tran Actualiza
	
		update bRemision
		set
		estado = @estado
		where
		empresa=@empresa
		and codigo = @codigo
		
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