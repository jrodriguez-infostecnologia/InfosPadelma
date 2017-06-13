
create proc [dbo].[spSeleccionMenuPrincipal]
@usuario varchar(50),
@clave varchar(50),
@empresa int,
@menuPrincipal varchar(250) output
as

set @menuPrincipal = isnull((select e.dirUrl +'?usuario='+@usuario+'&clave='+@clave+'&empresa='+ convert(varchar(50),@empresa) as dirUrl
from sModulos e where e.codigo='menu'),'')