﻿create PROCEDURE [dbo].[SpGetnTurnoDepartamentokey] @empresa int,@turno varchar(50),@departamento varchar(50) AS  select * from nTurnoDepartamento where departamento = @departamento and empresa = @empresa and turno = @turno