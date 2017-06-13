create PROCEDURE [dbo].[spEliminaConceptosFijosDetalle] @empresa int,
@centroCosto varchar(50),
@año int,@mes int,@periodo int,
@retorno int output  AS 
begin tran nCuadrillaFuncionario 
delete nConceptosFijosDetalle where centroCosto=@centroCosto and año=@año and mes=@mes and noPeriodo=@periodo and empresa=@empresa
 if (@@error = 0 ) begin set @Retorno = 0 commit tran nCuadrillaFuncionario end else begin set @Retorno = 1 rollback tran nCuadrillaFuncionario end