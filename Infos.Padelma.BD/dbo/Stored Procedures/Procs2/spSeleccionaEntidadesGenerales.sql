
CREATE PROCEDURE [dbo].[spSeleccionaEntidadesGenerales]

AS
/***************************************************************************
Nombre: spSeleccionaEntidadesGenerales
Tipo: Procedimiento Almacenado
Desarrollado: Infos tecnologia SAS
Fecha: 24/10/2014

Argumentos de entrada: 
Argumentos de salida: 
Descripción: Selecciona las entidades auxiliares
*****************************************************************************/

	select a.name,a.id 
	from sysobjects a
	where
	a.type = 'U' and
	substring( a.name,1,1 ) in ('g','i') and
	( ( select count(*) from syscolumns b
	    where
	    b.id = a.id ) = 3 )
	order by a.name