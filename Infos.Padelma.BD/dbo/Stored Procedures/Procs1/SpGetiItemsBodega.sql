create PROCEDURE [dbo].[SpGetiItemsBodega] AS 
select distinct a.item,b.descripcion,a.empresa from iItemsBodega a  
join iItems b on a.item=b.codigo