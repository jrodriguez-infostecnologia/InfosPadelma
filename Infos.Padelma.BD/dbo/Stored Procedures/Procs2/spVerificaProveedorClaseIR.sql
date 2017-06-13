CREATE proc [dbo].[spVerificaProveedorClaseIR]
@empresa int,
@clase int,
@tercero int,
@proveedor varchar(10),
@retorno int output
as

	if exists(select * from cxpProveedorCalseIR where clase=@clase and proveedor=@proveedor and empresa=@empresa and tercero=@tercero)
			set @retorno=0
	else
			set @retorno=1