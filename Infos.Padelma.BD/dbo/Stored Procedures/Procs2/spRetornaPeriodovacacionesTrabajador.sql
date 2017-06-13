CREATE proc spRetornaPeriodovacacionesTrabajador
 @empleado int,
@empresa int
as
select periodoInicial,periodoFinal, registro,convert(varchar(50), periodoInicial) + ' a '+ convert(varchar(50), periodoFinal) + '		Pendientes.' +convert(varchar(50),a.diasPendientes) periodo from nVacaciones a join nFuncionario b 
on a.empleado=b.tercero 
where (empleado=@empleado or b.codigo=@empleado)  and a.empresa=@empresa
and anulado=0