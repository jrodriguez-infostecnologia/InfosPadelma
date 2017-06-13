CREATE proc [dbo].[spSeleccionaLaboresTerceroFecha]
@fi date,
@ff date,
@empresa int,
@trabajador varchar(50)
as

select  * from vTransaccionAgronomico
where convert(date,fechaTransaccion) between @fi and @ff and codEmpresa=@empresa
and (codTercero like '%' + @trabajador + '%' or nombreTercero  like '%' + @trabajador + '%' )
and anulado=0 --and codLabor like '13%'