CREATE PROCEDURE [dbo].[SpInsertanVacaciones] @periodoInicial date,@periodoFinal date,@fechaSalida date,@fechaRetorno date,@empresa int,@empleado int,@registro int,@diasCausados int,@diasTomados int,@diasPendientes int,@diasPagados int,@año int,@mes int,@periodo int,@fechaRegistro datetime,@fechaAnulado datetime,@anulado bit,@ejecutado bit,@pagaNomina bit,@acumulada bit,@liquidada bit,@valorPagado decimal,@añoPago int,
@valorBase decimal,@tipo varchar(10),@usuario varchar(50),@observaciones varchar(500),@usuarioAnulado varchar(50),@Retorno int output  AS begin tran nVacaciones 

if @tipo=2
begin
set @fechaSalida=GETDATE()
set @fechaRetorno = GETDATE()
end
select @mes=mes from nPeriodoDetalle
where noPeriodo=@periodo and empresa=@empresa and año=@añoPago

insert nVacaciones( periodoInicial,periodoFinal,fechaSalida,fechaRetorno,empresa,empleado,registro,diasCausados,diasTomados,diasPendientes,diasPagados,año,mes,periodo,fechaRegistro,fechaAnulado,anulado,ejecutado,pagaNomina,acumulada,liquidada,valorPagado,valorBase,tipo,usuario,observaciones,usuarioAnulado,añoPago ) 
select @periodoInicial,@periodoFinal,@fechaSalida,@fechaRetorno,@empresa,@empleado,@registro,@diasCausados,@diasTomados,@diasPendientes,@diasPagados,@año,@mes,@periodo,@fechaRegistro,@fechaAnulado,@anulado,@ejecutado,@pagaNomina,@acumulada,@liquidada,@valorPagado,@valorBase,@tipo,@usuario,@observaciones,@usuarioAnulado,@añoPago
 if (@@error = 0 ) begin set @Retorno = 0 commit tran nVacaciones end else begin set @Retorno = 1 rollback tran nVacaciones end