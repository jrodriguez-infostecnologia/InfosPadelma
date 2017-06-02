CREATE PROCEDURE [dbo].[spSeleccionaConductoresPropiosEstado]
	@codigo	varchar(50),
	@estado	int,
	@empresa int
AS
/***************************************************************************
Nombre: spSeleccionaConductoresPropiosEstado
Tipo: Procedimiento Almacenado
Desarrollado: INFOS TECNOLOGIA S.A.S

Argumentos de entrada: Código conductor, estado
Argumentos de salida: 
Descripción: Selecciona los conductores propios por estado
*****************************************************************************/

	select * from pConductor
	where
	codigo = @codigo and
	activo = @estado and 
	empresa = @empresa