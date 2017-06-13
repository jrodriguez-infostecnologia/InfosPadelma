
CREATE PROCEDURE [dbo].[SpGetlAnalisisItem] AS 
select distinct a.item,b.descripcion,a.empresa from lAnalisisItem a
join iItems b on b.codigo=a.item and b.empresa=a.empresa