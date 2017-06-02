﻿CREATE PROCEDURE SpInsertaiDestino @empresa int,@nivel int,@nivelPadre int,@activo bit,@codigo varchar(50),@padre varchar(50),@descripcion varchar(50),@ctaInversion varchar(16),@ctaGasto varchar(16),@Retorno int output  AS begin tran iDestino insert iDestino( empresa,nivel,nivelPadre,activo,codigo,padre,descripcion,ctaInversion,ctaGasto ) select @empresa,@nivel,@nivelPadre,@activo,@codigo,@padre,@descripcion,@ctaInversion,@ctaGasto if (@@error = 0 ) begin set @Retorno = 0 commit tran iDestino end else begin set @Retorno = 1 rollback tran iDestino end