﻿CREATE PROCEDURE SpActualizalRegistroBodega @empresa int,@cantidad int,@tipo varchar(50),@numero varchar(50),@bodega varchar(5),@Retorno int output  AS begin tran lRegistroBodega update lRegistroBodega set cantidad = @cantidad where bodega = @bodega and empresa = @empresa and numero = @numero and tipo = @tipo if (@@error = 0 ) begin set @Retorno = 0 commit tran lRegistroBodega end else begin set @Retorno = 1 rollback tran lRegistroBodega end