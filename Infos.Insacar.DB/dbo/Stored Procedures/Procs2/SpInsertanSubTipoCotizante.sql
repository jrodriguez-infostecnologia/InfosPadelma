create PROCEDURE [dbo].[SpInsertanSubTipoCotizante] @empresa int,@fechaRegistro datetime,@activo bit,
@codigo varchar(50),@descripcion varchar(550),@observacion varchar(5550),@usuario varchar(50),@tipoCotizante varchar(50),
@Retorno int output  AS begin tran nSubTipoCotizante 
insert nSubTipoCotizante( empresa,fechaRegistro,codigo,descripcion,observacion,usuario,activo,tipoCotizante ) 
select @empresa,@fechaRegistro,@codigo,@descripcion,@observacion,@usuario,@activo,@tipoCotizante 
if (@@error = 0 ) begin set @Retorno = 0 commit tran nSubTipoCotizante end else begin set @Retorno = 1 rollback tran nSubTipoCotizante end