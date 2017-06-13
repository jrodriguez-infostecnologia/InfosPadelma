create procedure [dbo].[spModificaDespacho]
	@fecha			datetime,
	@remision		varchar(50),
	@remisionC		varchar(50),
	@vehiculo		varchar(50),
	@remolque		varchar(50),
	@producto		varchar(50),
	@cliente		varchar(50),
	@lEntrega		varchar(50),
	@comer			varchar(50),
	@planta			varchar(50),
	@tiquete		varchar(50),
	@retorno		int output,
	@empresa		int
AS
/***************************************************************************
Nombre: spModificaDespacho
Tipo: Procedimiento Almacenado
INFOS TECNOLOGIA S.A.S
*****************************************************************************/

	declare @error			int,
			@numero			varchar(50),
			@tipoTrans		varchar(50)
	
	set @error = 0

	select @numero = numero,@tipoTrans = tipo
	from logDespacho
	where
	tiquete = @tiquete and
	remision = @remision and
	tipo <> 'ANULADO'		
	and empresa=@empresa
	
	begin tran Actualiza
	
		update logDespacho
		set
		fecha = @fecha,
		vehiculo = @vehiculo,
		remolque = @remolque,
		producto = @producto,
		cliente = @cliente,
		lugarEntrega = @lEntrega,
		comercializadora = @comer,
		planta = @planta
		where
		tipo = @tipoTrans and
		numero = @numero
		and empresa=@empresa
		
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