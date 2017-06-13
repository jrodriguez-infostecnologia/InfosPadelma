
create PROCEDURE [dbo].[spEliminaPerfilPermisosSitioMenu]
	@perfil		varchar(50),
	@sitio		varchar(50),
	@menu		varchar(50),
	@retorno	int output
AS
/***************************************************************************
Nombre: spEliminaPerfilPermisosSitioMenu
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia
Fecha: 04/11/2014

Argumentos de entrada: Perfil, sitio, menú.
Argumentos de salida: 0 Si es exitoso,
					  1 Si no es exitoso.
Descripción: Elimina los permisos de un perfil por sitio y menu.
*****************************************************************************/

	begin tran Elimina
		delete sperfilPermisos
		where
		perfil = @perfil and
		sitio = @sitio and
		menu = @menu
	if( @@ERROR = 0 )	
	begin
		commit tran Elimina
		set @retorno = 0
	end		
	else
	begin
		rollback tran Elimina
		set @retorno = 1
	end