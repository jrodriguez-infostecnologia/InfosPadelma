CREATE PROCEDURE [dbo].[SpActualizanTipoIncapacidad] @empresa int,@despues int,
@porcentaje float,@porcentajeNuevo float,@adicionarPorcentaje bit,@afectaNovedadSS varchar(50),
@activo bit,@afectaARL bit,@codigo varchar(50),@descripcion varchar(550),@afectaSeguridadSocial bit,
@Retorno int output  AS begin tran nTipoIncapacidad update nTipoIncapacidad set despues = @despues,
porcentaje = @porcentaje,porcentajeNuevo = @porcentajeNuevo,adicionarPorcentaje = @adicionarPorcentaje,
activo = @activo,descripcion = @descripcion, afectaSeguridadSocial=@afectaSeguridadSocial ,
afectaARL=@afectaARL, afectaNovedadSS=@afectaNovedadSS
where empresa = @empresa and codigo = @codigo if (@@error = 0 ) begin set @Retorno = 0 commit tran nTipoIncapacidad end else begin set @Retorno = 1 rollback tran nTipoIncapacidad end