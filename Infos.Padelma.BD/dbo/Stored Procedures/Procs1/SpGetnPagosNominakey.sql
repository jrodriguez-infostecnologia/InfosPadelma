﻿create PROCEDURE [dbo].[SpGetnPagosNominakey] @empresa int,@año int,@periodoNomina int,@mes nchar AS  select * from nPagosNomina where año = @año and empresa = @empresa and mes = @mes and periodoNomina = @periodoNomina