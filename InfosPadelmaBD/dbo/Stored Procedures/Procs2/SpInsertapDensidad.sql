﻿CREATE PROCEDURE SpInsertapDensidad @empresa int,@temperatura int,@densidad float,@activo bit,@item varchar(50),@Retorno int output  AS begin tran pDensidad insert pDensidad( empresa,temperatura,densidad,activo,item ) select @empresa,@temperatura,@densidad,@activo,@item if (@@error = 0 ) begin set @Retorno = 0 commit tran pDensidad end else begin set @Retorno = 1 rollback tran pDensidad end