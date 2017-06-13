create procedure [dbo].[spSeleccionaLogDespachoTiquete]
	@tiquete	varchar(50),
	@empresa int
AS
/***************************************************************************
Nombre: spSeleccionaBregistroBasculaTiquete
INFOS TECNOLOGIA S.A.S
*****************************************************************************/

	select a.*,REPLACE(b.urlTiquete,'G:\Escan\Aceites\','http://192.168.3.46/tiquetes/') as ver
	from logDespacho a,bRegistroBascula b
	where
	a.tiquete = @tiquete and
	a.tipo <> 'ANULADO' and
	a.tiquete <> '' and
	a.tipo = b.tipo and
	a.numero = b.numero and 
	a.empresa=b.empresa and
	a.empresa=@empresa