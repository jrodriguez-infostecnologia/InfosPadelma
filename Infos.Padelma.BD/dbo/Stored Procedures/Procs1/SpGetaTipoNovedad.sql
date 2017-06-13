
CREATE PROCEDURE [dbo].[SpGetaTipoNovedad] AS 

select distinct a.tipo, b.descripcion,a.empresa from aTipoNovedad a
join gTipoTransaccion b on b.codigo=a.tipo and b.empresa=a.empresa and b.activo=1