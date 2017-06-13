
create proc [dbo].[pSeleccionaRangosConcepto] 
@empresa int,
@concepto varchar(50)
as

select * from nConceptoRango
where concepto=@concepto and empresa=@empresa