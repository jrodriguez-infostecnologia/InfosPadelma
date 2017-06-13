
CREATE PROCEDURE [dbo].[SpActualizanIncapacidad] @fechaInicial date,@fechaFinal date,@empresa int,
@tercero int,@numero int,@noDias int,@saldo int,@fechaRegistro datetime,@prorroga bit,@liquidada bit,@concepto varchar(50),
@referencia varchar(250),@tipoIncapacidad varchar(50),@diagnostico varchar(50),@observacion varchar(5550),@valor money,@numeroReferencia int,@diasPagos int,@diasInicio int,@valorPagado money,
@usuario varchar(50),@Retorno int output  AS begin tran nIncapacidad update nIncapacidad set fechaInicial = @fechaInicial,fechaFinal = @fechaFinal,
noDias = @noDias,saldo = @saldo,fechaRegistro = @fechaRegistro,prorroga = @prorroga,numeroReferencia=@numeroReferencia, valor =@valor,diasPagos= @diasPagos ,diasInicio=  @diasInicio ,valorPagado= @valorPagado,
liquidada = @liquidada,referencia = @referencia,tipoIncapacidad = @tipoIncapacidad,diagnostico = @diagnostico,observacion = @observacion,usuario = @usuario ,concepto=@concepto
where empresa = @empresa and tercero = @tercero and numero = @numero if (@@error = 0 ) begin set @Retorno = 0 commit tran nIncapacidad end else begin set @Retorno = 1 rollback tran nIncapacidad end