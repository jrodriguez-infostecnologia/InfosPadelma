create PROCEDURE [dbo].[spSeleccionaFuncionariosSinProgramacionCuadrilla]
	@empresa int,
	@fechaI		date,
	@fechaF		date,
	@cuadrilla	varchar(50)	
AS
/***************************************************************************
Nombre: spSeleccionaFuncionariosSinProgramacionCuadrilla
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Fecha inicia, fecha final, cuadrilla
Argumentos de salida: 
Descripción: Selecciona los funcionarios sin programación en el rengo de fechas
			 dado y pertenecientes a la cuadrilla seleccionada.
*****************************************************************************/

	select a.tercero as funcionario,a.descripcion,b.descripcion as cargo,0 as programado
	from nFuncionario a
	join nContratos e on e.tercero =a.tercero and e.empresa=a.empresa and e.activo=1 
	join nCargo b on e.cargo = b.codigo and b.empresa=e.empresa
	where a.codigo not in ( select funcionario from nProgramacion where fecha between @fechaI and @fechaF and	estado = 'P' and empresa=@empresa) and
	e.departamento = ( select departamento from nCuadrilla	where codigo = @cuadrilla  and empresa=@empresa)
	and a.empresa=@empresa