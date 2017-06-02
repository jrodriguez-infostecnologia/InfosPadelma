
create PROCEDURE [dbo].[spSeleccionaEntidades]

AS
/***************************************************************************
Nombre: spSeleccionaEntidades
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS
Fecha: 28/10/2014

Argumentos de entrada: 
Argumentos de salida: 
Descripción: Selecciona entidades
*****************************************************************************/

	select a.name,a.id 
	from sysobjects a
	where
	a.type = 'U'
	order by a.name