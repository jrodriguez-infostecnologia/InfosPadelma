
create proc [dbo].[SpDeleteTmpLiquidacion]
@empresa int,
@retorno int output
as
 begin tran TmpLiquidacion 
delete tmpliquidacionNomina
where empresa=@empresa

 if (@@error = 0 ) begin set @Retorno = 0 commit tran TmpLiquidacion end else begin set @Retorno = 1 rollback tran TmpLiquidacion end