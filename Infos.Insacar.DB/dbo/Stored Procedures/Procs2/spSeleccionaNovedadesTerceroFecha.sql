CREATE proc [dbo].[spSeleccionaNovedadesTerceroFecha]
@empresa int,
@fi date,
@ff date
as

select *,convert(int,substring(numero,4,len(numero))) numeroTransaccion,
 case when liquidada=1 then 'X' else '' end liqui,
 case when registroAnulado=1 then 'X' else '' end Anul
  from vSeleccionaRegistroNovadesNomina
where empresa=@empresa and convert(date,fecha) between @fi and @ff
order by numero