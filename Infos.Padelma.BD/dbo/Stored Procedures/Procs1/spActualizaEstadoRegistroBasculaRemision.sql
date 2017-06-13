create PROCEDURE [dbo].[spActualizaEstadoRegistroBasculaRemision]
	@tipoTransaccion	varchar(50),
	@numero 			varchar(50),
	@estado				char(2),
	@empresa			int,
	@sellos				varchar(2250),
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

	declare @error int,@registroanalisis bit=0


	if @estado='AR'
		set @registroanalisis=1

	set @error = 0



	begin tran Actualiza
		
	
		
		update bRegistroBascula
		set
		estado = @estado,
		sellos=@sellos,
		analisisRegistrado=@registroanalisis
		where
		numero = @numero
		and empresa=@empresa
		
		set @error = ( @error + @@error )		

		
		update logProgramacionVehiculo
		set
		estado = @estado
		where
		despacho = @numero
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