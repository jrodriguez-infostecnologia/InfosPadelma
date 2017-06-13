
create PROCEDURE [dbo].[spSeleccionaFincaProveedor]
	@procedencia	varchar(50),
	@empresa int
AS
/***************************************************************************
Nombre: spSeleccionaFincaProveedor
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Código procedencia
Argumentos de salida: 
Descripción: Selecciona las fincas asociadas al proveedor de la procedencia
			 seleccionada
*****************************************************************************/

	select b.codigo,b.descripcion
	from bProcedencia a
	join aFinca b on b.proveedor=a.proveedor and a.empresa=b.empresa
	where
	a.codigo = @procedencia 
	order by descripcion