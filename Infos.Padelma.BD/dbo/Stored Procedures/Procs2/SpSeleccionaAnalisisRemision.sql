CREATE proc [dbo].[SpSeleccionaAnalisisRemision]
@empresa int,
@remision varchar(50)
as

select a.analisis movimiento, b.descripcion, valor   from lRegistroAnalisis a join 
iitems b on a.analisis=b.codigo and a.empresa=b.empresa
where a.empresa=@empresa and a.numero=@remision