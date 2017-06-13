create PROCEDURE [dbo].[spSeleccionaJerarquiaNivelPro]
	@nivel	int,
	@empresa int
AS
/***************************************************************************
Nombre: spSeleccionaJerarquiaNivelPro
Tipo: Procedimiento Almacenado
Desarrollado: Ricardo A. Matíz Gómez
Fecha: 06/03/2012

Argumentos de entrada: Nivel.
Argumentos de salida: 
Descripción: Selecciona la jerarquía por nivel.
*****************************************************************************/

	select *,Convert( varchar(50),hijo ) + ' - ' + descripcion as cadena  
	from pJerarquia
	where
	nivel = @nivel
	and
	empresa=@empresa
	order by hijo,descripcion