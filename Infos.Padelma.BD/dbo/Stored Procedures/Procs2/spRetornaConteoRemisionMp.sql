
CREATE PROCEDURE [dbo].[spRetornaConteoRemisionMp]
	@empresa int
AS
/***************************************************************************
Nombre: spRetornaConteoRemisionMp
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada:
Argumentos de salida: 
Descripción: Retorna el conteo de las remisiones por estado
*****************************************************************************/

	select estado,COUNT( estado ) as conteo
	from bRemision
	where empresa=@empresa
	group by estado