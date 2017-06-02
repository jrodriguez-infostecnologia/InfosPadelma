create PROCEDURE [dbo].[spSelecionaRemisionMp]
	@estado	char(1)	,
	@empresa int	
AS
/***************************************************************************
Nombre: spSelecionaRemisionMp
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS
Argumentos de entrada: Estado de remisión
Argumentos de salida: 
Descripción: Selecciona las remisiones de materia prima en el estado seleccionado
*****************************************************************************/

	select * from bRemision
	where
	estado = @estado