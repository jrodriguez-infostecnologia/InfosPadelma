﻿CREATE PROCEDURE [dbo].[SpGetpProductoMovimientokey] @empresa int,@producto varchar(50),@movimiento varchar(50), @modulo varchar(150) AS  select * from pProductoMovimiento where empresa = @empresa and movimiento = @movimiento and producto = @producto and modulo=@modulo