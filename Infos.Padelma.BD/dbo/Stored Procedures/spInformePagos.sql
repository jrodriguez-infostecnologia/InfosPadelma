CREATE proc spInformePagos
@numero varchar(50),
@empresa int,
@periodo int,
@año int
as
select a.*, b.descripcion desformapago from vSeleccionaPagosNomina a join gFormaPago b on a.formaPago=b.codigo and a.empresa=b.empresa
where anulado=0 and numero = @numero and año=@año