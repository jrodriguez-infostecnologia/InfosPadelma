CREATE PROCEDURE [dbo].[SpGetnIncapacidad] AS 
select a.*, b.descripcion nombreEmpleado, c.descripcion desConcepto, convert(varchar(50), b.codigo) identificacion from nIncapacidad a
join nFuncionario b on b.tercero=a.tercero and a.empresa=b.empresa
join nConcepto c on a.concepto=c.codigo and a.empresa=c.empresa