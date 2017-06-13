CREATE proc [dbo].[spSeleccionaPagoCheques]
@periodo int,
@año int,
@numero varchar(50),
@empresa int
as

select  REPLACE(CONVERT(varchar(10),  fecha,121), '-',' ') fechaFormato , 
'$'+ CONVERT(VARCHAR,CAST(valorPago AS MONEY),1) + REPLICATE('*', 13 - len( CONVERT(varchar(max), CAST(valorPago AS MONEY) ))) valorFormato , 
UPPER(nombreTercero) + REPLICATE('*', 70 - len(nombreTercero))  terceroFormato, 
case when len (dbo.f_numeroletras_Pago(valorPago)) <=67  then dbo.f_numeroletras_Pago(valorPago) + REPLICATE('*', 67 - len(dbo.f_numeroletras_Pago(valorPago)))
else SUBSTRING( dbo.f_numeroletras_Pago(valorPago) , 1,67)  end  letrasFormatol1 ,
case when len (dbo.f_numeroletras_Pago(valorPago)) >=67  then SUBSTRING( dbo.f_numeroletras_Pago(valorPago) , 68,len(dbo.f_numeroletras_Pago(valorPago))) + REPLICATE('*', 20 - len(SUBSTRING( dbo.f_numeroletras_Pago(valorPago) , 68,len(dbo.f_numeroletras_Pago(valorPago))))) end 
  letrasFormatol2,
convert(varchar(50), tercero) tercero  from [dbo].[vSeleccionaPagosNomina]
where empresa=@empresa and noPeriodo=@periodo and numero=@numero
and noCheque<>'' and noCheque>0
and año=@año and anulado=0
order by noCheque