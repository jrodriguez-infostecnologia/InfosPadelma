﻿CREATE PROCEDURE SpDeletecxpProveedorCalseIR @empresa int,@tercero int,@clase int,@proveedor varchar(10),@Retorno int output  AS begin tran cxpProveedorCalseIR delete cxpProveedorCalseIR where clase = @clase and empresa = @empresa and proveedor = @proveedor and tercero = @tercero if (@@error = 0 ) begin set @Retorno = 0 commit tran cxpProveedorCalseIR end else begin set @Retorno = 1 rollback tran cxpProveedorCalseIR end