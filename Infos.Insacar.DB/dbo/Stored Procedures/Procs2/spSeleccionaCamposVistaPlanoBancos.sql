CREATE proc [dbo].[spSeleccionaCamposVistaPlanoBancos]
as

SELECT b.name codigo, b.name descripcion
FROM sys.views a
join sys.columns b on b.object_id=a.object_id
where a.name='vseleccionapago'