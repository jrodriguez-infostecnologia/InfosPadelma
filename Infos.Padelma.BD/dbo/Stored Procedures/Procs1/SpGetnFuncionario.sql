CREATE PROCEDURE [dbo].[SpGetnFuncionario] AS 
	select distinct a.codigo, a.*, b.ccosto, 
	convert(varchar(50),a.tercero) +' - ' + a.descripcion  as cadena,
	_foto.foto fotoBinaria
	from nFuncionario a
	left join nContratos b 
	on b.tercero=a.tercero 
	and b.empresa=a.empresa  
	and b.id = (select max(id) from nContratos where tercero=b.tercero and empresa=b.empresa)
	left join gFoto _foto
	ON _foto.id = a.foto