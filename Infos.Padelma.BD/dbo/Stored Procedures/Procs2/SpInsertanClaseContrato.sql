CREATE PROCEDURE [dbo].[SpInsertanClaseContrato] @empresa int,@terminoFijo bit,@activo bit,@codigo varchar(50),
@descripcion varchar(550), @electivaProduccion bit,@porcentaje decimal(18,3),@porcentajeSS decimal(18,3), @Retorno int output  AS 
begin tran nClaseContrato insert nClaseContrato( empresa,terminoFijo,activo,codigo,descripcion,electivaProduccion,porcentaje,porcentajeSS ) 
select @empresa,@terminoFijo,@activo,@codigo,@descripcion,@electivaProduccion,@porcentaje,@porcentajeSS
if (@@error = 0 ) begin set @Retorno = 0 commit tran nClaseContrato end else begin set @Retorno = 1 rollback tran nClaseContrato end