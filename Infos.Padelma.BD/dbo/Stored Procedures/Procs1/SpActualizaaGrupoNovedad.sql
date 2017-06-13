CREATE PROCEDURE [dbo].[SpActualizaaGrupoNovedad] @empresa int,@activo bit,@codigo varchar(50),@descripcion varchar(50),@ccosto varchar(50),
@ccostoSiigo varchar(50),@manejaCcostoSiigo bit,@Retorno int output  AS begin tran aGrupoNovedad 
update aGrupoNovedad set activo = @activo,descripcion = @descripcion, ccosto=@ccosto,manejaCcostoSiigo=@manejaCcostoSiigo,ccostoSiigo=@ccostoSiigo
 where codigo = @codigo and empresa = @empresa
  if (@@error = 0 ) begin set @Retorno = 0 commit tran aGrupoNovedad end 
  else begin set @Retorno = 1 rollback tran aGrupoNovedad end