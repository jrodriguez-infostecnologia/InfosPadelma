create PROCEDURE [dbo].[spVerificaProgramacionExistentes]
	@FI				date,
	@FF				date,
	@empresa		int,
	@turno			varchar(50),
	@cuadrilla		varchar(50),
	@retorno		int output
AS
/***************************************************************************
Nombre: spVerificaProgramacionExistentes
Tipo: Procedimiento Almacenado
Desarrollado: Alirio Noche Arzuza
Fecha: 26/11/2013
Argumentos de entrada: Fecha de programacion, usuario
Argumentos de salida: 0 Si no existe la programación
					  1 Si existe la programación 
Descripción: Retorna un valor que indica si la programación asignada aun id
			 existe.
*****************************************************************************/

	declare @conteo	numeric
				
	set @conteo = isnull((select COUNT(*)
	from nProgramacion
	where	fecha between @FI and @FF and
	turno=@turno and	cuadrilla= @cuadrilla and
	empresa=@empresa and (estado='P' or estado='S' or estado='E')),0) 
	
	if( @conteo > 0 )
	begin
		set @retorno = 1	
	end
	else
	begin
		set @retorno = 0 
	end