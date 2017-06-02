create proc [dbo].[spVerificaItemBodega]
@empresa int,
@bodega varchar(50),
@item varchar(50) ,
@retorno int output
as

	if exists(select * from iitemsBodega where bodega=@bodega and item=@item and empresa=@empresa)
			set @retorno=0
	else
			set @retorno=1