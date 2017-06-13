

CREATE proc [dbo].spVerificaProductoTipoTransaccion
@empresa int,
@producto varchar(50),
@tipo varchar(50) ,
@retorno int output
as

	if exists(select * from gTipoTransaccionProducto where producto=@producto and tipo=@tipo and empresa=@empresa)
			set @retorno=0
	else
			set @retorno=1