﻿CREATE PROCEDURE SpGetcClaseIRkey @empresa int,@codigo int AS  select * from cClaseIR where codigo = @codigo and empresa = @empresa