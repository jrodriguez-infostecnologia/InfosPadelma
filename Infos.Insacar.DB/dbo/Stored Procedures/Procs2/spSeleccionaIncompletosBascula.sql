CREATE PROCEDURE [dbo].[spSeleccionaIncompletosBascula]
@empresa int
AS
/***************************************************************************
Nombre: spSeleccionaIncompletosBascula
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: 
Argumentos de salida: 
Descripción: Selecciona los registros incompletos en báscula
*****************************************************************************/

	select numero,b.descripcion + ' - ' + numero + ' - ' + 
	CONVERT( varchar(50),fecha,103 ) + ' - ' +
	case pesoBruto	when 0 then '' else CONVERT( varchar(50),pesoBruto )
	end	+ 	case pesoTara	when 0 then ''	else CONVERT( varchar(50),pesoTara )
	end	+ ' Kg' + ' - ' + vehiculo + ' - ' + remolque as cadena
	from bRegistroBascula a
	join iItems b on b.codigo=a.item and b.empresa=a.empresa
	where	tiquete = '' and	
	a.tipo <> 'ANULADO' and a.empresa=@empresa
	order by fecha,a.tipo,a.item,numero