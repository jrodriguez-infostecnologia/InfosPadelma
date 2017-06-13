CREATE PROCEDURE [dbo].[SpInsertanEntidadFondo] @empresa int,@tercero int,@fechaRegistro datetime,@activo bit,@codigo varchar(50),@descripcion varchar(550),@cuenta varchar(50),
@proveedor varchar(50),@codigoNacional varchar(50),@observacion varchar(5550),@usuario varchar(50),@tipofondo int,@Retorno int output  AS begin tran nEntidadFondo 
insert nEntidadFondo( empresa,tercero,fechaRegistro,activo,codigo,descripcion,proveedor,codigoNacional,observacion,usuario,tipoFondo,cuenta ) 
select @empresa,@tercero,@fechaRegistro,@activo,@codigo,@descripcion,@proveedor,@codigoNacional,@observacion,@usuario,@tipoFondo ,@cuenta
if (@@error = 0 ) begin set @Retorno = 0 commit tran nEntidadFondo end else begin set @Retorno = 1 rollback tran nEntidadFondo end