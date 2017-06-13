CREATE proc [dbo].[spSeleccionaInformePagosPeriodo]
@empresa int,
@año int,
@periodo int,
@numero varchar(50)
as
select distinct item, nombreBanco banco,nombreBanco,tercero,SUBSTRING(CONVERT(varchar, CONVERT(money, RTRIM(identificacion)), 1), 1, LEN(CONVERT(varchar, CONVERT(money, RTRIM(identificacion)), 1)) - 3) AS identificacion,nombreTercero,claseContrato,nombreCalseContrato, cuentaBancaria,
a.valorpago pago , 'No. ' + CONVERT(varchar(50),a.noPeriodo) + ' del ' +CONVERT(varchar(50),b.fechaInicial) + ' al ' + CONVERT(varchar(50),b.fechaFinal)   descripcionPeriodo 
from   vSeleccionaPagosNomina a join nPeriodoDetalle b on a.empresa=b.empresa 
and a.año=b.año and a.noPeriodo=b.noPeriodo and a.mes=b.mes and a.anulado=0
where  a.empresa=@empresa and a.noPeriodo=@periodo and a.año=@año and a.anulado=0 and numero like '%'+ @numero+ '%'
group by nombreBanco,nombreBanco,tercero, identificacion,nombreTercero,claseContrato,nombreCalseContrato, cuentaBancaria, a.valorPago,a.noPeriodo, fechaInicial, fechaFinal, item