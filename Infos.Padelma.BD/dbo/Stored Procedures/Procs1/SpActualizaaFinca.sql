CREATE PROCEDURE [dbo].[SpActualizaaFinca] @fechaRegistro date,@empresa int,@proveedor int,@hectareas float,@codigoEquivalencia varchar(50),
@activo bit,@interna bit,@codigo varchar(50),@descripcion varchar(950),@zonaGeografica varchar(550),@usuarioRegistro varchar(50),
@ciudad char(5),@Retorno int output  AS begin tran aFinca update aFinca set fechaRegistro = @fechaRegistro,proveedor = @proveedor,
hectareas = @hectareas,activo = @activo,interna = @interna,descripcion = @descripcion,zonaGeografica = @zonaGeografica,codigoEquivalencia=@codigoEquivalencia,
usuarioRegistro = @usuarioRegistro,ciudad = @ciudad where codigo = @codigo and empresa = @empresa 
if (@@error = 0 ) begin set @Retorno = 0 commit tran aFinca end else begin set @Retorno = 1 rollback tran aFinca end