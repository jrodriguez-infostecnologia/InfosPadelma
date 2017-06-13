
CREATE proc [dbo].[spSelccionaTercernoNovedad]
@empresa int
as
select a.id, a.descripcion, convert(varchar(50),a.id) +' - ' + a.descripcion  as cadena, a.codigo from cTercero  a
 join nContratos b on b.tercero=a.id and b.empresa=a.empresa
 join cCentrosCosto c on c.codigo=b.ccosto and c.empresa=b.empresa
where a.activo=1 and a.empresa=@empresa and c.manejaLC=1 and b.activo = 1
union
select a.tercero, a.descripcion, convert(varchar(50),a.tercero) +' - ' + a.descripcion  as cadena, a.codigo from nFuncionario  a
where  a.contratista=1 and empresa=@empresa