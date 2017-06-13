
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
	a.tipo,a.remision, isnull( b.finca,'' ) as finca
	from bRegistroPorteria a 
	left join bRegistroBascula b on a.numero = b.remision and b.empresa=a.empresa
	where
	a.numero = @remision
	and a.empresa=@empresa