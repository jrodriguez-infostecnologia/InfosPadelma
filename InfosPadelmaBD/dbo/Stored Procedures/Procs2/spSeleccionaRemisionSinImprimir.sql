CREATE PROCEDURE [dbo].[spSeleccionaRemisionSinImprimir]	
	@empresa int 
AS
/***************************************************************************
Nombre: spSeleccionaRemisionSinImprimir
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS


Argumentos de entrada: Planta Extractora 
Argumentos de salida: 
Descripción: Selecciona las remisiones sin imprimir
*****************************************************************************/

select distinct  c.tiquete  numero ,c.vehiculo,c.pesoNeto,
	c.vehiculo + ' - ' + c.tiquete + ' - ' + d.descripcionAbreviada as cadena,c.estado,c.pesoNeto
	from  bRegistroBascula c 
	join iItems d on d.codigo=c.item and d.empresa=c.empresa
	join logProgramacionVehiculo b on b.numero=c.remision and c.empresa=c.empresa
	join gParametrosGenerales e on e.empresa=c.empresa
	where
	( c.pesoNeto > 0 and  c.pesoNeto is not null ) 
	and b.estado in ('SP','AR')  	
	and c.tipo not in (e.anulado) 
	--and b.despacho is null
	and c.empresa=@empresa 
	--and c.numero='DPT000000001456' 
	order by c.vehiculo