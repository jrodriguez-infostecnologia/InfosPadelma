CREATE PROCEDURE [dbo].[SpGetnPlanoBanco] AS 
select a.*, b.descripcion nombreBanco from nPlanoBanco a
join gBanco b on b.codigo=a.banco and b.empresa=a.empresa