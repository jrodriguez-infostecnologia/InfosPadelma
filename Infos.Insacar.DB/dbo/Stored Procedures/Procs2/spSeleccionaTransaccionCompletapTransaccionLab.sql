create PROCEDURE [dbo].[spSeleccionaTransaccionCompletapTransaccionLab]
	@where text,
	@empresa int
AS
/***************************************************************************
Nombre: spSeleccionaTransaccionCompletaSanidad
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: 
Argumentos de salida: 
Descripción: Selecciona las transacciones almacen completas.
*****************************************************************************/

	declare @select varchar(256), @emp varchar(50)= convert(varchar(10),@empresa)

	set @select = 'select distinct tipo, numero, fecha,observacion, año, mes, anulado
	from vSeleccionapTransaccionLaboratorio'

	exec( @select + ' where empresa = ' + @emp + ' and ' + @where + 
	'order by fecha,tipo,numero ' )