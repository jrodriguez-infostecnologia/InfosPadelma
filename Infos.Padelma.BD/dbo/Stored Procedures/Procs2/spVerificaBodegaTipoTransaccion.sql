

CREATE proc [dbo].[spVerificaBodegaTipoTransaccion]
@empresa int,
@bodega varchar(50),
@tipo varchar(50) ,
@retorno int output
as

	if exists(select * from iBodegaTipoTransaccion where bodega=@bodega and tipo=@tipo and empresa=@empresa)
			set @retorno=0
	else
			set @retorno=1