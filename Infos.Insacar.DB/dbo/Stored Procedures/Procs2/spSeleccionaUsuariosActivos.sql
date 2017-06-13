CREATE proc spSeleccionaUsuariosActivos
as


	select * from sUsuarios
	where activo=1