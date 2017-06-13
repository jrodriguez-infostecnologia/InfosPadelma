CREATE PROCEDURE [dbo].[SpInsertaaFinca] @fechaRegistro date,@empresa int,@proveedor int,@hectareas float,
@activo bit,@interna bit,@codigo varchar(50),@descripcion varchar(950),@zonaGeografica varchar(550),
@usuarioRegistro varchar(50),@ciudad char(5),@codigoEquivalencia varchar(50),@Retorno int output  AS begin tran aFinca 
insert aFinca( fechaRegistro,empresa,proveedor,hectareas,activo,interna,codigo,descripcion,zonaGeografica,usuarioRegistro,ciudad,codigoEquivalencia ) 
select @fechaRegistro,@empresa,@proveedor,@hectareas,@activo,@interna,@codigo,@descripcion,@zonaGeografica,@usuarioRegistro,@ciudad,@codigoEquivalencia
if (@@error = 0 ) begin set @Retorno = 0 commit tran aFinca end else begin set @Retorno = 1 rollback tran aFinca end


--exec spSysObtenerParametros 'SpInsertaaFinca',0