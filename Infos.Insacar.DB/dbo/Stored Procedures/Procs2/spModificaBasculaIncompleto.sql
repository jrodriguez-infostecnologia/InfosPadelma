create PROCEDURE [dbo].[spModificaBasculaIncompleto]
	@numero			varchar(50),
	@fechaProceso	datetime,
	@pesoBruto		float,
	@pesoTara		float,
	@vehiculo		varchar(50),
	@remolque		varchar(50),
	@producto		varchar(50),
	@procedencia	varchar(50),
	@finca			varchar(50),
	@racimos		int,
	@sacos			int,
	@pesoSacos		float,
	@sellos			varchar(250),
	@descargador	varchar(50),
	@pesoDescuento	int,
	@bodega			varchar(50),
	@empresa		int,
	@retorno		int output
AS
/***************************************************************************
Nombre: spModificaBasculaIncompleto
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Número de tiquete, tipo tiquete
Argumentos de salida: 0 Si es exitoso,
					  1 Si es exitoso.
Descripción: Realiza la modificación del registro de báscula seleccionado.
*****************************************************************************/

	declare @error		int,
			@tipo		varchar(50)
	
	set @error = 0

	select @tipo = tipo
	from bRegistroBascula
	where	numero = @numero and empresa=@empresa
	
	begin tran Actualiza		
				
		update bRegistroBascula
		set
		fechaProceso = @fechaProceso,
		pesoBruto = @pesoBruto,
		pesoTara = @pesoTara,
		pesoDescuento=@pesoDescuento,
		pesoNeto = ( @pesoBruto - @pesoTara ),
		vehiculo = @vehiculo,
		remolque = @remolque,
		item = @producto,
		procedencia = @procedencia,
		finca = @finca,
		racimos = @racimos,
		sacos = @sacos,
		pesoSacos = @pesoSacos,
		bodega=@bodega,
		tipoDescargue=@descargador,
		sellos = @sellos
		where
		tipo = @tipo and
		numero = @numero and empresa=@empresa
		
		set @error = ( @error + @@ERROR )		
		
	if( @error = 0 )
	begin
		set @retorno = 0
		commit tran Actualiza
	end		
	else
	begin
		set @retorno = 1
		rollback tran Actualiza
	end