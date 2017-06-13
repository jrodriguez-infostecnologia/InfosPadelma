﻿CREATE PROCEDURE SpActualizalTanque @empresa int,@item int,@capacidad float,@activo bit,@descripcion varchar(950),@codigo char(5),@Retorno int output  AS begin tran lTanque update lTanque set item = @item,capacidad = @capacidad,activo = @activo,descripcion = @descripcion where codigo = @codigo and empresa = @empresa if (@@error = 0 ) begin set @Retorno = 0 commit tran lTanque end else begin set @Retorno = 1 rollback tran lTanque end