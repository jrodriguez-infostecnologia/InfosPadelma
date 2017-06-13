CREATE PROCEDURE [dbo].[spSeleccionaClasificacionDespachos]
	@fecha date,
	@empresa int
AS
/***************************************************************************
Nombre: spSeleccionaClasificacionDespachos
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: fecha de consulta
Argumentos de salida: 
Descripción: Plantila Stored Procedures
*****************************************************************************/

	select orden,ano,item,intervalo,sum(contar) contar,SUM(pesoneto) as peso, desCliente,desProducto, sum(promedio) promedio,
	producto
	from vSeleccionaSalidasDPT
	where
	ano = YEAR( @fecha ) and
	empresa=@empresa and 
	intervalo in ( CONVERT( varchar(50),@fecha ),CONVERT( varchar(50),YEAR( @fecha ) ),
	CONVERT( varchar(50),MONTH( @fecha ) ),CONVERT( varchar(50),DATENAME( WEEK,@fecha ) ) )
	group by orden,ano,item,intervalo, desCliente,desProducto,producto
	
	union
	
	select orden,ano,item,intervalo,sum(contar) contar, SUM(pesoneto) as peso, desCliente,desProducto,sum( promedio) promedio,
	producto
	from vSeleccionaSalidasDPT
	where
	ano = YEAR( @fecha ) and	
	empresa=@empresa and 
	intervalo in ( CONVERT( varchar(50),@fecha ),CONVERT( varchar(50),YEAR( @fecha ) ),
	CONVERT( varchar(50),MONTH( @fecha ) ),CONVERT( varchar(50),DATENAME( WEEK,@fecha ) ) )
	group by orden,ano,item,intervalo, desCliente,desProducto, producto
	order by ano,item