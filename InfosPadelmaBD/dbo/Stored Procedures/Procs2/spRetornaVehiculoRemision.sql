CREATE PROCEDURE [dbo].[spRetornaVehiculoRemision]
	@remision	varchar(50),
	@empresa int
AS
/***************************************************************************
Nombre: spRetornaVehiculoRemision
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Código de remisión
Argumentos de salida: 
Descripción: retorna los datos asignados a la remisión seleccionada en portería
*****************************************************************************/

	select a.codigoConductor,a.nombreConductor,a.vehiculo,a.remolque,a.fechaEntrada,
	a.tipo,a.remision, isnull(b.procedencia,'')+' / ' + isnull( c.descripcion,'' ) as finca,
	d.codigo, d.descripcion
	from bRegistroPorteria a 
	left join bRegistroBascula b on a.numero = b.remision and b.empresa=a.empresa
	left join aFinca c on b.finca=c.codigo and b.empresa=c.empresa
	left join iitems d on d.codigo=b.item and d.empresa=b.empresa
	where
	a.numero = @remision
	and a.empresa=@empresa