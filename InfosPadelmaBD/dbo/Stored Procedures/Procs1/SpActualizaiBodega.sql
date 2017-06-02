﻿CREATE PROCEDURE SpActualizaiBodega @empresa int,@proveedor int,@activo bit,@validaCcosto bit,@validaProveedor bit,@validaCuenta bit,@produccion bit,@mExistencia bit,@codigo varchar(5),@descripcion varchar(550),@desCorta varchar(50),@cCosto varchar(50),@Cuenta varchar(16),@Retorno int output  AS begin tran iBodega update iBodega set proveedor = @proveedor,activo = @activo,validaCcosto = @validaCcosto,validaProveedor = @validaProveedor,validaCuenta = @validaCuenta,produccion = @produccion,mExistencia = @mExistencia,descripcion = @descripcion,desCorta = @desCorta,cCosto = @cCosto,Cuenta = @Cuenta where codigo = @codigo and empresa = @empresa if (@@error = 0 ) begin set @Retorno = 0 commit tran iBodega end else begin set @Retorno = 1 rollback tran iBodega end