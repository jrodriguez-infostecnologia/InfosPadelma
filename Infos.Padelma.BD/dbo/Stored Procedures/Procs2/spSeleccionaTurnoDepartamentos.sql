create PROCEDURE [dbo].[spSeleccionaTurnoDepartamentos]
	@empresa int,
	@turno	varchar(50)	
AS
/***************************************************************************
Nombre: spSeleccionaTurnoDepartamentos
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Turno
Argumentos de salida: 
Descripción: Selecciona los departamentos asignados a un turno.
*****************************************************************************/

	select codigo,descripcion,isnull( b.activo,0 ) as activo
	from nDepartamento a left join nTurnoDepartamento	b on	b.departamento = a.codigo and	b.turno = @turno and a.empresa=b.empresa
	where a.empresa=@empresa