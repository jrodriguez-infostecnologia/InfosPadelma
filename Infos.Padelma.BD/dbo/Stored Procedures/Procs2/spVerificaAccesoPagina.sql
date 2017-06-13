create PROCEDURE [dbo].[spVerificaAccesoPagina]
	@sitio		varchar(50),
	@usuario	varchar(50),
	@pagina		varchar(50),
	@empresa	int,
	@conteo		int output
AS
/***************************************************************************
Nombre: spVerificaAccesoPagina
Tipo: Procedimiento Almacenado
Desarrollado: Ricardo A. Matíz Gómez
Fecha: 12/06/2011

Argumentos de entrada: Sitio web, usuario, página web.
Argumentos de salida: Conteo
Descripción: Retorna el conteo de las operaciones permitidas para el usuario,
			 sitio web y página seleccionada.
*****************************************************************************/
	
	select @conteo=count(*)
	from sPerfilPermisos a join sUsuarioPerfiles b on a.perfil=b.perfil 
	join sMenu c on c.codigo=a.menu
	join sPerfiles d on d.codigo=a.perfil
	where
	b.usuario = @usuario and
	c.pagina = @pagina and
	b.empresa=@empresa and
	a.activo=1 and
	b.activo=1 and
	c.activo=1 and
	c.activo=1 and
	d.activo=1