﻿create PROCEDURE [dbo].[SpGetnPlanoBancoDetallekey] @empresa int,@registro int,@banco varchar(50) AS  select * from nPlanoBancoDetalle where banco = @banco and empresa = @empresa and registro = @registro