﻿CREATE PROCEDURE SpActualizagBanco @empresa int,@codigo varchar(10),@descripcion varchar(550),@Retorno int output  AS begin tran gBanco update gBanco set descripcion = @descripcion where codigo = @codigo and empresa = @empresa if (@@error = 0 ) begin set @Retorno = 0 commit tran gBanco end else begin set @Retorno = 1 rollback tran gBanco end