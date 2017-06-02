
CREATE PROCEDURE [dbo].[spCambiaEstadoRemisionesMp]
	@estadoAnterior	char(1),
	@estadoNuevo	char(1),
	@asignado		varchar(50),
	@empresa		int,
	@retorno		int output	
AS
/***************************************************************************
Nombre: spCambiaEstadoRemisionesMp
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Estado anterior, nuevo estado, usuario asignación
Argumentos de salida: 0 Si es exitoso,
					  1 Si no es exitoso
Descripción: Cambia de el estado de las remisiones asignadas al estado anterior
*****************************************************************************/

	begin tran Actualiza
	
		update bRemision
		set
		funcionarioAsignado = @asignado,
		estado = @estadoNuevo
		where
		estado = @estadoAnterior
		and empresa=@empresa
	
	if( @@ERROR = 0 )
	begin
		commit tran Actualiza
		set @retorno = 0
	end
	else
	begin 
		rollback tran Actualiza
		set @retorno = 1
	end