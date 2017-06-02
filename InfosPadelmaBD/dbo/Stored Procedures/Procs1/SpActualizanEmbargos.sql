CREATE PROCEDURE [dbo].[SpActualizanEmbargos] @empresa int,@añoInicial int,
 @fiscal varchar(200),@cuentaBancaria varchar(50), @modoPago varchar(50), @empleado int,@codigo int,
 @año int,@mes int,@saldoCuotas int,@empresaEmbarga int,@embargante int,@cuotasCobroPosterior int,
 @cuotas int,@valorCuotas money,@porcentaje money,@valorFinal money,@valorCobroPosterior money,
 @valorBase money,@saldo money,@valorFinalPosterior money,@fecha datetime,@fechaRegistro datetime,
 @activo bit,@cobroPosterior bit,@manejaCuota bit,@manejaCuotaPosterior bit,@manejaSaldo bit,
 @pCobroPosterior decimal,@tipo varchar(50),@mandamiento varchar(50),@periodoInicial varchar(6),
 @peridoFinal varchar(6),@usuario varchar(50),@tipoCuenta varchar(50),@banco varchar(50),
 @SalarioMinimo bit,@Retorno int output  AS begin tran nEmbargos 
 update nEmbargos set año = @año,mes = @mes,saldoCuotas = @saldoCuotas,empresaEmbarga = @empresaEmbarga,
 embargante = @embargante,cuotasCobroPosterior = @cuotasCobroPosterior,cuotas = @cuotas,valorCuotas = @valorCuotas,
 porcentaje = @porcentaje,valorFinal = @valorFinal,valorCobroPosterior = @valorCobroPosterior,
 valorBase = @valorBase,saldo = @saldo,valorFinalPosterior = @valorFinalPosterior,fecha = @fecha,
 fechaRegistro = @fechaRegistro,activo = @activo,cobroPosterior = @cobroPosterior,manejaCuota = @manejaCuota,
 manejaCuotaPosterior = @manejaCuotaPosterior,manejaSaldo = @manejaSaldo,pCobroPosterior = @pCobroPosterior,
 fiscal=@fiscal,mandamiento = @mandamiento,periodoInicial = @periodoInicial,peridoFinal = @peridoFinal,usuario = @usuario,
 tipoCuenta = @tipoCuenta,banco = @banco,modopago=@modoPago, cuentaBancaria=@cuentaBancaria, añoInicial=@añoInicial, 
 salarioMinimo=@SalarioMinimo where codigo = @codigo and empleado = @empleado and empresa = @empresa and tipo = @tipo 
 
 if (@@error = 0 ) begin set @Retorno = 0 commit tran nEmbargos end else begin set @Retorno = 1 rollback tran nEmbargos end