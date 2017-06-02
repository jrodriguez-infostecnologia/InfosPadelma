
CREATE PROCEDURE [dbo].[spVerificaEstadoRemision]
	@codigo		varchar(50),
	@estado		char(1),
	@empresa	int,
	@retorno	int output
AS
/***************************************************************************
Nombre: spVerificaEstadoRemision
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Código de remisión, estado
Argumentos de salida: 0 Si la remisión es válida para el estado seleccionado
					  1 Si la remisión no es válida para el estado seleccionado 
Descripción: Verifica si la remisión seleccionada es válida para el estado.
*****************************************************************************/

	set @retorno = 0
	
	select @retorno = COUNT( * )
	from bRemision
	where
	codigo = @codigo and
	estado = @estado and empresa=@empresa