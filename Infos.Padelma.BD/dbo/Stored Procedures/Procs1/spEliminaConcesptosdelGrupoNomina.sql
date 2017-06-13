create proc [dbo].[spEliminaConcesptosdelGrupoNomina]
@empresa int,@grupo char(5),@Retorno int output  
AS begin tran cGrupoConceptoIR 
delete nGrupoConceptoDetalle where empresa = @empresa and grupo = @grupo 
if (@@error = 0 ) begin set @Retorno = 0 commit tran cGrupoConceptoIR end 
else begin set @Retorno = 1 rollback tran cGrupoConceptoIR end