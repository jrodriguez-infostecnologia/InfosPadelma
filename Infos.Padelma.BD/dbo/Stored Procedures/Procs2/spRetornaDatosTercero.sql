CREATE proc [dbo].[spRetornaDatosTercero]
@tercero varchar(50),
@empresa int
as


select 
b.*,
a.*,
c.foto fotoBinaria 
from 
cTercero b
INNER JOIN nFuncionario a on a.tercero = b.id and a.empresa = b.empresa
LEFT JOIN gFoto c on c.id=a.foto
where b.id=@tercero and b.empresa=@empresa