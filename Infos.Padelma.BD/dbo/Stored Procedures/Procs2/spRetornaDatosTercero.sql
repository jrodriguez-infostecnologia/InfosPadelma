CREATE proc [dbo].[spRetornaDatosTercero]
@tercero varchar(50),
@empresa int
as


select * from cTercero
where id=@tercero and empresa=@empresa