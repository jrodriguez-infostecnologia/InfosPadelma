﻿CREATE PROCEDURE [dbo].[SpDeletenProrroga] @empresa int,@id int,@contrato int,@tipo varchar(1),@tercero int,@Retorno int output  AS begin tran nProrroga delete nProrroga where empresa = @empresa and id = @id and contrato = @contrato and tipo = @tipo and tercero=@tercero if (@@error = 0 ) begin set @Retorno = 0 commit tran nProrroga end else begin set @Retorno = 1 rollback tran nProrroga end