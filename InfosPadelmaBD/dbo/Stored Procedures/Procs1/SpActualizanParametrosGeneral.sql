﻿CREATE PROCEDURE [dbo].[SpActualizanParametrosGeneral] 
@embargos varchar(50),
@empresa int,
@noSalarioIntegral int,
@jornadaDiaria int,
@tipoJornadaDiaria varchar(2),
@horaInicioDiurna int,
@horaInicioNocturna int,
@horaFinalDiurna int,
@horaFinalNocturna int,
@fechaUlrimaCesantias date,
@HO varchar(50),
@HRN varchar(50),
@HEN varchar(50),
@HED varchar(50),
@HD varchar(50),
@HF varchar(50),
@HRF varchar(50),
@HENF varchar(50),
@HEDF varchar(50),
@sueldo varchar(50),
@jornales varchar(50),
@cesantias varchar(50),
@intereses varchar(50),
@vacaciones varchar(50),
@primas varchar(50),
@salarioIntegral varchar(50),
@permisos varchar(50),
@subsidioTransporte varchar(50),
@retroactivo varchar(50),
@retencion varchar(50),
@suspenciones varchar(50),
@incapacidades varchar(50),
@cajaCompensacion varchar(50),
@sena varchar(50),
@ICBF varchar(50),
@ARP varchar(50),
@indemnizacion varchar(50),
@EM varchar(50),
@IVM varchar(50),
@ATEP varchar(50),
@fondoSolidaridad varchar(50),
@licRemunerado varchar(50),
@licNoRemunerado varchar(50),
@PrimasExtralegales varchar(50),
@anticipoCesantias varchar(50),
@fechaRegistro datetime,
@fechaEdicion datetime,
@usuarioRegistro varchar(50),
@usuarioEdicion varchar(50),
@salud varchar(50),
@pension varchar(50),
@ganaDomingo varchar(50),
@pGanaDomingo bit,
@HRD varchar(50),
@HEDD varchar(50),
@HEND varchar(50),
@fondoEmpleado varchar(50),
@sindicato varchar(50),
@diasVacaciones int,
@pagoFestivo varchar(50),
@aprendizSena varchar(50),
@noSMLVSenaICBF int,
@promedioFestivo bit,
@paga31 bit,@LQN varchar(50),@LQC varchar(50),@ACU varchar(50),
@Retorno int output  
AS begin tran nParametrosGeneral 
update nParametrosGeneral 
set 
noSalarioIntegral =  @noSalarioIntegral,
jornadaDiaria =  @jornadaDiaria,
tipoJornadaDiaria =  @tipoJornadaDiaria,
horaInicioDiurna =  @horaInicioDiurna,
horaInicioNocturna =  @horaInicioNocturna,
fechaUlrimaCesantias =  @fechaUlrimaCesantias,
HO =  @HO,
HRN =  @HRN,
HEN =  @HEN,
HED =  @HED,
HD =  @HD,
HF =  @HF,
HRF =  @HRF,
HENF =  @HENF,
HEDF =  @HEDF,
sueldo =  @sueldo,
jornales =  @jornales,
cesantias =  @cesantias,
intereses =  @intereses,
vacaciones =  @vacaciones,
primas =  @primas,
salarioIntegral =  @salarioIntegral,
permisos =  @permisos,
subsidioTransporte =  @subsidioTransporte,
retroactivo =  @retroactivo,
retencion =  @retencion,
suspenciones =  @suspenciones,
incapacidades =  @incapacidades,
cajaCompensacion =  @cajaCompensacion,
sena =  @sena,
ICBF =  @ICBF,
ARP =  @ARP,
indemnizacion =  @indemnizacion,
EM =  @EM,
IVM =  @IVM,
ATEP =  @ATEP,
fondoSolidaridad =  @fondoSolidaridad,
licRemunerado =  @licRemunerado,
licNoRemunerado =  @licNoRemunerado,
PrimasExtralegales =  @PrimasExtralegales,
anticipoCesantias =  @anticipoCesantias,
fechaRegistro =  @fechaRegistro,
fechaEdicion =  @fechaEdicion,
usuarioRegistro =  @usuarioRegistro,
usuarioEdicion =  @usuarioEdicion,
salud =  @salud,
pension =  @pension,
embargos=@embargos,
ganaDomingo=@ganaDomingo,
pGanaDomingo =@pGanaDomingo,
HRD=@HRD,
HEDD=@HEDD,
HEND=@HEND,
fondoEmpleado=@fondoEmpleado,
sindicato=@sindicato,
diasVacaciones=@diasVacaciones,
pagoFestivo=@pagoFestivo,
aprendizSena=@aprendizSena,
horaFinalDiurna=@horaFinalDiurna,
horaFinalNocturna=@horaFinalNocturna,
noSMLVSenaICBF=@noSMLVSenaICBF,
promedioFestivo=@promedioFestivo,
paga31=@paga31,
LQN=@LQN,
LQC=@LQC,
ACU=@ACU
where empresa = @empresa
if (@@error = 0 ) begin set @Retorno = 0 commit tran nParametrosGeneral end
 else begin set @Retorno = 1 rollback tran nParametrosGeneral end