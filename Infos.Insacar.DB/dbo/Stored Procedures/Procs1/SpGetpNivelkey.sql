create PROCEDURE [dbo].[SpGetpNivelkey] @codigo int, @empresa int AS  select * from pNivel where codigo = @codigo
																		and empresa=@empresa