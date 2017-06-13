CREATE PROCEDURE [dbo].[SpGetaGrupoNovedad] AS 
select a.*, b.descripcion nombreccosto,c.descripcion nombreccostoSiigo from aGrupoNovedad a
left join cCentrosCosto b on b.codigo =a.ccosto and b.empresa=a.empresa
left join cCentrosCostoSigo c on c.codigo=substring(a.ccostoSiigo,5, len(ccostoSiigo)) and c.empresa=a.empresa and c.mayor=substring(a.ccostoSiigo,1, 4)