CREATE proc [dbo].[spSeleccionaConceptosNoParametrizadosCon]
 @empresa int
 as
 
select codigo, descripcion from nConcepto
where empresa= @empresa  and codigo not in(
select distinct concepto from cParametroContaNomi
where empresa=@empresa
)
and codigo not in (select concepto from aNovedad where empresa=@empresa)
union
select codigo, descripcion from aNovedad
where empresa= @empresa  and 'L'+codigo not in(
select distinct concepto from cParametroContaNomi
where empresa=@empresa
)