﻿CREATE PROCEDURE SpDeleteiMayorItem @empresa int,@codigo varchar(50),@Retorno int output  AS begin tran iMayorItem delete iMayorItem where codigo = @codigo and empresa = @empresa if (@@error = 0 ) begin set @Retorno = 0 commit tran iMayorItem end else begin set @Retorno = 1 rollback tran iMayorItem end