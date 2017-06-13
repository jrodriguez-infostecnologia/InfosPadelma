
CREATE proc spSeleccionaParametrizacionNovedad
@codigo varchar(50) ,
@empresa int
as

select uMedida, ciclos,tarea, naturaleza, impuesto, equivalencia, concepto,grupoIR, manejaLote,manejaSaldo   from aNovedad
where codigo=@codigo and empresa=@empresa and activo=1