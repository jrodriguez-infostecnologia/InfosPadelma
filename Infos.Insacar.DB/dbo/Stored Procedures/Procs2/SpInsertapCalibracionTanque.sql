﻿CREATE PROCEDURE SpInsertapCalibracionTanque @empresa int,@altura int,@activo bit,@volumen decimal,@movimiento varchar(50),@tipo varchar(2),@Retorno int output  AS begin tran pCalibracionTanque insert pCalibracionTanque( empresa,altura,activo,volumen,movimiento,tipo ) select @empresa,@altura,@activo,@volumen,@movimiento,@tipo if (@@error = 0 ) begin set @Retorno = 0 commit tran pCalibracionTanque end else begin set @Retorno = 1 rollback tran pCalibracionTanque end