﻿CREATE PROCEDURE SpDeletepProductoMovimiento @empresa int,@producto varchar(50),@movimiento varchar(50),@Retorno int output  AS begin tran pProductoMovimiento delete pProductoMovimiento where empresa = @empresa and movimiento = @movimiento and producto = @producto if (@@error = 0 ) begin set @Retorno = 0 commit tran pProductoMovimiento end else begin set @Retorno = 1 rollback tran pProductoMovimiento end