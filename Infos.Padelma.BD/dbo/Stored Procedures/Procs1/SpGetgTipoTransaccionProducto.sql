﻿CREATE PROCEDURE [dbo].[SpGetgTipoTransaccionProducto] AS 
select a.empresa, a.tipo,b.descripcion,a.producto,c.descripcion nombreProducto, ''  remision,  'false' comercializadora from gTipoTransaccionProducto a 
join gtipotransaccion b on a.tipo=b.codigo 
join iItems c on c.codigo=a.producto and c.empresa=a.empresa