﻿CREATE PROCEDURE [dbo].[SpDeletecParametroContaNomi] @empresa int,@id int,@Retorno int output  AS begin tran cParametroContaNomi delete cParametroContaNomi where empresa = @empresa and id = @id if (@@error = 0 ) begin set @Retorno = 0 commit tran cParametroContaNomi end else begin set @Retorno = 1 rollback tran cParametroContaNomi end