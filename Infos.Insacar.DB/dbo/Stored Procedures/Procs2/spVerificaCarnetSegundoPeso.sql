
CREATE PROCEDURE [dbo].[spVerificaCarnetSegundoPeso]
	@codigo		varchar(50),
	@empresa int,
	@retorno	int output
AS
/***************************************************************************
Nombre: spVerificaCarnetSegundoPeso
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Código remisión
Argumentos de salida: 0 Si la remisión es válida,
					  1 Si la remisión no es válida
Descripción: Valida si el carnet seleccionado se puede usar en el primer
			 peso de materia prima.
*****************************************************************************/

	declare @conteo		int

	select @conteo = COUNT(*)
	from bRegistroBascula 
	where
	remision = @codigo and
	estado = 'AR' and
	empresa=@empresa and
	analisisRegistrado = 1 
	-- or 	  vehiculo in ( select codigo from bVehiculo ) 
		    
					
	if( @conteo = 0 )
	begin
		set @retorno = 1
	end					
	else
	begin
		set @retorno = 0
	end