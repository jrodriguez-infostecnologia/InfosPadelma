﻿create PROCEDURE [dbo].[SpInsertapJerarquia] @codigo int,@empresa int,@hijo int,@padre int,@nivel int,@activo bit,@descripcion varchar(250),@Retorno int output  AS begin tran pJerarquia insert pJerarquia( codigo,empresa,hijo,padre,nivel,activo,descripcion ) select @codigo,@empresa,@hijo,@padre,@nivel,@activo,@descripcion if (@@error = 0 ) begin set @Retorno = 0 commit tran pJerarquia end else begin set @Retorno = 1 rollback tran pJerarquia end