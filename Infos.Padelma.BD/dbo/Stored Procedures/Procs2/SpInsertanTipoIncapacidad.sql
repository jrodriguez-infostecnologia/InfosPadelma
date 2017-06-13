CREATE PROCEDURE [dbo].[SpInsertanTipoIncapacidad] @empresa int,@despues int,@porcentaje float,@afectaARL bit,@afectaNovedadSS varchar(50),
@porcentajeNuevo float,@adicionarPorcentaje bit,@activo bit,@codigo varchar(50),@descripcion varchar(550),
@afectaSeguridadSocial bit,@Retorno int output  AS begin tran nTipoIncapacidad 
insert nTipoIncapacidad( empresa,despues,porcentaje,porcentajeNuevo,adicionarPorcentaje,activo,
codigo,descripcion, afectaSeguridadSocial,afectaARL,afectaNovedadSS ) 
select @empresa,@despues,@porcentaje,@porcentajeNuevo,@adicionarPorcentaje,@activo,
@codigo,@descripcion,@afectaSeguridadSocial,@afectaARL,@afectaNovedadSS
if (@@error = 0 ) begin set @Retorno = 0 commit tran nTipoIncapacidad end else begin set @Retorno = 1 rollback tran nTipoIncapacidad end