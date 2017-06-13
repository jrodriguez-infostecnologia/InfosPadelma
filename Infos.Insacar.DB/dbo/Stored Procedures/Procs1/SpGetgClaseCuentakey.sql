

create PROCEDURE [dbo].[SpGetgClaseCuentakey] @empresa int,@codigo varchar(50) as
select * from gClaseCuenta where codigo = @codigo and empresa = @empresa