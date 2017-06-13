create proc [dbo].[spEliminaConcesptosdelTipoNomina]
@empresa int,@tipo char(5),@Retorno int output  
AS begin tran cGrupoConceptoIR 
delete nTipoConceptoDetalle where empresa = @empresa and tipoConcepto = @tipo 
if (@@error = 0 ) begin set @Retorno = 0 commit tran cGrupoConceptoIR end 
else begin set @Retorno = 1 rollback tran cGrupoConceptoIR end