


create PROCEDURE [dbo].[SpGetgDepartamentokey] @empresa int,@codigo varchar(50) AS  select * from gDepartamento where codigo = @codigo and empresa = @empresa