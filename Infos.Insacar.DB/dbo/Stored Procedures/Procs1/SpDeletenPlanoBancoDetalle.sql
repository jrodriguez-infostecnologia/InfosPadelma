CREATE PROCEDURE [dbo].[SpDeletenPlanoBancoDetalle] @empresa int,
@banco varchar(50),@Retorno int output  AS begin tran nPlanoBancoDetalle 
delete nPlanoBancoDetalle where banco = @banco and empresa = @empresa 
if (@@error = 0 ) begin set @Retorno = 0 commit tran nPlanoBancoDetalle end else begin set @Retorno = 1 rollback tran nPlanoBancoDetalle end