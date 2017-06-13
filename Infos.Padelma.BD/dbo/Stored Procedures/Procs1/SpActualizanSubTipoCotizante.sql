create PROCEDURE [dbo].[SpActualizanSubTipoCotizante] @empresa int,@fechaRegistro datetime,
@codigo varchar(50),@descripcion varchar(550),@observacion varchar(5550),@activo bit,@tipoCotizante varchar(50),
@usuario varchar(50),@Retorno int output  AS begin tran nSubTipoCotizante 
update nSubTipoCotizante set fechaRegistro = @fechaRegistro,descripcion = @descripcion,
observacion = @observacion,
usuario = @usuario, activo=@activo,
tipoCotizante=@tipoCotizante
 where empresa = @empresa and codigo = @codigo if (@@error = 0 ) begin set @Retorno = 0 commit tran nSubTipoCotizante end else begin set @Retorno = 1 rollback tran nSubTipoCotizante end