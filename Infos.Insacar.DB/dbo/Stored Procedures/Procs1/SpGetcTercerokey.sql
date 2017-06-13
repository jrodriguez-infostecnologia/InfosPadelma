CREATE PROCEDURE [dbo].[SpGetcTercerokey] @id int, @empresa int
 AS  select * from cTercero where id = @id and empresa=@empresa