﻿CREATE PROCEDURE SpDeleteaFinca @empresa int,@codigo varchar(50),@Retorno int output  AS begin tran aFinca delete aFinca where codigo = @codigo and empresa = @empresa if (@@error = 0 ) begin set @Retorno = 0 commit tran aFinca end else begin set @Retorno = 1 rollback tran aFinca end