
CREATE PROCEDURE [dbo].[spSeleccionaFuncionariosCuadrilla]
	@empresa int,
	@cuadrilla	varchar(50)
AS
/***************************************************************************
Nombre: spSeleccionaFuncionariosCuadrilla
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS
Fecha: 11/11/2014

Argumentos de entrada: Cuadrilla
Argumentos de salida: 
Descripción: Selecciona los funcionarios asignados a una cuadrilla.
*****************************************************************************/

	select b.tercero codigo,descripcion,cuadrilla 
	from nCuadrillaFuncionario a
	join nFuncionario b on b.tercero=a.funcionario and b.empresa=a.empresa
	where
	cuadrilla = @cuadrilla
	and b.activo=1
	and a.empresa=@empresa