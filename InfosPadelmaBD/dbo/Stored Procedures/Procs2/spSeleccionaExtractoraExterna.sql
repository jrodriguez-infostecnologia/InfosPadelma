create proc spSeleccionaExtractoraExterna
@empresa int
as


select * from cTercero
where  extractora=1 and activo=1 
and empresa=@empresa