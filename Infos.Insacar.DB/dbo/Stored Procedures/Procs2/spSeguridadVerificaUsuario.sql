CREATE PROCEDURE [dbo].[spSeguridadVerificaUsuario]
	@usuario		varchar(150),
	@clave		varchar(250),
	@sitio		varchar(50),
	@retorno	int	output
AS
/***************************************************************************
Nombre: spSeguridadVerificaUsuario
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia S.A.S
Descripción: Verifica el usuario autenticado.
*****************************************************************************/

		OPEN MASTER KEY DECRYPTION BY PASSWORD = '23987hxJKL969#ghf0%94467GRkjg5k3fd117r$$#1946kcj$n44nhdlj'

		OPEN SYMMETRIC KEY SSN_Key_01
		   DECRYPTION BY CERTIFICATE UsuariosidSys;

		if not exists(
		select * from sUsuarios a 
		join sUsuarioPerfiles b on a.usuario=b.usuario and b.activo=1
		join sPerfilPermisos c on b.perfil=c.perfil and b.activo=1
		join gEmpresa e on e.id=b.empresa 
		where 
		convert( varchar(250),DecryptByKey( a.clave ) ) = @clave 
		and a.activo=1
		and a.usuario=@usuario
		)
			begin
			set @retorno=1
			end
			else
			set @retorno=0