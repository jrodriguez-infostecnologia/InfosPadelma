
CREATE proc spSeleccionaParametrizacionLotes
@codigo varchar(50) ,
@empresa int
as

select manejaSeccion,seccion,añoSiembra ,mesSiembra, hBrutas, hProduccion, variedad, NoLineas from aLotes
where codigo=@codigo and empresa=@empresa and activo=1