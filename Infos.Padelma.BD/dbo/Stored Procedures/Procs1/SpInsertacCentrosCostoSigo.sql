create PROCEDURE [dbo].[SpInsertacCentrosCostoSigo] @empresa int,@nivel int,@nivelMayor int,@activo bit,@auxiliar bit,@codigo varchar(50),@mayor varchar(50),@descripcion varchar(350), @Retorno int output  AS 
begin tran cCentrosCostoSigo insert cCentrosCostoSigo( empresa,nivel,nivelMayor,activo,auxiliar,codigo,mayor,descripcion) 
select @empresa,@nivel,@nivelMayor,@activo,@auxiliar,@codigo,@mayor,@descripcion
if (@@error = 0 ) begin set @Retorno = 0 commit tran cCentrosCostoSigo end else begin set @Retorno = 1 rollback tran cCentrosCostoSigo end