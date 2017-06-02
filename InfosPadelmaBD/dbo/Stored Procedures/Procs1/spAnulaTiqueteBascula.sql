
CREATE PROCEDURE [dbo].[spAnulaTiqueteBascula]
	@tiquete	varchar(50),
	@empresa	int,
	@retorno		int output
AS
/***************************************************************************
Nombre: spAnulaTiqueteBascula
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Número de tiquete
Argumentos de salida: 
Descripción: Anula el tiquete seleccionado.
*****************************************************************************/

	begin tran Actualiza
	
	declare  @tipoTransN varchar(50)
	
	execute spRetornaConsecutivoTransaccion 'ANULADO',@empresa,@tipoTransN output
	
		update bRegistroBascula
		set
		tipo = 'ANULADO'
		--numero=@tipoTransN		
		where
		tiquete = @tiquete and empresa=@empresa
		
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