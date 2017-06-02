CREATE PROCEDURE [dbo].[spActualizaBasculaPes]
	@tipo		varchar(50),
	@numero		varchar(50),
	@pesoBruto	float,
	@pesoNeto	float,
	@tiquete	varchar(50),
	@empresa	int,
	@retorno	int output
AS
/***************************************************************************
Nombre: spActualizaBasculaPes
Tipo: Procedimiento Almacenado
INFOS TECNOLOGIA S.A.S
Argumentos de entrada: Tipo de transacción, número de transacción, tara, neto,
					   tiquete
Argumentos de salida: 
Descripción: Actualiza el segundo pesaje de pesajes
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
		tiquete = @tiquete
		where
		tipo = @tipo and
		numero = @numero and
		empresa=@empresa

		

		exec spInsertaDespacho @numero, @tipo,@empresa,@retorno
			  
		
			
		set @error = @@ERROR		
		
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