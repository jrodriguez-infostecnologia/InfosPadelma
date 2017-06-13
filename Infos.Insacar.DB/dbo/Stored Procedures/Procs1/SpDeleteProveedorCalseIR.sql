create PROCEDURE [dbo].[SpDeleteProveedorCalseIR] @empresa int,
@tercero int,
@proveedor varchar(10),
@Retorno int output  AS begin tran cxpProveedorCalseIR delete cxpProveedorCalseIR where empresa = @empresa and tercero = @tercero and proveedor = @proveedor 
if (@@error = 0 ) begin set @Retorno = 0 commit tran cxpProveedorCalseIR end else begin set @Retorno = 1 rollback tran cxpProveedorCalseIR end