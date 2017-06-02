CREATE proc [dbo].[spVerificaChequeFormaPago] 
@empresa int,
@formaPago varchar(50),
@retorno int output
as

select @retorno = cheque from gFormaPago
where codigo =@formaPago and empresa=@empresa