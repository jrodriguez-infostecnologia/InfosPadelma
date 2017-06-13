CREATE PROCEDURE [dbo].[SpActualizacCentrosCostoSigo] @empresa int,@nivel int,@nivelMayor int,@activo bit,
@auxiliar bit,@codigo varchar(50),@mayor varchar(50),@descripcion varchar(350),
@Retorno int output  AS begin tran cCentrosCostoSigo 

if  len(rtrim(ltrim(@mayor)))=0
begin
set @mayor = null
end

update cCentrosCostoSigo set nivel = @nivel,nivelMayor = @nivelMayor,activo = @activo,
auxiliar = @auxiliar,descripcion = @descripcion
 where codigo = @codigo and empresa = @empresa and (mayor=@mayor or mayor is null)
 if (@@error = 0 ) begin set @Retorno = 0 commit tran cCentrosCostoSigo end else begin set @Retorno = 1 rollback tran cCentrosCostoSigo end