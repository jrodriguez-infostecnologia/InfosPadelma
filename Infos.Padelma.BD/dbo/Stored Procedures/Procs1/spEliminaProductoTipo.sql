create proc [dbo].[spEliminaProductoTipo]
@empresa int,
@tipo varchar(50),
@Retorno int output  AS 
begin tran gTipoTransaccionProducto 


delete gTipoTransaccionProducto where empresa = @empresa and tipo = @tipo 
if (@@error = 0 ) begin set @Retorno = 0 commit tran gTipoTransaccionProducto end else begin set @Retorno = 1 rollback tran gTipoTransaccionProducto end