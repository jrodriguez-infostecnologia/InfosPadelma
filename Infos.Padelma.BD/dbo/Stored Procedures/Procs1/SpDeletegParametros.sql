﻿CREATE PROCEDURE SpDeletegParametros @empresa int,@codigo varchar(50),@Retorno int output  AS begin tran gParametros delete gParametros where codigo = @codigo and empresa = @empresa if (@@error = 0 ) begin set @Retorno = 0 commit tran gParametros end else begin set @Retorno = 1 rollback tran gParametros end