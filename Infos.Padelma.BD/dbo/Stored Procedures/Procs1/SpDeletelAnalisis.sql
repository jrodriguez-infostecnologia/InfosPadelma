﻿CREATE PROCEDURE SpDeletelAnalisis @empresa int,@codigo varchar(10),@Retorno int output  AS begin tran lAnalisis delete lAnalisis where codigo = @codigo and empresa = @empresa if (@@error = 0 ) begin set @Retorno = 0 commit tran lAnalisis end else begin set @Retorno = 1 rollback tran lAnalisis end