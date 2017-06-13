create PROCEDURE [dbo].[SpDeleteClienteClaseIR] @empresa int,@tercero int,
@cliente varchar(10),@Retorno int output  AS begin tran cxcClienteClaseIR delete cxcClienteClaseIR where empresa = @empresa 
and tercero = @tercero and cliente = @cliente 
 if (@@error = 0 ) begin set @Retorno = 0 commit tran cxcClienteClaseIR end else begin set @Retorno = 1 rollback tran cxcClienteClaseIR end