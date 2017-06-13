create PROCEDURE [dbo].[spSeleccionaProgramacionFuncionariosDias]
	@FI			date,
	@FF			date,
	@empresa		int,
	@turno			varchar(50),
	@cuadrilla		varchar(50),
	@funcionario	varchar(50)
AS
/***************************************************************************
Nombre: spSeleccionaProgramacionFuncionariosDias
Tipo: Procedimiento Almacenado
Desarrollado: Alirio Noche Arzuza
Fecha: 26/11/2013

Argumentos de entrada: Identificador de programación.
Argumentos de salida: 
Descripción: Selecciona la programación de funcionarios por día de la semana
			 según el identificador de programación.
*****************************************************************************/
	
	select funcionario,SUM( lunes ) as lunes,SUM( martes ) as martes,SUM( miercoles ) as miercoles,
	SUM( jueves ) as jueves,SUM( viernes ) as viernes,SUM( sabado ) as sabado,SUM( domingo ) as domingo
	from vProgramacionFuncionariosDias
	where
	funcionario = @funcionario 
	and turno=@turno and cuadrilla=@cuadrilla 
	and empresa=@empresa
	and fecha between @FI and @FF
	group by funcionario