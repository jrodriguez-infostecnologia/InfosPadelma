CREATE PROCEDURE [dbo].[SpInsertanPlanoBanco] @empresa int,@banco varchar(50),
@usuario varchar(50),@fechaRegistro datetime,
@Retorno int output  AS begin tran nPlanoBanco insert nPlanoBanco( empresa,banco,usuario,fechaRegistro ) 
select @empresa,@banco,@usuario,@fechaRegistro
 if (@@error = 0 ) begin set @Retorno = 0 commit tran nPlanoBanco end else begin set @Retorno = 1 rollback tran nPlanoBanco end