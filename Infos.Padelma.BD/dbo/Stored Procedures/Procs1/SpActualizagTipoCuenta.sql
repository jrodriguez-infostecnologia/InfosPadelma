﻿CREATE PROCEDURE SpActualizagTipoCuenta @empresa int,@descripcion varchar(250),@codigo char(1),@Retorno int output  AS begin tran gTipoCuenta update gTipoCuenta set descripcion = @descripcion where codigo = @codigo and empresa = @empresa if (@@error = 0 ) begin set @Retorno = 0 commit tran gTipoCuenta end else begin set @Retorno = 1 rollback tran gTipoCuenta end