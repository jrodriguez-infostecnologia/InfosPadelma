
CREATE PROCEDURE [dbo].[SpGetnConceptosFijos] AS select distinct a.*,
c.descripcion from nConceptosFijos a join  
nconceptosFijosdetalle b on a.centrocosto = b.centrocosto  
and a.año=b.año and a.mes=b.mes and a.noPeriodo=b.noPeriodo
and a.empresa=b.empresa
join ccentroscosto c on a.centrocosto=c.codigo and a.empresa=c.empresa