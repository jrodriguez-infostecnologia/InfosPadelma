CREATE proc [dbo].[spVelidaRegistroProductoFecha]
@producto int,
@empresa int,
@fecha date,
@retorno int output
as


if exists(select * from pTransaccion where producto=@producto and fecha=@fecha and empresa=@empresa and anulado=0)
	set @retorno=1
else
	set @retorno=0