create PROCEDURE [dbo].[spGetProgramacionPeriodo]
		@año	int,
	@mes	int,
	@empresa int
AS
/***************************************************************************
Nombre: spGetProgramacionPeriodo
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Periodo
Argumentos de salida: 
Descripción: Selecciona la programación general por periodo.
*****************************************************************************/

	select * from logProgramacionGeneral
	where
	año=@año
	and mes=@mes
	and empresa=@empresa