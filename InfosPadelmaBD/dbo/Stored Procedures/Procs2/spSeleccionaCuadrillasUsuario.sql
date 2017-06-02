
CREATE PROCEDURE [dbo].[spSeleccionaCuadrillasUsuario]
	@empresa int,
	@usuario	varchar(50)
AS
/***************************************************************************
Nombre: spSeleccionaCuadrillasUsuario
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS
Fecha: 16/11/2011

Argumentos de entrada: Usuario
Argumentos de salida: 
Descripción: Selecciona las cuadrillas asignadas a los departamentos asignados
			 al usuario. 
*****************************************************************************/

	select * from nCuadrilla
	where
	departamento in ( select departamento 
					  from sUsuarios a
					  join nFuncionario b on b.tercero=a.empleado 
					  join nDepartamento c on c.codigo=b.departamento and c.empresa=b.empresa
					    where a.usuario=@usuario and b.empresa=@empresa and a.activo=1 and b.activo=1 and c.activo=1)
					    and empresa=@empresa