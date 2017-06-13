CREATE proc [dbo].[spSeleccionaHojaVidaLoteLabores]
@empresa int,
@fi date,
@ff date
as

select codLabor,codLote, palmasBrutas, palmasProduccion, añoSiembra, hnetas, hbrutas , nombreLabor,nombreLote,año,dbo.fRetornaNombreMes(mes) nombreMes,mes noMes,sum(cantidadTercero) cantidad, uMedida from vTransaccionAgronomico
where codEmpresa=@empresa and fechaTransaccion between @fi and @ff
group by codLabor,codLote,nombreLabor,nombreLote, uMedida,año,mes,palmasBrutas, palmasProduccion,añoSiembra, hnetas, hbrutas