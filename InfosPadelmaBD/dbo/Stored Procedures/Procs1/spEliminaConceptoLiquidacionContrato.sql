create proc [dbo].[spEliminaConceptoLiquidacionContrato]
@empresa int,
@tercero int,
@concepto varchar(50),
@Retorno int output
 AS begin tran aLotes

		delete	 from tmpliquidacionNomina 
		where empresa=@empresa and concepto=@concepto and tercero=@tercero 

		if (@@error = 0 ) begin set @Retorno = 0 commit tran aLotes end else begin set @Retorno = 1 rollback tran aLotes end