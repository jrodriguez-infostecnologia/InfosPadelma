
CREATE proc [dbo].[spSeleccionaNovedadesxTipo]
@empresa int,
@tipo varchar(50)
as
if exists(select c.codigo, c.codigo+ ' - ' +c.descripcion  descripcion, a.empresa  from gTipoTransaccion a
join aTipoNovedad b on b.tipo=a.codigo and a.empresa=b.empresa and a.activo=1
join aNovedad c on c.codigo=b.novedad and c.empresa=b.empresa and c.activo=1
where a.codigo=@tipo )
begin

		select c.codigo, c.codigo+ ' - ' +c.descripcion descripcion, c.claseLabor, a.empresa from gTipoTransaccion a
		join aTipoNovedad b on b.tipo=a.codigo and a.empresa=b.empresa and a.activo=1
		join aNovedad c on c.codigo=b.novedad and c.empresa=b.empresa and c.activo=1
		where a.codigo=@tipo
end
else
	select codigo, codigo+ ' - ' +descripcion descripcion, claseLabor, empresa from aNovedad