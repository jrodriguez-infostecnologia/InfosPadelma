CREATE PROCEDURE [dbo].[SpActualizanClaseContrato] @empresa int,@terminoFijo bit,@activo bit,@codigo varchar(50),
@electivaProduccion bit,@porcentaje decimal(18,3),@descripcion varchar(550),@porcentajeSS decimal(18,3),@Retorno int output  AS begin tran nClaseContrato 
update nClaseContrato set terminoFijo = @terminoFijo,activo = @activo,descripcion = @descripcion ,
electivaProduccion=@electivaProduccion,porcentaje=@porcentaje,porcentajeSS=@porcentajeSS
where empresa = @empresa and codigo = @codigo if (@@error = 0 ) begin set @Retorno = 0 commit tran nClaseContrato end else begin set @Retorno = 1 rollback tran nClaseContrato end