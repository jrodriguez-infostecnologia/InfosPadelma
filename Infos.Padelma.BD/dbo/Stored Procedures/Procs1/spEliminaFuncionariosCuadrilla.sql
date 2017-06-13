﻿create PROCEDURE [dbo].[spEliminaFuncionariosCuadrilla] @empresa int,@cuadrilla varchar(50),@Retorno int output  AS 
begin tran nCuadrillaFuncionario 
delete nCuadrillaFuncionario where empresa = @empresa and cuadrilla = @cuadrilla 
 if (@@error = 0 ) begin set @Retorno = 0 commit tran nCuadrillaFuncionario end else begin set @Retorno = 1 rollback tran nCuadrillaFuncionario end