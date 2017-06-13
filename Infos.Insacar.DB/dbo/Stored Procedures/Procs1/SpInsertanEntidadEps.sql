
CREATE PROCEDURE [dbo].[SpInsertanEntidadEps] @empresa int,@tercero int,@fechaRegistro datetime,@integral bit,@activo bit,@pEmpleado 
decimal(18,2),@pEmpleador decimal(18,2),@pInactividad decimal(18,2),@codigo varchar(50),@descripcion varchar(550),@proveedor varchar(50),@codigoNacional varchar(50),
@observacion varchar(5550),@usuario varchar(50),@cuenta varchar(50),@Retorno int output  AS begin tran nEntidadEps 
insert nEntidadEps( empresa,tercero,fechaRegistro,integral,activo,pEmpleado,pEmpleador,pInactividad,codigo,descripcion,proveedor,codigoNacional,observacion,usuario,cuenta ) 
select @empresa,@tercero,@fechaRegistro,@integral,@activo,@pEmpleado,@pEmpleador,@pInactividad,@codigo,@descripcion,@proveedor,@codigoNacional,@observacion,@usuario,@cuenta 
if (@@error = 0 ) begin set @Retorno = 0 commit tran nEntidadEps end else begin set @Retorno = 1 rollback tran nEntidadEps end