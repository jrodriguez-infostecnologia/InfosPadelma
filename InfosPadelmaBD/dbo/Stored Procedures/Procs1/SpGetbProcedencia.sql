
CREATE PROCEDURE [dbo].[SpGetbProcedencia] AS 
select a.*, b.razonSocial as desProveedor,c.razonSocial as desAgrupado  from bProcedencia a
join cTercero b on b.id =a.proveedor and b.empresa=a.empresa
join cTercero c on c.id =a.agrupadoPor and c.empresa=a.empresa