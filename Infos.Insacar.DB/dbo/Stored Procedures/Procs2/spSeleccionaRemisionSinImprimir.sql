
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

	select distinct  a.numero ,b.vehiculo,c.pesoNeto,
	b.vehiculo + ' - ' + c.tiquete + ' - ' + d.descripcionAbreviada as cadena,c.estado,c.pesoNeto,e.numero
	from lRegistroAnalisis a
	join logProgramacionVehiculo b on b.despacho=a.numero and b.empresa=a.empresa
	join bRegistroBascula c on a.numero=c.numero and a.empresa=c.empresa
	join iItems d on d.codigo=b.producto and d.empresa=b.empresa
	left join logDespacho e on e.numero=c.numero and e.tipo=c.tipo and e.empresa=c.empresa
	where
	( c.pesoNeto > 0 and  c.pesoNeto is not null ) 
	and b.estado in ('SP','AR')  	
	and c.tipo not in ('ANULADO') 
	and a.empresa=@empresa 
	and e.numero is null
	--ANd c.numero='DPT000000001195'
	order by b.vehiculo