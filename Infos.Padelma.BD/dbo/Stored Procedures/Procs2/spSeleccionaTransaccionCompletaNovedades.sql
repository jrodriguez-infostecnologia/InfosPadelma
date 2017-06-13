create PROCEDURE [dbo].[spSeleccionaTransaccionCompletaNovedades]
	@where text,
	@empresa int
AS
/***************************************************************************
Nombre: spSeleccionaTransaccionCompletaNovedades
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: 
Argumentos de salida: 
Descripción: Selecciona las transacciones almacen completas.
*****************************************************************************/

	declare @select varchar(256), @emp varchar(50)= convert(varchar(10),@empresa)

	set @select = 'select tipo, numero, fecha, remision, nota ,ccosto, anulado
	from vSeleccionaNovedades'

	exec( @select + ' where empresa = ' + @emp + ' and ' + @where + 
	'order by fecha,tipo,numero ' )