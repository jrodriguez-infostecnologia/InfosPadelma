﻿CREATE PROCEDURE SpDeletelogProgramacionVehiculoEstado @empresa int,@registro varchar(50),@Retorno int output  AS begin tran logProgramacionVehiculoEstado delete logProgramacionVehiculoEstado where empresa = @empresa and registro = @registro if (@@error = 0 ) begin set @Retorno = 0 commit tran logProgramacionVehiculoEstado end else begin set @Retorno = 1 rollback tran logProgramacionVehiculoEstado end