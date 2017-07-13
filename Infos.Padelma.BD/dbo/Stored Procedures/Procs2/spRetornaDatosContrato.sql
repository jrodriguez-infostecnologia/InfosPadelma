CREATE proc [dbo].[spRetornaDatosContrato]
@empresa int,
@tercero varchar(50),
@noContrato int
as


select a.*, b.*, c.foto fotoBinaria 
from nContratos a 
join nFuncionario b on a.tercero=b.tercero
and a.empresa=b.empresa
LEFT JOIN gFoto c on c.id=b.foto
where a.empresa=@empresa and a.tercero=@tercero and a.id=@noContrato