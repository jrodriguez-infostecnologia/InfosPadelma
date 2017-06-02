CREATE PROCEDURE [dbo].[SpGetnDepartamento] AS 
select a.*, a.codigo + ' - ' + a.descripcion +' ( '+ b.descripcion +' ) ' cadena   from nDepartamento a
join cCentrosCosto b on b.codigo=a.ccosto and a.empresa=b.empresa