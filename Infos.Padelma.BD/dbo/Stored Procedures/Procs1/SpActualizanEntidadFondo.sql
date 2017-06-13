CREATE PROCEDURE [dbo].[SpActualizanEntidadFondo] @empresa int,@tercero int,@fechaRegistro datetime,@activo bit,
@codigo varchar(50),@descripcion varchar(550),@proveedor varchar(50),@codigoNacional varchar(50),@tipoFondo int,@cuenta varchar(50),
@observacion varchar(5550),@usuario varchar(50),@Retorno int output  AS begin tran nEntidadFondo 
update nEntidadFondo set tercero = @tercero,fechaRegistro = @fechaRegistro,activo = @activo,
descripcion = @descripcion,proveedor = @proveedor,codigoNacional = @codigoNacional,tipofondo=@tipoFondo,cuenta=@cuenta,
observacion = @observacion,usuario = @usuario where empresa = @empresa and codigo = @codigo
 if (@@error = 0 ) begin set @Retorno = 0 commit tran nEntidadFondo end 
 else begin set @Retorno = 1 rollback tran nEntidadFondo end