CREATE PROCEDURE [dbo].[spSeleccionaProduccionAnualN]
	@periodo char(6),
	@empresa int
	
AS

declare @mes varchar(2)=substring(@periodo,5,len(@periodo)),@año varchar(4)=substring(@periodo,1,4)

	
	select c.descripcion producto, d.descripcion movimiento,'' Detalle,
	case when a.almacena= 1 THEN
	ISNULL(dbo.fRetornaDatosProduccionPeriodo('M',a.producto,a.refMovimiento,(@año+ rtrim(RIGHT('00' + DATEPART(MONTH,fecha), 2))) , a.empresa, a.almacena),0) 
	else SUM(ISNULL(a.valor,0)) end valor,
	c.orden OrdenP, b.orden OrdenM, DATENAME(MONTH,fecha) nombreMes,DATEPART(MONTH,fecha)noMes
	from vTransaccionesProduccion a
	join pProductoMovimiento b on b.movimiento=a.movimiento	and b.producto=a.producto and a.empresa=b.empresa
	join iItems d on d.codigo=a.movimiento and d.tipo='M' and d.empresa=a.empresa
	join iItems c on c.codigo=a.producto and c.tipo='P' and c.empresa=a.empresa
	where
	YEAR( a.fecha ) = @año   and MONTH(fecha)<=@mes 
		and b.mInforme=1 and a.empresa=@empresa
	group by c.orden, c.descripcion,d.descripcion,a.movimiento,a.producto,a.refMovimiento,a.almacena , b.orden,DATENAME(MONTH,fecha),DATEPART(MONTH,fecha), a.empresa
	union
	select c.descripcion producto, d.descripcion movimiento,'' Detalle,
	case when a.almacena=1 THEN
	ISNULL(dbo.fRetornaDatosProduccionPeriodo('A',a.producto,a.refMovimiento,@periodo, a.empresa,a.almacena),0) 
	else SUM(ISNULL(a.valor,0)) end valor,
	c.orden OrdenP, b.orden OrdenM, 'Total' nombreMes,13 noMes
	from vTransaccionesProduccion a
	join pProductoMovimiento b on b.movimiento=a.movimiento	and b.producto=a.producto and a.empresa=b.empresa
	join iItems d on d.codigo=a.movimiento and d.tipo='M' and d.empresa=a.empresa
	join iItems c on c.codigo=a.producto and c.tipo='P' and c.empresa=a.empresa
	where
	YEAR( a.fecha ) = @año	 and MONTH(fecha)<=@mes 
	and b.mInforme=1 and a.empresa=@empresa
	group by c.orden, c.descripcion,d.descripcion,a.movimiento,a.refMovimiento,a.producto,b.orden,YEAR(fecha), a.empresa,a.almacena