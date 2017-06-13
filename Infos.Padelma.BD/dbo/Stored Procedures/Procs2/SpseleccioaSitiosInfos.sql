CREATE proc [dbo].[SpseleccioaSitiosInfos]
@usuario varchar(50),
@clave varchar(50),
@empresa int
as



select distinct e.descripcion,e.dirUrl +'?usuario='+@usuario+'&clave='+@clave+'&empresa='+ convert(varchar(50),@empresa) as dirUrl,d.activo,e.orden, 
REPLACE(e.imagen,'~/','../')imagen 
--e.imagen
from susuarios a
left join susuarioPerfiles b on b.usuario=a.usuario
left join sperfiles c on c.codigo=b.perfil
left join sperfilPermisos d on d.perfil=c.codigo
left join sModulos e on e.codigo=d.sitio
where a.usuario =@usuario  and dirUrl!='NULL' and e.activo=1
order by e.orden