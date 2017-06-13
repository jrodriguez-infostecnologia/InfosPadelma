﻿create PROCEDURE [dbo].[SpActualizagTipoLiquidacion] @codigo int,@empresa int,@descripcion varchar(200),@Retorno int output  AS begin tran gTipoLiquidacion update gTipoLiquidacion set descripcion = @descripcion where codigo = @codigo and empresa = @empresa if (@@error = 0 ) begin set @Retorno = 0 commit tran gTipoLiquidacion end else begin set @Retorno = 1 rollback tran gTipoLiquidacion end