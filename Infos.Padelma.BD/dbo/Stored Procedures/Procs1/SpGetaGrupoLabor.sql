CREATE PROCEDURE [dbo].[SpGetaGrupoLabor] AS 
select a.*, b.descripcion nombreccosto from aGrupoLabor a
left join cCentrosCosto b on b.codigo =a.ccosto 
and  b.empresa=a.empresa