CREATE PROCEDURE [dbo].[SpGetnLiquidacionNomina] AS 
select distinct a.*,b.noPeriodo from nLiquidacionNomina a
join nLiquidacionNominaDetalle b on b.numero=a.numero and b.tipo=a.tipo and b.empresa=a.empresa