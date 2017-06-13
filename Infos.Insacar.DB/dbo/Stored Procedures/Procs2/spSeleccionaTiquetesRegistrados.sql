create proc spSeleccionaTiquetesRegistrados
@empresa int,
@fi date,
@ff date
as
select * from  vSeleccionaTiqueteFruta
where anulado=0 and empresa=@empresa and fecha between @fi and @ff