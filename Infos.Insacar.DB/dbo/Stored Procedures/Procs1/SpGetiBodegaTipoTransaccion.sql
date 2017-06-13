
CREATE PROCEDURE [dbo].[SpGetiBodegaTipoTransaccion] AS 
select distinct * from iBodegaTipoTransaccion a join gtipotransaccion b on a.tipo=b.codigo