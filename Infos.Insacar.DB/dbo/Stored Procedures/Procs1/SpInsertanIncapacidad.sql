
CREATE PROCEDURE [dbo].[SpInsertanIncapacidad] @fechaInicial date,@fechaFinal date,@empresa int,@valor money,@numeroReferencia int,@tercero int,@numero int,
@noDias int,@saldo int,@fechaRegistro datetime,@prorroga bit,@liquidada bit,@referencia varchar(250),@tipoIncapacidad varchar(50),@diagnostico varchar(50),
@concepto varchar(50),@diasPagos int,@diasInicio int,@valorPagado money,@observacion varchar(5550),@usuario varchar(50),@Retorno int output  AS begin tran nIncapacidad 
insert nIncapacidad( fechaInicial,fechaFinal,empresa,tercero,numero,noDias,saldo,fechaRegistro,prorroga,liquidada,
referencia,tipoIncapacidad,diagnostico,observacion,usuario , valor, numeroReferencia, diasPagos,diasInicio,valorPagado, concepto,anulado,fechaAnulado,usuarioAnulado) 
select @fechaInicial,@fechaFinal,@empresa,@tercero,@numero,@noDias,@saldo,@fechaRegistro,@prorroga,@liquidada,
@referencia,@tipoIncapacidad,@diagnostico,@observacion,@usuario ,@valor,@numeroReferencia,@diasPagos,@diasInicio,@valorPagado,@concepto,0,null,null
if (@@error = 0 ) begin set @Retorno = 0 commit tran nIncapacidad end else begin set @Retorno = 1 rollback tran nIncapacidad end