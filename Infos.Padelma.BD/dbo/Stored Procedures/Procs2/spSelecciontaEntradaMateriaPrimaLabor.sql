CREATE proc spSelecciontaEntradaMateriaPrimaLabor
@empresa int,
@tiquete varchar(50)
as

select * from bRegistroBascula
where empresa=@empresa
and item='FRU' and tipo='EMP'
and tiquete like '%' + @tiquete + '%'