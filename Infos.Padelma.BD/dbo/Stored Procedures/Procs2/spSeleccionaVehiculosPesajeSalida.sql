CREATE PROCEDURE [dbo].[spSeleccionaVehiculosPesajeSalida]
	@tipo	varchar(50),
	@empresa int
AS
/***************************************************************************
Nombre: spSeleccionaVehiculosPesajeSalida
Tipo: Procedimiento Almacenado
INFOS TECNOLOGIA S.A.S

Argumentos de entrada: Tipo de transacción
Argumentos de salida: 
Descripción: Selecciona los vehículos habilitados para segundo pesaje
*****************************************************************************/

	select a.numero,a.remolque,a.item,a.pesotara,a.vehiculo,
	a.vehiculo + ' - ' + convert(varchar(50),convert(DATE,a.fecha)) cadena,
	b.descripcion desitems
	from bRegistroBascula a join iItems b on a.item=b.codigo
	where
	a.tipo = @tipo and
	a.pesoNeto = 0 and
	a.estado = 'PP' and
	a.empresa= @empresa
	order by fecha asc