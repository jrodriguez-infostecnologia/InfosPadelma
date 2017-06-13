
CREATE PROCEDURE [dbo].[SpGetgTipoTransaccionProducto] AS 
select distinct * from gTipoTransaccionProducto a join gtipotransaccion b on a.tipo=b.codigo