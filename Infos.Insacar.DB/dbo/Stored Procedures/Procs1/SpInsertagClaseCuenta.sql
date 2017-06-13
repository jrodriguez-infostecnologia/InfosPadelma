create PROCEDURE [dbo].[SpInsertagClaseCuenta] @empresa int,@codigo varchar(50),@descripcion varchar(350), @Retorno int output  AS 
begin tran gClaseCuenta insert gClaseCuenta( empresa,codigo,descripcion) 
select @empresa,@codigo,@descripcion
if (@@error = 0 ) begin set @Retorno = 0 commit tran gClaseCuenta end else begin set @Retorno = 1 rollback tran gClaseCuenta end