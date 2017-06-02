CREATE PROCEDURE [dbo].[spSeleccionaProgramacionCargaProgramacionGrl]
	@programacion	varchar(50),
	@empresa int,
	@estado			char(1)
AS
/***************************************************************************
Nombre: spSeleccionaProgramacionCargaProgramacionGrl
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Programación general
Argumentos de salida: 
Descripción: Selecciona las programaciones de vehiculos corrspondientes a una
			 programación general
*****************************************************************************/

	
		select a.*,b.descripcionAbreviada from logProgramacionVehiculo a
		join iItems b on b.codigo=a.producto and b.empresa=a.empresa
		where
		programacionCarga = @programacion
		AND a.empresa=@empresa
		and estado=@estado