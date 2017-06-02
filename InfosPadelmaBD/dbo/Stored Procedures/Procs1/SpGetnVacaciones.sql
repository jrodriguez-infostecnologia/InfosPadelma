CREATE PROCEDURE [dbo].[SpGetnVacaciones] AS 
select a.empresa,a.año,a.periodo, a.mes,b.tercero tercero, b.codigo idEmpleado, b.descripcion empleado,
a.periodoInicial, a.periodoFinal, a.tipo, a.registro,a.diasCausados, a.diasPendientes,
a.ejecutado, a.anulado, a.fechaSalida, a.fechaRetorno, a.valorPagado
from nVacaciones a  
left join nfuncionario b on a.empleado=b.tercero and a.empresa=b.empresa
order by periodoInicial desc


select * from cTercero
where id=248