CREATE PROCEDURE [dbo].[SpGetnTurno] AS 
select codigo, descripcion + '	Hora inicio:	'+ SUBSTRING( convert(varchar(50), DATEADD(HOUR, horaInicio/100,convert(datetime,convert(date, GETDATE()))),120),12,9) descripcion, 
empresa, activo, horaInicio,horas from nTurno