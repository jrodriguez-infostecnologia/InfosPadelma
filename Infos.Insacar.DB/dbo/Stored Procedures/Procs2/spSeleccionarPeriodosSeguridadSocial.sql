CREATE proc spSeleccionarPeriodosSeguridadSocial
@año int,
@empresa int
as


select distinct mes mes, dbo.fRetornaNombreMes(mes) nombreMes from nSeguridadSocial
where empresa=@empresa and año=@año