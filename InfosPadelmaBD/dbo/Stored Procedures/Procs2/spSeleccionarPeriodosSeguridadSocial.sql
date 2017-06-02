CREATE proc [dbo].[spSeleccionarPeriodosSeguridadSocial]
@año int,
@empresa int
as


select distinct mes mes, dbo.fRetornaNombreMes(mes) nombreMes from nSeguridadSocial
where empresa=@empresa and año=@año 

union 

select distinct mes mes, dbo.fRetornaNombreMes(mes) nombreMes from nSeguridadSocialPila
where empresa=@empresa and año=@año