
create PROCEDURE [dbo].[spActualizaBasculaDes]
	@tipo		varchar(50),
	@numero		varchar(50),
	@pesoBruto	float,
	@empresa int,
	@pesoNeto	float,
	@tiquete	varchar(50),
	@nroSacos	int,
	@retorno	int output
AS
/***************************************************************************
Nombre: spActualizaBasculaDes
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Tipo de transacción, número de transacción, tara, neto,
					   tiquete, número de sacos
Argumentos de salida: 
Descripción: Actualiza el segundo pesaje de materia prima
*****************************************************************************/

	declare @fecha datetime,
			@error	int
						
	set @error = 0
	set @fecha = GETDATE()

	begin tran Actualiza
	
		update bRegistroBascula
		set
		pesoBruto = @pesoBruto,
		pesoNeto = @pesoNeto,
		fechaBruto = @fecha,
		fechaNeto = @fecha,
		estado = 'SP',
		tiquete = @tiquete,
		sacos = @nroSacos,
		fechaProceso = @fecha
		where
		tipo = tipo and
		numero = @numero
		and empresa=@empresa
		
		set @error = ( @@ERROR + @error )
		
		update logProgramacionVehiculo
		set
		estado = 'SP'
		where
		despacho = @numero	
		and empresa=@empresa	
		
		set @error = ( @@ERROR + @error )		
		
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