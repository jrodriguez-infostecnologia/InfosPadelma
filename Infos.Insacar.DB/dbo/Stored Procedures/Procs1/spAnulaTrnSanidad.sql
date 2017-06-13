CREATE PROCEDURE [dbo].[spAnulaTrnSanidad]
	@tipo		varchar(50),
	@numero		varchar(50),
	@usuario	varchar(50),
	@empresa	int,
	@retorno	int output
AS
/***************************************************************************
Nombre: spAnulaTrnAlmacen
Tipo: Procedimiento Almacenado
Desarrollado: INFOS TECNOLOGIA S.A.S
*****************************************************************************/

	declare @fecha		datetime,
			@referencia	varchar(50),
			@error		int	

	declare @concepto varchar(50), @registro int, @lote varchar(50), @linea int, @palma int ,  @cantidad float, @naturaleza int,
	@registroMov int, @hBrutas decimal(18,2) , @hNetas decimal(18,2), @densidadSiembra decimal(18,2), @tipoT varchar(50), @numeroT varchar(50), @registroT int

	
	set @fecha = GETDATE()
	set @error = 0 

	begin tran Anulacion
	
		update aSanidad
		set nota = '**ANULADO**' + nota,
		anulado=1,
		usuarioAnulado=@usuario,
		fechaAnulado=getdate()
		where
		tipo = @tipo and
		numero = @numero and empresa=@empresa
		
		set @error = @@ERROR

		select @referencia=referencia
		from aSanidad
		where
		tipo = @tipo and
		numero = @numero and 
		empresa =@empresa

		 
		set @referencia= isnull(@referencia,'')
		
			update atransaccionnovedad
			set
			ejecutado = 0
			where
			numero = @referencia 
			and empresa=@empresa
		
			set @error = @error + @@ERROR
								
	if( @error = 0 )
	begin
		commit tran Anulacion
		set @retorno = 0
	end
	else
	begin
		rollback tran Anulacion
		set @retorno = 1
	end