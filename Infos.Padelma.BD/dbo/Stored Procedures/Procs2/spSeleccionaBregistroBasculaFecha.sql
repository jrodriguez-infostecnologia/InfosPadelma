create PROCEDURE [dbo].[spSeleccionaBregistroBasculaFecha]
	@fechaI	date,
	@fechaF	date,
	@empresa int
AS
/***************************************************************************
Nombre: spSeleccionaBregistroBasculaFecha
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Fecha inicial, fecha final
Argumentos de salida: 
Descripción: Selecciona los registro de báscula por rango de fecha
*****************************************************************************/

	select a.*,UPPER( b.descripcion ) as descripcionTipo,c.descripcion as descripcionProducto,
	REPLACE(urlTiquete,'G:\Escan\Aceites\','http://192.168.3.46/Tiquetes/' ) as urlModificada
	from bRegistroBascula a
	join gTipoTransaccion b on a.tipo = b.codigo and a.empresa=b.empresa
	join iItems c on c.codigo=a.item and c.empresa=a.empresa
	where
	CONVERT(date, fechaProceso) between		@fechaI and		@fechaF
	and a.empresa=@empresa