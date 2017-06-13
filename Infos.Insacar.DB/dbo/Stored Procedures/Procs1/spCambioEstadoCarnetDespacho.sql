
create PROCEDURE [dbo].[spCambioEstadoCarnetDespacho]
	@codigo		varchar(50),
	@estado		char(1),
	@empresa int,
	@retorno	int output
AS
/***************************************************************************
Nombre: spCambioEstadoCarnetDespacho
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Código carnet, estado
Argumentos de salida: 0 Si es exitoso
					  1 Si no es exitoso
Descripción: Selecciona los vehículos propios por código y tipo
*****************************************************************************/

	declare @error int
	
	set @error = 0

	begin tran Actualiza
	
		update logCarnetDespacho
		set
		estado = @estado
		where
		codigo = @codigo
		and empresa =@empresa		
		
	if( @error = 0 )
	begin
		commit tran Actualiza
		set @retorno = 0
	end		
	else
	begin
		rollback tran Actualiza
		set @retorno = 1
	end