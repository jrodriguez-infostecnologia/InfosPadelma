
create procedure [dbo].[spAnulaModificaDespacho]
	@fecha			datetime,
	@tipo			varchar(50),
	@tipoC			varchar(50),
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
	@remisionN		varchar(50) output,
	@retorno		int output,
	@empresa int
AS
/***************************************************************************
Nombre: spAnulaModificaDespacho
Tipo: Procedimiento Almacenado
INFOS TECNOLOGIA S.A.S

*****************************************************************************/

	declare @error			int,
			@numero			varchar(50),
			@numeroA		varchar(50),		
			@tipoTrans		varchar(50),
			@remisionCant	varchar(50)
	
	set @error = 0

	select @numero = numero,@tipoTrans = tipo,@remisionCant = remisionComercializadora
	from logDespacho
	where
	tiquete = @tiquete and
	remision = @remision and
	tipo <> 'ANULADO' and 
	empresa=@empresa
		
	execute spRetornaConsecutivoTransaccion @tipo,@empresa,@remisionN output	
	execute spRetornaConsecutivoTransaccion 'ANULADO',@empresa,@numeroA output
	
	begin tran Actualiza
	
		update logDespacho
		set
		tipo = 'ANULADO',
		numero = @numeroA
		where
		numero = @numero and
		empresa=@empresa
		
		set @error = ( @error + @@ERROR )	
				
		insert logDespacho(
			año,
			mes,
			tipo,
			numero,
			fecha,
			tiquete,
			remision,
			remisionComercializadora,
			vehiculo,
			remolque,
			cantidad,
			producto,
			programacion,
			cliente,
			lugarEntrega,
			comercializadora,
			planta,
			empresa )
		select
			año,
			mes,
			@tipoTrans,
			@numero,
			@fecha,
			tiquete,
			@remisionN,
			@remisionC,
			@vehiculo,
			@remolque,
			cantidad,
			@producto,
			programacion,
			@cliente,
			@lEntrega,
			@comer,
			@planta,
			empresa
			from logDespacho
			where
			numero = @numeroA and
			tipo = 'ANULADO' and
			empresa=@empresa
			
		set @error = ( @error + @@ERROR )
		
		update gTipoTransaccion
		set
		actual = actual + 1
		where
		codigo = @tipo
		and empresa=@empresa
		
		set @error = ( @error + @@ERROR )
		
		update gTipoTransaccion
		set
		actual = actual + 1
		where
		codigo = 'ANULADO'
		and empresa=@empresa
		
		set @error = ( @error + @@ERROR )				
		
		if(@remisionC <> '' and @remisionC <> @remisionCant)
		begin
			update gTipoTransaccion
			set
			actual = actual + 1
			where
			codigo = @tipoC	
			and empresa=@empresa		
		end
		
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