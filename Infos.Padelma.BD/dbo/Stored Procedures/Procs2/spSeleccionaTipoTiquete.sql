CREATE proc [dbo].[spSeleccionaTipoTiquete]
@empresa int
as

select  isnull(a.tiquete,'') codigo , b.descripcion descripcion   from gParametrosGenerales a join gTipoTransaccion b on 
a.tiquete = b.codigo and a.empresa=b.empresa
where a.empresa=@empresa
union
select  isnull(a.tiqueteAlt,'') codigo , b.descripcion descripcion   from gParametrosGenerales a join gTipoTransaccion b on 
a.tiqueteAlt = b.codigo and a.empresa=b.empresa
where a.empresa=@empresa