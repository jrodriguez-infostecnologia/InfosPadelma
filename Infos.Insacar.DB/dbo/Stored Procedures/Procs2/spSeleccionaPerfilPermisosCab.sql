
create PROCEDURE [dbo].[spSeleccionaPerfilPermisosCab]
	@perfil	varchar(50)	
AS
/***************************************************************************
Nombre: spPlantilla
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS
Fecha: 31/10/2014

Argumentos de entrada: Perfil de usuario
Argumentos de salida: 
Descripción: Selecciona los permisos del perfil agrupados por sitio y menú.
*****************************************************************************/

	select distinct perfil,sitio,menu 
	 from sperfilPermisos
	where
	perfil = @perfil