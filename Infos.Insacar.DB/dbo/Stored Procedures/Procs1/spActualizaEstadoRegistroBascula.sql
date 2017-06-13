
create PROCEDURE [dbo].[spActualizaEstadoRegistroBascula]
	@tipoTransaccion	varchar(50),
	@remision			varchar(50),
	@sellos				varchar(250),
	@estado				char(2),
	@empresa			int,
	@retorno			int output
AS
/***************************************************************************
Nombre: spActualizaEstadoRegistroBascula
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Nro. de remisión, estado nuevo 
Argumentos de salida: 
Descripción: Actualiza el campo estado en el registro correspondiente de la 
			 tabla bRegistroBascula
*****************************************************************************/

	declare @error int

	set @error = 0

	begin tran Actualiza
		
		update bRegistroBascula
		set
		estado = @estado,
		sellos = @sellos,
		analisisRegistrado = 1
		where
		tipo = @tipoTransaccion and
		numero = @remision and
		estado = 'PP'
		and empresa=@empresa

		set @error = ( @error + @@error )
		
		update logProgramacionVehiculo
		set
		estado = @estado
		where
		despacho = @remision
		and empresa=@empresa
		
		set @error = ( @error + @@error )		

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