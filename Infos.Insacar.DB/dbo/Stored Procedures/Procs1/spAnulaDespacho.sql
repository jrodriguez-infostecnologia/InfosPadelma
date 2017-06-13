
create procedure [dbo].[spAnulaDespacho]
	@tiquete		varchar(50),
	@empresa		int,
	@retorno		int output
AS
/***************************************************************************
Nombre: spAnulaDespacho
Tipo: Procedimiento Almacenado
INFOS TECNOLOGIA S.A.S
*****************************************************************************/

	declare @error int

	begin tran Actualiza
	
		update logDespacho
		set
		tipo = 'ANULADO'
		where
		tiquete = @tiquete
		and empresa=@empresa
		
		set @error = @@ERROR
		
		update bRegistroBascula
		set
		tipo = 'ANULADO'
		where
		tiquete = @tiquete
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