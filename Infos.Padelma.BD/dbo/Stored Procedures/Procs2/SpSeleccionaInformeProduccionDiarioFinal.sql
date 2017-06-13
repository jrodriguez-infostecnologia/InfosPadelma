CREATE proc [dbo].[SpSeleccionaInformeProduccionDiarioFinal]
@fecha date,
@empresa	int
as

declare @periodo varchar(50)= year(@fecha) +  rtrim(RIGHT('00' + rtrim(MONTH(@fecha)), 2)) 

select a.producto,c.descripcion desProducto, a.movimiento, d.descripcion desMovimiento,
		datename(WEEKDAY,a.fecha) diaSemana,DATEPART(DAY,a.fecha) Dia,
		DATENAME(MONTH,a.fecha) nombreMes, a.valor, c.orden ordenP,b.orden ordenM,DATEPART(WEEKDAY,a.fecha) NodiaSemana
		from vTransaccionesProduccion a
	join pProductoMovimiento b on b.movimiento=a.movimiento	and b.producto=a.producto and a.empresa=b.empresa and a.anulado=0
	join iItems d on d.codigo=a.movimiento and d.tipo='M' and d.empresa=a.empresa
	join iItems c on c.codigo=a.producto and c.tipo='P' and c.empresa=a.empresa
where a.fecha=@fecha
and a.mInforme=1 and a.empresa=@empresa
union

select a.producto,c.descripcion desProducto, a.movimiento,d.descripcion desMovimiento,
	'Total' diaSemana,32 Dia,DATENAME(MONTH,a.fecha) nombreMes,
	case when a.almacena=1  THEN ISNULL(dbo.fRetornaDatosProduccionPeriodo('M',a.producto,a.refMovimiento,@periodo,a.empresa, a.almacena),0) 
	else SUM(ISNULL(a.valor,0)) end valor,
	c.orden ordenP,b.orden ordenM,8 NodiaSemana
from vTransaccionesProduccion a
	join pProductoMovimiento b on b.movimiento=a.movimiento	and b.producto=a.producto and a.empresa=b.empresa
	join iItems d on d.codigo=a.movimiento and d.tipo='M' and d.empresa=a.empresa
	join iItems c on c.codigo=a.producto and c.tipo='P' and c.empresa=a.empresa
where 	YEAR(a.fecha) = year(@fecha) and MONTH(a.fecha)=month(@fecha)
	and b.mInforme=1 and a.empresa=a.empresa and a.anulado=0
group by c.descripcion,d.descripcion,a.movimiento,refMovimiento,c.orden,a.producto,b.orden,DATENAME(MONTH,fecha),DATEPART(YEAR,fecha),a.empresa, a.almacena