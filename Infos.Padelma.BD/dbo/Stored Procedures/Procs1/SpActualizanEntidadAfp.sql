  
CREATE PROCEDURE [dbo].[SpActualizanEntidadAfp] @empresa int,@tercero int,@fechaRegistro datetime,@activo bit,@codigo varchar(50),@descripcion varchar(550),
@proveedor varchar(50),@codigoNacional varchar(50),@observacion varchar(5550),@usuario varchar(50),@Retorno int output  AS begin tran nEntidadAfc
 update nEntidadAfc set tercero = @tercero,fechaRegistro = @fechaRegistro,activo = @activo,descripcion = @descripcion,proveedor = @proveedor,codigoNacional = @codigoNacional,
 observacion = @observacion,usuario = @usuario where empresa = @empresa and codigo = @codigo 
 if (@@error = 0 ) begin set @Retorno = 0 commit tran nEntidadAfc end else begin set @Retorno = 1 rollback tran nEntidadAfc end