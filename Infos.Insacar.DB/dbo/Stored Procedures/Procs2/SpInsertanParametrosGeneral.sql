
CREATE PROCEDURE [dbo].[SpInsertanParametrosGeneral] @embargos varchar(50), @fechaUlrimaCesantias date,@empresa int,@noSalarioIntegral int,
@jornadaDiaria int,@horaInicioDiurna int,@horaInicioNocturna int,@horaFinalDiurna int,@horaFinalNocturna int,@fechaRegistro datetime,@fechaEdicion datetime,@tipoJornadaDiaria varchar(2),@HO varchar(50),@HRN varchar(50),
@HEN varchar(50),@HED varchar(50),@HD varchar(50),@usuarioRegistro varchar(50),@usuarioEdicion varchar(50),@ATEP varchar(50),@fondoSolidaridad varchar(50),@licRemunerado varchar(50),
@licNoRemunerado varchar(50),@PrimasExtralegales varchar(50),@anticipoCesantias varchar(50),@sena varchar(50),@ICBF varchar(50),@ARP varchar(50),@indemnizacion varchar(50),@EM varchar(50),@promedioFestivo bit,
@IVM varchar(50),@subsidioTransporte varchar(50),@retroactivo varchar(50),@retencion varchar(50),@suspenciones varchar(50),@incapacidades varchar(50),@cajaCompensacion varchar(50),@noSMLVSenaICBF int,
@cesantias varchar(50),@intereses varchar(50),@vacaciones varchar(50),@primas varchar(50),@salarioIntegral varchar(50),@permisos varchar(50),@HF varchar(50),@HRF varchar(50),@ganaDomingo varchar(50),@paga31 bit,
@pagoFestivo varchar(50),@aprendizSena varchar(50),@pGanaDomingo bit, @HENF varchar(50),@HEDF varchar(50),@sueldo varchar(50),@jornales varchar(50),@salud varchar(50), @pension varchar(50),@diasVacaciones int,
@HRD varchar(50),@HEDD varchar(50),@HEND varchar(50),@fondoEmpleado varchar(50),@sindicato varchar(50), @Retorno int output  AS begin tran nParametrosGeneral 
insert nParametrosGeneral( fechaUlrimaCesantias,empresa,noSalarioIntegral,jornadaDiaria,horaInicioDiurna,horaInicioNocturna,fechaRegistro,fechaEdicion,tipoJornadaDiaria,HO,HRN,HEN,HED,
HD,usuarioRegistro,usuarioEdicion,ATEP,fondoSolidaridad,licRemunerado,licNoRemunerado,PrimasExtralegales,anticipoCesantias,sena,ICBF,ARP,indemnizacion,EM,IVM,subsidioTransporte,retroactivo,
retencion,suspenciones,incapacidades,cajaCompensacion,cesantias,intereses,vacaciones,primas,salarioIntegral,permisos,HF,HRF,HENF,HEDF,sueldo,jornales, salud, pension,embargos, 
ganaDomingo, pGanaDomingo,HRD,HEDD,HEND,fondoEmpleado,sindicato , diasVacaciones, pagoFestivo,aprendizSena, horaFinalDiurna, horaFinalNocturna,noSMLVSenaICBF,promedioFestivo,paga31)
 select @fechaUlrimaCesantias,@empresa,@noSalarioIntegral,@jornadaDiaria,@horaInicioDiurna,@horaInicioNocturna,@fechaRegistro,@fechaEdicion,@tipoJornadaDiaria,@HO,@HRN,@HEN,@HED,@HD,@usuarioRegistro,
 @usuarioEdicion,@ATEP,@fondoSolidaridad,@licRemunerado,@licNoRemunerado,@PrimasExtralegales,@anticipoCesantias,@sena,@ICBF,@ARP,@indemnizacion,@EM,@IVM,@subsidioTransporte,@retroactivo,@retencion,
 @suspenciones,@incapacidades,@cajaCompensacion,@cesantias,@intereses,@vacaciones,@primas,@salarioIntegral,@permisos,@HF,@HRF,@HENF,@HEDF,@sueldo,@jornales, @salud, @pension,@embargos, 
 @ganaDomingo,@pGanaDomingo,@HRD,@HEDD,@HEND,@fondoEmpleado,@sindicato,@diasVacaciones,@pagoFestivo,@aprendizSena,@horaFinalDiurna,@horaFinalNocturna,@noSMLVSenaICBF,@promedioFestivo,@paga31
 if (@@error = 0 ) begin set @Retorno = 0 commit tran nParametrosGeneral end else begin set @Retorno = 1 rollback tran nParametrosGeneral end