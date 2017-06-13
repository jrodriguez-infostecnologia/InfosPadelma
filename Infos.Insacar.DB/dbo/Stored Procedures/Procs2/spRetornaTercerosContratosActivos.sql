CREATE proc [dbo].[spRetornaTercerosContratosActivos]
@empresa int
as

select a.tercero, 'Cod. '+ convert(varchar(50),a.tercero) +' -  Id. ' + convert(varchar(50),a.codigo) +' - '+ a.descripcion descripcion 
from nFuncionario a 
join nContratos b on a.tercero=b.tercero and a.empresa=b.empresa
and a.activo=1 and b.activo=1
and a.empresa=@empresa