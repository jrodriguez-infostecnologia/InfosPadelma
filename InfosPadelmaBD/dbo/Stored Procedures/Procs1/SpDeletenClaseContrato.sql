﻿CREATE PROCEDURE [dbo].[SpDeletenClaseContrato] @empresa int,@codigo varchar(50),@Retorno int output  AS begin tran nClaseContrato delete nClaseContrato where empresa = @empresa and codigo = @codigo if (@@error = 0 ) begin set @Retorno = 0 commit tran nClaseContrato end else begin set @Retorno = 1 rollback tran nClaseContrato end