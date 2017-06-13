
CREATE PROCEDURE [dbo].[spSeleccionaMenuSitio]
	@modulo	varchar(150)
AS
/***************************************************************************
Nombre: spSeleccionaMenuSitio
Tipo: Procedimiento Almacenado
Desarrollado: InfoS Tecnologia SAS
Fecha: 31/10/2014

Argumentos de entrada: Sitio.
Argumentos de salida: 
Descripción: Selecciona los menues por sitio web.
*****************************************************************************/

	select * from smenu
	where
	modulo = @modulo
	and activo=1