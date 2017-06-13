CREATE proc [dbo].[spRetornaDetalleSNominaLog]
@empresa int,
@id int
as

select * from sLogNominaDetalle
where empresa=@empresa and id=@id