CREATE PROCEDURE [dbo].[SpGetnDiasHabilesCc] AS
select a.*, b.codigo codCcosto, b.descripcion desCcosto from nDiasHabilesCc a join cCentrosCosto b on 
a.ccosto  = b.codigo and a.empresa=b.empresa