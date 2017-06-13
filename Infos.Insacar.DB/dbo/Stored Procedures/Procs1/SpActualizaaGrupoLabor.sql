CREATE PROCEDURE [dbo].[SpActualizaaGrupoLabor] @empresa int,@activo bit,@codigo varchar(50),@ccosto varchar(50),
@descripcion varchar(50),@Retorno int output  AS 
begin tran aGrupoLabor update aGrupoLabor set activo = @activo,descripcion = @descripcion, ccosto=@ccosto
where empresa = @empresa and codigo = @codigo if (@@error = 0 ) begin set @Retorno = 0 commit tran aGrupoLabor end else begin set @Retorno = 1 rollback tran aGrupoLabor end