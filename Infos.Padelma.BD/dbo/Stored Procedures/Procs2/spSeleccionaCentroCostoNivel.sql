CREATE PROCEDURE [dbo].[spSeleccionaCentroCostoNivel]
	@nivel int,
	@empresa int	
AS
/***************************************************************************
Nombre: spSeleccionaCentroCostoNivel
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Nivel
Argumentos de salida: 
Descripción: Selecciona los destinos por nivel seleccionado
*****************************************************************************/

	select * from cCentrosCosto
	where nivel = @nivel and
	empresa=@empresa and auxiliar=0