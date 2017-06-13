
create PROCEDURE [dbo].[spVerificaRemisionComercializadora]
	@numero		varchar(50),
	@empresa	int,
	@retorno	int output
AS
/***************************************************************************
Nombre: spVerificaRemisionComercializadora
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Número de remisión
Argumentos de salida: 0 Si lleva remisión comercializadora,
					  1 Si no lleva remisión comercializadora.
Descripción: Verifica si el despacho lleva remisión de la comercializadora.
*****************************************************************************/

	if( exists( select remisionComercializadora 	from logDespacho
		where 		numero = @numero and
		LTRIM( RTRIM( remisionComercializadora ) ) <> '' ) )
	begin
			set @retorno = 0
		end
	else
	begin
			set @retorno = 1
	
	end