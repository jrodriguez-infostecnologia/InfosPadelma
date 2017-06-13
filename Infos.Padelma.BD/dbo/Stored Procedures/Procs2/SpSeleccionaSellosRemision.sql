CREATE  proc [dbo].[SpSeleccionaSellosRemision]
@empresa int,
@remision varchar(50)
as

select  a.Sello, a.anulado  from lRegistroSellos a  
where a.empresa=@empresa and a.numero=@remision