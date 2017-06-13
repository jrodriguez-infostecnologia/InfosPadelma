
create PROCEDURE [dbo].[spRetornaDsTipoTransaccion]
	@tipoTransaccion	varchar(50),
	@empresa			int,
	@ds					varchar(250) output
AS
/***************************************************************************
Nombre: spRetornaDsTipoTransaccion
Tipo: Procedimiento Almacenado
Desarrollado: Inofs Tecnologia SAS

Argumentos de entrada: Tipo de transacción
Argumentos de salida: DataSource correspondiente a la transacción
Descripción: Retorna el nombre del DataSource correspondiente a la transacción.
*****************************************************************************/

	select @ds = vistaDs
	from gTipoTransaccion	
	where
	codigo = @tipoTransaccion
	and empresa=@empresa