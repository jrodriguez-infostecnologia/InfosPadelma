
CREATE PROCEDURE [dbo].[spRetornaPapepeletaCatalogo]
@empresa int,
	@papeleta	varchar(50) output
AS
/***************************************************************************
Nombre: spRetornaPapepeletaCatalogo
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia

Argumentos de entrada: 
Argumentos de salida: Consecutivo papeleta inventario físico
Descripción: Retorna el consecutivo de la papeleta para realizar el inventario
			 físico.
*****************************************************************************/

	select @papeleta = right( '0000000' + isnull( ltrim( rtrim( MAX( papeleta )  + 1 ) ),1 ),7 )
	from iItems
	where empresa=@empresa