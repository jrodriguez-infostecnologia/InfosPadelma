create proc [dbo].[SpSeleccionaAnalisistransaccion]
@empresa int,
@tipo varchar(50),
@numero varchar(50)
as
select  analisis,b.descripcion,a.valor from lRegistroAnalisis a
join iItems b on b.codigo=a.analisis and a.empresa=b.empresa
where a.numero=@numero and a.tipo =@tipo and a.empresa=@empresa