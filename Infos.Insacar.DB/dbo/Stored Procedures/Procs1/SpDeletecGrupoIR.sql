﻿CREATE PROCEDURE SpDeletecGrupoIR @empresa int,@codigo char(5),@Retorno int output  AS begin tran cGrupoIR delete cGrupoIR where codigo = @codigo and empresa = @empresa if (@@error = 0 ) begin set @Retorno = 0 commit tran cGrupoIR end else begin set @Retorno = 1 rollback tran cGrupoIR end