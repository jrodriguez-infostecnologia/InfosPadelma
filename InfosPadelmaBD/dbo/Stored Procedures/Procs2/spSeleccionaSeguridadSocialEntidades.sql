CREATE proc [dbo].[spSeleccionaSeguridadSocialEntidades]
@empresa int,
@año int,
@mes int
as
select * from [dbo].[vSeguridadSocialEntidades]
where año=@año and mes=@mes and empresa=@empresa
and valor>0