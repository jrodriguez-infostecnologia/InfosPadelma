create proc spInformeGrupoCaracteristica
@empresa int
as

select a.codigo idGrCarac, a.descripcion grCarac, b.codigo idCarac, b.descripcion Caracte from aGrupoCaracteristica a 
join aCaracteristica b on a.codigo=b.grupoCaracteristica and a.empresa=b.empresa
where a.empresa=@empresa