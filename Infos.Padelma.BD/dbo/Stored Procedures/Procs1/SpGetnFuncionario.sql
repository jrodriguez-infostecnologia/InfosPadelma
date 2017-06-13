CREATE PROCEDURE [dbo].[SpGetnFuncionario] AS 
	select distinct a.codigo, a.*, b.ccosto, 
	convert(varchar(50),a.tercero) +' - ' + a.descripcion  as cadena from nFuncionario a
	left join nContratos b on b.tercero=a.tercero 
	and b.empresa=a.empresa  and b.id = (select max(id) from nContratos where tercero=b.tercero and empresa=b.empresa)