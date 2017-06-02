CREATE proc [dbo].[spVerificaClienteClaseIR]
@empresa int,
@clase int,
@tercero int,
@cliente varchar(10),
@retorno int output
as

	if exists(select * from cxcClienteClaseIR where clase=@clase and cliente=@cliente and empresa=@empresa and tercero=@tercero)
			set @retorno=0
	else
			set @retorno=1