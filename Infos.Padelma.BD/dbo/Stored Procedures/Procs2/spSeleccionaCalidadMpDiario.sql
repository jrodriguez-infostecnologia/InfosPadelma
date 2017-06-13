CREATE PROCEDURE [dbo].[spSeleccionaCalidadMpDiario]
	@fecha	date,
	@empresa	int	
AS
/***************************************************************************
Nombre: spSeleccionaCalidadMpDiario
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnoligia SAS

Argumentos de entrada: Fecha de consulta
Argumentos de salida: 
Descripción: Selecciona la calidad de fruta en el informe diario
*****************************************************************************/

	select 'Día' as item,1 as orden,CONVERT( varchar(50),CONVERT( date,b.fechaProceso ) ) as fecha,
	a.analisis,c.descripcion nombre,AVG( a.valor ) as valor,
	( AVG( a.valor ) * SUM( b.pesoNeto ) ) as neto
	from lRegistroAnalisis a,bRegistroBascula b,lAnalisis c
	where
	a.tipo = b.tipo and
	a.numero = b.numero and
	a.analisis = c.codigo and
	a.tipo = 'EMP' and
	b.item = '1' and
	a.empresa=@empresa and 
	CONVERT( date,b.fechaProceso ) = @fecha
	group by CONVERT( varchar(50),CONVERT( date,b.fechaProceso ) ),a.analisis,c.descripcion
	
	union
	
	--select 'Semana' as item,2 as orden,CONVERT( varchar(50),DATEPART( WEEK,b.fechaProceso ) ) as item,
	--a.analisis,c.descripcion nombre,AVG( a.valor ) as valor,( AVG( a.valor ) * SUM( b.pesoNeto ) ) as neto
	--from lRegistroAnalisis a,bRegistroBascula b,lAnalisis c
	--where
	--a.tipo = b.tipo and
	--a.numero = b.numero and
	--a.analisis = c.codigo and
	--a.tipo = 'EMP' and
	--b.item = '1' and
	--a.empresa=@empresa and 	
	--DATEPART( WEEK,b.fechaProceso ) = DATEPART( WEEK,@fecha ) and
	--YEAR( b.fechaProceso ) = YEAR( @fecha )
	--group by CONVERT( varchar(50),DATEPART( WEEK,b.fechaProceso ) ),a.analisis,c.descripcion	
	
	--union
	
	select 'Mes' as item,3 as orden,CONVERT( varchar(50),MONTH( b.fechaProceso ) ) as item,
	a.analisis,c.descripcion nombre,AVG( a.valor ) as valor,( AVG( a.valor ) * SUM( b.pesoNeto ) ) as neto
	from lRegistroAnalisis a,bRegistroBascula b,lAnalisis c
	where
	a.tipo = b.tipo and
	a.numero = b.numero and
	a.analisis = c.codigo and
	a.tipo = 'EMP' and
	b.item = '1' and	
	a.empresa=@empresa and 
	MONTH( b.fechaProceso ) = MONTH( @fecha ) and
	YEAR( b.fechaProceso ) = YEAR( @fecha )	
	group by CONVERT( varchar(50),MONTH( b.fechaProceso ) ),a.analisis,c.descripcion		
	
	union
	
	select 'Año' as item,4 as orden,CONVERT( varchar(50),YEAR( b.fechaProceso ) ) as item,
	a.analisis,c.descripcion nombre,AVG( a.valor ) as valor,( AVG( a.valor ) * SUM( b.pesoNeto ) ) as neto
	from lRegistroAnalisis a,bRegistroBascula b,lAnalisis c
	where
	a.tipo = b.tipo and
	a.numero = b.numero and
	a.analisis = c.codigo and
	a.tipo = 'EMP' and
	b.item = '1' and	
	a.empresa=@empresa and 
	YEAR( b.fechaProceso ) = YEAR( @fecha )
	group by CONVERT( varchar(50),YEAR( b.fechaProceso ) ),a.analisis,c.descripcion	
	
	order by orden,c.descripcion