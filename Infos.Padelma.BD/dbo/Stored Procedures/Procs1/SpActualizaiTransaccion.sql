﻿CREATE PROCEDURE SpActualizaiTransaccion @fecha date,@empresa int,@año int,@mes int,@vigencia int,@tercero int,@fechaRegistro datetime,@fechaAnulado datetime,@anulado bit,@tipo varchar(50),@numero varchar(50),@naturaleza varchar(1),@referencia varchar(50),@tipoSalida varchar(50),@talonario varchar(50),@departamento varchar(50),@usuario varchar(50),@usuarioAnulado varchar(50),@Retorno int output  AS begin tran iTransaccion update iTransaccion set fecha = @fecha,año = @año,mes = @mes,vigencia = @vigencia,tercero = @tercero,fechaRegistro = @fechaRegistro,fechaAnulado = @fechaAnulado,anulado = @anulado,naturaleza = @naturaleza,referencia = @referencia,tipoSalida = @tipoSalida,talonario = @talonario,departamento = @departamento,usuario = @usuario,usuarioAnulado = @usuarioAnulado where empresa = @empresa and numero = @numero and tipo = @tipo if (@@error = 0 ) begin set @Retorno = 0 commit tran iTransaccion end else begin set @Retorno = 1 rollback tran iTransaccion end