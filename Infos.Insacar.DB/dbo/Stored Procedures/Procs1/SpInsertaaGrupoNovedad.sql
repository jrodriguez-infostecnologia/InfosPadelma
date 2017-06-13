CREATE PROCEDURE [dbo].[SpInsertaaGrupoNovedad] @empresa int,@activo bit,@codigo varchar(50),@descripcion varchar(50),@ccosto varchar(50),
@ccostoSiigo varchar(50),@manejaCcostoSiigo bit,@Retorno int output  AS begin tran aGrupoNovedad 
insert aGrupoNovedad( empresa,activo,codigo,descripcion,ccosto, manejaCcostoSiigo,ccostoSiigo ) 
select @empresa,@activo,@codigo,@descripcion,@ccosto,@manejaCcostoSiigo,@ccostoSiigo
if (@@error = 0 ) begin set @Retorno = 0 commit tran aGrupoNovedad end 
else begin set @Retorno = 1 rollback tran aGrupoNovedad end