create PROCEDURE [dbo].[spEliminaParametrosSeguridadSocial] @empresa int,@tipo varchar(50),@Retorno int output  AS 
begin tran nCuadrillaFuncionario
 
 delete nParametroSeguridadSocial where empresa = @empresa and codigo = @tipo 
delete nParametroSeguridadSocialDetalle where empresa = @empresa and codigo = @tipo 
 if (@@error = 0 ) begin set @Retorno = 0 commit tran nCuadrillaFuncionario end 
 else begin set @Retorno = 1 rollback tran nCuadrillaFuncionario end