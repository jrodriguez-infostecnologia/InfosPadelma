create PROCEDURE [dbo].[spAnulaTiqueteIncompletoBascula]
	@numero		varchar(50),
	@empresa int,
	@retorno	int output
AS
/***************************************************************************
Nombre: spAnulaTiqueteIncompletoBascula
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Número de transacción
Argumentos de salida: 
Descripción: Anula el tiquete seleccionado.
*****************************************************************************/

	begin tran Actualiza
	
		update bRegistroBascula 		set
		tipo = 'ANULADO'
		where
		numero = @numero and empresa=@empresa
		
	if( @@ERROR = 0 )
	begin
		set @retorno = 0
		commit tran Actualiza
	end		
	else
	begin
		set @retorno = 1
		rollback tran Actualiza
	end