﻿CREATE PROCEDURE [dbo].[SpActualizanPrestamo] @fecha date,@empresa int,@empleado int,@año int,@mes int,@periodoInicial int,@cuotas int,@cuotasPendiente int,@frecuencia int,@valor money,@valorCuotas money,@valorSaldo money,@fechaRegistro datetime,@liquidado bit,@codigo varchar(50),@ccosto varchar(50),@concepto varchar(50),@observacion varchar(5500),@usuarioRegistro varchar(50),@formaPago varchar(50),@docRef varchar(200),@Retorno int output  AS begin tran nPrestamo update nPrestamo set fecha = @fecha,empleado = @empleado,año = @año,mes = @mes,periodoInicial = @periodoInicial,cuotas = @cuotas,cuotasPendiente = @cuotasPendiente,frecuencia = @frecuencia,valor = @valor,valorCuotas = @valorCuotas,valorSaldo = @valorSaldo,fechaRegistro = @fechaRegistro,liquidado = @liquidado,ccosto = @ccosto,concepto = @concepto,observacion = @observacion,usuarioRegistro = @usuarioRegistro,formaPago = @formaPago,docRef = @docRef where codigo = @codigo and empresa = @empresa if (@@error = 0 ) begin set @Retorno = 0 commit tran nPrestamo end else begin set @Retorno = 1 rollback tran nPrestamo end