create PROCEDURE [dbo].[spSeleccionaBregistroBasculaTiquete]
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

	select *,REPLACE(urlTiquete,'G:\Escan\Aceites\','http://192.168.3.46/tiquetes/') as ver
	from bRegistroBascula
	where
	tiquete  = @tiquete and
	tipo <> 'ANULADO' and
	tiquete <> '' 
	and empresa=@empresa