CREATE PROCEDURE [dbo].[SpInsertanTipoCotizante] @empresa int,@fechaRegistro datetime,@activo bit,
@codigo varchar(50),@descripcion varchar(550),@observacion varchar(5550),@usuario varchar(50),
@Retorno int output  AS begin tran nTipoCotizante 
insert nTipoCotizante( empresa,fechaRegistro,codigo,descripcion,observacion,usuario,activo ) 
select @empresa,@fechaRegistro,@codigo,@descripcion,@observacion,@usuario,@activo 
if (@@error = 0 ) begin set @Retorno = 0 commit tran nTipoCotizante end else begin set @Retorno = 1 rollback tran nTipoCotizante end