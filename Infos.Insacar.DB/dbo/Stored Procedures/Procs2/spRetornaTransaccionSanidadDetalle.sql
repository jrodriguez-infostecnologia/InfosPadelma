
CREATE proc [dbo].[spRetornaTransaccionSanidadDetalle]
@numero varchar(50),
@tipo varchar(50),
@empresa int 
as

select aa.*,  b.descripcion, c.descripcion,
 d.descripcion, e.descripcion ngrupocaracteristica, f.descripcion ncaracteristica
 from aSanidad a 
 join aSanidadDetalle aa on a.numero=aa.numero and a.tipo=aa.tipo and a.empresa=aa.empresa
 join aNovedad b on aa.item=b.codigo and a.empresa=b.empresa
left join aLotes c on aa.lote = c.codigo and a.empresa = c.empresa 
left join aSecciones d on a.seccion = d.codigo and d.empresa=a.empresa
left join aGrupoCaracteristica  e on e.codigo=aa.grupoCaracteristica and aa.empresa=e.empresa
left join acaracteristica f on f.codigo=aa.caracteristica and aa.empresa=e.empresa
where a.numero = @numero and a.tipo=@tipo and a.empresa = @empresa
order by registro asc