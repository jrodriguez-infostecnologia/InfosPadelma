
CREATE PROCEDURE [dbo].[spModificaTiquete]
	@tiquete		varchar(50),
	@fechaProceso	datetime,
	@pesoBruto		float,
	@pesoTara		float,
	@pesoDes		float,	
	@vehiculo		varchar(50),
	@remolque		varchar(50),
	@producto		varchar(50),
	@procedencia	varchar(50),
	@finca			varchar(50),
	@racimos		int,
	@sacos			int,
	@pesoSacos		float,
	@sellos			varchar(250),
	@bodega			varchar(250),
	@empresa int,
	@cooperativa			varchar(250),
	@retorno		int output
AS
/***************************************************************************
Nombre: spModificaTiquete
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Número de tiquete, tipo tiquete
Argumentos de salida: 0 Si es exitoso,
					  1 Si es exitoso.
Descripción: Realiza la modificación y anulación del tiquete de báscula seleccionado.
*****************************************************************************/

	declare @error		int,
			@tipo		varchar(50),
			@numero		varchar(50)
	
	set @error = 0

	select @tipo = tipo,@numero = numero
	from bRegistroBascula
	where
	tiquete = @tiquete
	
	begin tran Actualiza		
				
		update bRegistroBascula
		set
		fechaProceso = @fechaProceso,
		pesoBruto = @pesoBruto,
		pesoTara = @pesoTara,
		pesoDescuento=@pesoDes,
		pesoNeto = ( @pesoBruto - @pesoTara ),
		vehiculo = @vehiculo,
		remolque = @remolque,
		item = @producto,
		procedencia = @procedencia,
		finca = @finca,
		racimos = @racimos,
		sacos = @sacos,
		pesoSacos = @pesoSacos,
		sellos = @sellos,
		bodega=@bodega,
		tipoDescargue=@cooperativa
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