﻿CREATE PROCEDURE [dbo].[SpActualizapProductoMovimiento] @empresa int,@prioridad int,@orden int,@resultado bit,@almacena bit,@mCalcular bit,@mDecimal bit,@mInforme bit,@activo bit,@producto varchar(50),@movimiento varchar(50),@formula varchar(950),@modulo varchar(150),@expresion varchar(8000),@Retorno int output  AS begin tran pProductoMovimiento update pProductoMovimiento set prioridad = @prioridad,orden = @orden,resultado = @resultado,almacena = @almacena,mCalcular = @mCalcular,mDecimal = @mDecimal,mInforme = @mInforme,activo = @activo,formula = @formula, @modulo=modulo, expresion=@expresion where empresa = @empresa and movimiento = @movimiento and producto = @producto if (@@error = 0 ) begin set @Retorno = 0 commit tran pProductoMovimiento end else begin set @Retorno = 1 rollback tran pProductoMovimiento end