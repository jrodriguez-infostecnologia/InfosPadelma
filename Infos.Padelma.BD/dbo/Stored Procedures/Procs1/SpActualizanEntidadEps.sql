
CREATE PROCEDURE [dbo].[SpActualizanEntidadEps] @empresa int,@tercero int,@fechaRegistro datetime,@integral bit,@activo bit,@pEmpleado decimal(18,2),
@pEmpleador decimal(18,2),@pInactividad decimal(18,2),@codigo varchar(50),@descripcion varchar(550),@proveedor varchar(50),@codigoNacional varchar(50),
@observacion varchar(5550),@usuario varchar(50),@cuenta varchar(50),@Retorno int output  AS begin tran nEntidadEps update nEntidadEps set tercero = @tercero,
fechaRegistro = @fechaRegistro,integral = @integral,activo = @activo,pEmpleado = @pEmpleado,pEmpleador = @pEmpleador,pInactividad = @pInactividad,
descripcion = @descripcion,proveedor = @proveedor,codigoNacional = @codigoNacional,observacion = @observacion,usuario = @usuario,cuenta = @cuenta 
where empresa = @empresa and codigo = @codigo 
if (@@error = 0 ) begin set @Retorno = 0 commit tran nEntidadEps end else begin set @Retorno = 1 rollback tran nEntidadEps end