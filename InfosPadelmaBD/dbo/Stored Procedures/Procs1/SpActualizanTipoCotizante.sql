CREATE PROCEDURE [dbo].[SpActualizanTipoCotizante] @empresa int,@fechaRegistro datetime,
@codigo varchar(50),@descripcion varchar(550),@observacion varchar(5550),@activo bit,
@usuario varchar(50),@Retorno int output  AS begin tran nTipoCotizante 
update nTipoCotizante set fechaRegistro = @fechaRegistro,descripcion = @descripcion,
observacion = @observacion,
usuario = @usuario, activo=@activo
 where empresa = @empresa and codigo = @codigo if (@@error = 0 ) begin set @Retorno = 0 commit tran nTipoCotizante end else begin set @Retorno = 1 rollback tran nTipoCotizante end