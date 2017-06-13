CREATE proc [dbo].[spSeleccionEmpresaUsuarioPermisos]
@usuario varchar(50)
as

select distinct c.* from susuarios a
join sUsuarioPerfiles b on b.usuario=a.usuario
join gEmpresa c on c.id=b.empresa
where a.usuario=@usuario