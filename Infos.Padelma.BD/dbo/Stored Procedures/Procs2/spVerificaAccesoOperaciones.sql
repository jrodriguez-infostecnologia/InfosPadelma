CREATE PROCEDURE [dbo].[spVerificaAccesoOperaciones]
	@sitio		varchar(50),
	@usuario	varchar(50),
	@pagina		varchar(50),
	@operacion	varchar(50),
	@empresa int,
	@conteo		int output
AS
/***************************************************************************
Infos Tecnologia S.A.S
Retorna los permisos de los usuarios
*****************************************************************************/

	select @conteo=count(*)
	from sPerfilPermisos a join sUsuarioPerfiles b on a.perfil=b.perfil 
	join sMenu c on c.codigo=a.menu
	join sPerfiles d on d.codigo=a.perfil
	where
	b.usuario = @usuario and
	c.pagina = @pagina and
	a.operacion = @operacion and
	b.empresa=@empresa and
	a.activo=1 and
	b.activo=1 and
	c.activo=1 and
	c.activo=1 and
	d.activo=1