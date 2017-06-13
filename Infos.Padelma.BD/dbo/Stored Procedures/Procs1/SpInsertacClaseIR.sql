﻿CREATE PROCEDURE SpInsertacClaseIR @empresa int,@codigo int,@activo bit,@retencion bit,@impuesto bit,@descripcion varchar(950),@sigla varchar(5),@Retorno int output  AS begin tran cClaseIR insert cClaseIR( empresa,codigo,activo,retencion,impuesto,descripcion,sigla ) select @empresa,@codigo,@activo,@retencion,@impuesto,@descripcion,@sigla if (@@error = 0 ) begin set @Retorno = 0 commit tran cClaseIR end else begin set @Retorno = 1 rollback tran cClaseIR end