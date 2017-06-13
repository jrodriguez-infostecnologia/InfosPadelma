
CREATE PROCEDURE [dbo].[SpGetnContratos] AS 
select * from nContratos a join nFuncionario b on a.tercero=b.tercero
and a.empresa=b.empresa