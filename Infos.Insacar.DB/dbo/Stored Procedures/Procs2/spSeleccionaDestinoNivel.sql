CREATE PROCEDURE [dbo].[spSeleccionaDestinoNivel]
	@nivel int,
	@empresa int	
AS
/***************************************************************************
Nombre: spSeleccionaDestinoNivel
Tipo: Procedimiento Almacenado
Desarrollado: Ricardo A. Matíz Gómez
Fecha: 04/12/2011

Argumentos de entrada: Nivel
Argumentos de salida: 
Descripción: Selecciona los destinos por nivel seleccionado
*****************************************************************************/

	select * from iDestino
	where
	nivel = @nivel and
	empresa=@empresa