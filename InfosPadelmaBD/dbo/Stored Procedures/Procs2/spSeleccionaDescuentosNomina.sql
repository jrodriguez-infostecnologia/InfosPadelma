CREATE proc [dbo].[spSeleccionaDescuentosNomina]
@empresa int,
@año int,
@periodo int,
@numero varchar(50)
as

declare @conceptoSalud varchar(50) = (select salud from nParametrosGeneral where empresa=@empresa)
declare @conceptoPension varchar(50) = (select pension from nParametrosGeneral where empresa=@empresa)

select *,valorTotal valorConcepto, case when codConcepto=@conceptoSalud then (select top 1 codigo + ' - '+  razonSocial from cTercero where empresa=@empresa and vSeleccionaLiquidacionDefinitiva.entidadEps=codigo) else
case when  codConcepto=@conceptoPension then (select top 1 codigo + ' - '+  razonSocial  from cTercero where empresa=@empresa and vSeleccionaLiquidacionDefinitiva.entidadPension=codigo) else null end end entidadDescuento

 from vSeleccionaLiquidacionDefinitiva
where empresa=@empresa and año=@año and noPeriodo=@periodo and anulado=0 and numero=@numero
--and codConcepto=1001 ----ojo con lo que haces, quita lo que colocas porque sino se daña las cosas