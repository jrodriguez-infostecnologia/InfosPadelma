
CREATE PROCEDURE [dbo].[SpDeletenConceptoRangoTodo] 
@empresa int,@concepto varchar(50),@Retorno int output  
AS begin tran nConceptoRango 
delete nConceptoRango where empresa = @empresa and concepto = @concepto 
 if (@@error = 0 ) begin set @Retorno = 0 commit tran nConceptoRango end else begin set @Retorno = 1 rollback tran nConceptoRango end