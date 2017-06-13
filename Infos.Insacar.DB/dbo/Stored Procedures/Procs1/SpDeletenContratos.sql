CREATE PROCEDURE 
[dbo].[SpDeletenContratos] @empresa int,@id int,@tercero int,@codigoTercero varchar(50),@usuario varchar(50),@Retorno int output  AS begin tran nContratos 

update nContratos set usuario = @usuario, usuarioActualizacion=@usuario where empresa = @empresa and id = @id and codigoTercero = @codigoTercero and tercero = @tercero

delete nContratos where empresa = @empresa and id = @id and codigoTercero = @codigoTercero and tercero = @tercero if (@@error = 0 ) begin set @Retorno = 0 commit tran nContratos end else begin set @Retorno = 1 rollback tran nContratos end