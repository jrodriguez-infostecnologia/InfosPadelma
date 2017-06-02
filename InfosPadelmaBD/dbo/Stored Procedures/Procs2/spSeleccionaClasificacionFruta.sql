CREATE PROCEDURE [dbo].[spSeleccionaClasificacionFruta]
	@fecha date,
	@empresa int
AS
/***************************************************************************
Nombre: spSeleccionaClasificacionFruta
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: fecha de consulta
Argumentos de salida: 
Descripción: Plantila Stored Procedures
*****************************************************************************/

	select orden,ano,item,intervalo,sum(contar) contar,SUM(pesoneto) as peso, desProveedor,procedencia, sum(promedio) promedio
	from vSeleccionaEntradasMp
	where
	ano = YEAR( @fecha ) and
	empresa=@empresa and 
	intervalo in ( CONVERT( varchar(50),@fecha ),CONVERT( varchar(50),YEAR( @fecha ) ),
	CONVERT( varchar(50),MONTH( @fecha ) ),CONVERT( varchar(50),DATENAME( WEEK,@fecha ) ) )
	group by orden,ano,item,intervalo, desProveedor,procedencia
	
	union
	
	select orden,ano,item,intervalo,sum(contar) contar, SUM(pesoneto) as peso, desProveedor, procedencia,sum( promedio) promedio
	from vSeleccionaEntradasMp
	where
	ano = YEAR( @fecha ) and	
	empresa=@empresa and 
	intervalo in ( CONVERT( varchar(50),@fecha ),CONVERT( varchar(50),YEAR( @fecha ) ),
	CONVERT( varchar(50),MONTH( @fecha ) ),CONVERT( varchar(50),DATENAME( WEEK,@fecha ) ) )
	group by orden,ano,item,intervalo, desProveedor,procedencia
	order by ano,item