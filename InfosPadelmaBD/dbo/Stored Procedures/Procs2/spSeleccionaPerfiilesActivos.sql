CREATE proc spSeleccionaPerfiilesActivos
as


	select * from sPerfiles
	where activo=1