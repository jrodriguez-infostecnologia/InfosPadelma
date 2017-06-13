CREATE PROCEDURE [dbo].[spSeleccionaProduccionDiario]
	@fecha		date,
	@empresa	int
AS
/***************************************************************************
Nombre: spSeleccionaProduccionDiario
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Fecha de consulta
Argumentos de salida: 
Descripción: Selecciona el informe de producción diario.
*****************************************************************************/

declare @mes varchar(2)=month(@fecha),@año varchar(4)=year(@fecha)
declare @periodo varchar(6)=@año+rtrim(RIGHT('00' + DATEPART(MONTH,@fecha), 2))


create table #produccionDiara (
 fila int, 
item varchar(10),
producto varchar(300),
descripcion varchar(400),
valor float,
OrdenP int,
OrdenM int)

	

	insert #produccionDiara
	select 1 as fila,'Día' as item,c.descripcion producto, d.descripcion,
	case when a.refMovimiento in ('EX','INI','IF','INISLL','INISV','IFSLL','IFSV','PPV','CPTHP','CPTHE') THEN
	ISNULL(dbo.fRetornaDatosProduccionInforme('D',a.refProducto,a.refMovimiento,a.fecha,a.empresa),0) 
	else ISNULL(a.valor,0) end valor,
	0 OrdenP, b.orden OrdenM	
	from vTransaccionesProduccion a
	join pProductoMovimiento b on b.movimiento=a.movimiento	and b.producto=a.producto and a.empresa=b.empresa
	join iItems d on d.codigo=a.movimiento and d.tipo='M' and d.empresa=a.empresa
	join iItems c on c.codigo=a.producto and c.tipo='P' and c.empresa=a.empresa
	where
	CONVERT(date,a.fecha ) = @fecha and a.empresa=@empresa
	and a.refMovimiento not in ('CPTHP','CPTHE','HE','HP','HPA')
	
	union
	select 2 as fila,'Semana' as item,c.descripcion producto, d.descripcion,
	ISNULL(dbo.fRetornaDatosProduccionInforme('S',a.refproducto,a.refmovimiento,a.fecha, a.empresa),0) valor,
	0 OrdenP, b.orden OrdenM		
	from vTransaccionesProduccion a
	join pProductoMovimiento b on b.movimiento=a.movimiento	and b.producto=a.producto and a.empresa=b.empresa
	join iItems d on d.codigo=a.movimiento and d.tipo='M' and d.empresa=a.empresa
	join iItems c on c.codigo=a.producto and c.tipo='P' and c.empresa=a.empresa
	where
	CONVERT( date,a.fecha ) = @fecha 
	and a.refMovimiento not in ('CPTHP','CPTHE','HE','HP','HPA')
	
	union
	
	select 3 as fila,'Mes' as item,c.descripcion producto, d.descripcion,
	case when a.refMovimiento in ('EX','INI','IF','INISLL','INISV','IFSLL','IFSV','PPV','CPTHP','CPTHE','VLL','SEC','NR','PPB') 
	OR a.almacena=1 THEN
	ISNULL(dbo.fRetornaDatosProduccionPeriodo('M',a.refproducto,a.refmovimiento,@periodo, a.empresa),0) 
	else SUM(ISNULL(a.valor,0)) end valor,
	0 OrdenP, b.orden OrdenM		
	from vTransaccionesProduccion a
	join pProductoMovimiento b on b.movimiento=a.movimiento	and b.producto=a.producto and a.empresa=b.empresa
	join iItems d on d.codigo=a.movimiento and d.tipo='M' and d.empresa=a.empresa
	join iItems c on c.codigo=a.producto and c.tipo='P' and c.empresa=a.empresa
	where
	MONTH( fecha )= MONTH( @fecha ) and
	YEAR( a.fecha ) = YEAR( @fecha )
	and a.refMovimiento not in ('CPTHP','CPTHE','HE','HP','HPA')
	group by c.descripcion,d.descripcion,a.movimiento,a.producto,a.almacena,a.empresa,a.refMovimiento,a.refProducto,b.orden,DATENAME(MONTH,fecha),DATEPART(MONTH,fecha)
		
	union
	
	select 4 as fila,'Año' as item,c.descripcion producto, d.descripcion,
	case when a.refMovimiento in ('EX','INI','IF','INISLL','INISV','IFSLL','IFSV','PPV','CPTHP','CPTHE','VLL','SEC','NR','PPB','PN','IH') 
	OR a.almacena=1 THEN
	ISNULL(dbo.fRetornaDatosProduccionPeriodo('A',a.refProducto,a.refMovimiento,@periodo, a.empresa),0) 
	else SUM(ISNULL(a.valor,0)) end valor,
	0 OrdenP, b.orden OrdenM		
	from vTransaccionesProduccion a
	join pProductoMovimiento b on b.movimiento=a.movimiento	and b.producto=a.producto and a.empresa=b.empresa
	join iItems d on d.codigo=a.movimiento and d.tipo='M' and d.empresa=a.empresa
	join iItems c on c.codigo=a.producto and c.tipo='P' and c.empresa=a.empresa
	where
		YEAR( a.fecha ) = YEAR( @fecha )
		and a.refMovimiento not in ('CPTHP','CPTHE','HE','HP','HPA')
	group by c.descripcion,d.descripcion,a.almacena,a.movimiento,a.producto,b.orden,YEAR(fecha),a.empresa,a.empresa,a.refMovimiento,a.refProducto
	
	select * from #produccionDiara
	order by fila,OrdenP,producto,OrdenM
	
	drop table #produccionDiara