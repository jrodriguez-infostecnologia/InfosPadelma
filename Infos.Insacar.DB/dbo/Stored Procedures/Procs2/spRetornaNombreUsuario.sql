
create PROCEDURE [dbo].[spRetornaNombreUsuario]
	@id		varchar(50),
	@nombre	varchar(250) output
AS
/***************************************************************************
Nombre: spRetornaNombreUsuario
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia S.A.S
Fecha: 16/10/2014

Argumentos de entrada: Id
Argumentos de salida: Nombre usuario
Descripción: Retorna el nombre del usuario
*****************************************************************************/

	set @nombre=isnull((select descripcion
	from susuarios
	where
	usuario = @id),'')