CREATE PROCEDURE [dbo].[spRetornaCodigoEmpresaUsuario]
	@usuario		varchar(50),
	@codigoEmpresa		int output
AS
/***************************************************************************
Nombre: spVerificaAccesoOperaciones
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia S.A.S
*****************************************************************************/



	set @codigoEmpresa = (select  top 1 d.empresa from sUsuarios a 
	join sUsuarioPerfiles d on d.usuario=a.usuario
	join gEmpresa e on e.id=d.empresa
	join sLogRegistros f on f.usuario=a.usuario and f.empresa=d.empresa
	where a.usuario=@usuario 
	order by f.fecha desc )