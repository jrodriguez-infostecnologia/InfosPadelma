CREATE PROCEDURE [dbo].[SpGetnProrroga] AS select * from nProrroga a join
nFuncionario b on a.tercero=b.tercero and a.empresa=b.empresa