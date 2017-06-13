
create PROCEDURE [dbo].[spSeleccionaFuncionariosDepartamento]
	@empresa int,
	@cuadrilla	varchar(50)
AS
/***************************************************************************
Nombre: spSeleccionaFuncionariosDepartamento
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS
Fecha: 11/11/2014

Argumentos de entrada: Cuadrilla
Argumentos de salida: 
Descripción: Selecciona los funcionarios asignados al departamento asignado
			 a la cuadrilla seleccionada.
*****************************************************************************/

	select * from nFuncionario
	where
	empresa=@empresa and 
	departamento = ( select departamento 
					 from nCuadrilla
					 where
					 codigo = @cuadrilla and empresa=@empresa and activo=1 ) and
	validaTurno = 1 and
	activo = 1 and
	tercero not in ( select funcionario
					from nCuadrillaFuncionario
					where
					cuadrilla = @cuadrilla and empresa=@empresa  )
	
	order by descripcion