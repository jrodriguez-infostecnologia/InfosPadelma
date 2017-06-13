create proc spEliminaNovedadesTipo
@empresa int,
@tipo varchar(50),@Retorno int output  AS 
begin tran aTipoNovedad delete aTipoNovedad where empresa = @empresa and tipo = @tipo 
if (@@error = 0 ) begin set @Retorno = 0 commit tran aTipoNovedad end else begin set @Retorno = 1 rollback tran aTipoNovedad end