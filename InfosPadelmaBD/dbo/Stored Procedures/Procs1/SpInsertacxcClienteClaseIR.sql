﻿CREATE PROCEDURE SpInsertacxcClienteClaseIR @empresa int,@tercero int,@clase int,@cliente varchar(10),@concepto varchar(5),@Retorno int output  AS begin tran cxcClienteClaseIR insert cxcClienteClaseIR( empresa,tercero,clase,cliente,concepto ) select @empresa,@tercero,@clase,@cliente,@concepto if (@@error = 0 ) begin set @Retorno = 0 commit tran cxcClienteClaseIR end else begin set @Retorno = 1 rollback tran cxcClienteClaseIR end