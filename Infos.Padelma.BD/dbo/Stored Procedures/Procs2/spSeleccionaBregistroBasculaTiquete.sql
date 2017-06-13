CREATE PROCEDURE [dbo].[spSeleccionaBregistroBasculaTiquete]
	@tiquete	varchar(50),
	@empresa	int
AS
/***************************************************************************
Nombre: spSeleccionaBregistroBasculaTiquete
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Número de tiquete
Argumentos de salida: 
Descripción: Selecciona el registro de báscula por número de tiquete
*****************************************************************************/

	select a.*,REPLACE(urlTiquete,'G:\Escan\Aceites\','http://192.168.3.46/tiquetes/') as ver,b.tiquete,c.tercero,c.cliente
	from bRegistroBascula a
	join gParametrosGenerales b on b.empresa=a.empresa
	left join logProgramacionVehiculo c on c.numero=a.remision and c.empresa =a.empresa
	where a.tiquete  = @tiquete and
	a.tipo not in (b.anulado) and
	a.tiquete <> '' 
	and a.empresa=@empresa