
CREATE PROCEDURE [dbo].[SpGetnPrestamo] AS 
select a.*, b.descripcion desEmpleado, c.descripcion desConcepto from nPrestamo a
join nFuncionario b on b.tercero=a.empleado and b.empresa=a.empresa
join nConcepto c on c.codigo=a.concepto and c.empresa=a.empresa