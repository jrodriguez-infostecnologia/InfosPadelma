create PROCEDURE [dbo].[SpInsertaperfilPermisos] 
	@activo				bit,
	@perfil				varchar(50),
	@sitio				varchar(150),
	@menu				varchar(150),
	@operacion			varchar(50),
	@todasOperaciones	bit,
	@Retorno	int output  

AS 

	declare @operacionLista	varchar(50)

	if( @todasOperaciones = 0 )
	begin
		begin tran perfilPermisos 

			insert sperfilPermisos( 
				activo,
				perfil,
				sitio,
				menu,
				operacion ) 
			select 
				@activo,
				@perfil,
				@sitio,
				@menu,
				@operacion 

		if ( @@error = 0 ) 
		begin 
			set @Retorno = 0 
			commit tran perfilPermisos 
		end 
		else 
		begin 
			set @Retorno = 1 
			rollback tran perfilPermisos 
		end
	end
	else
	begin

		declare curOperaciones insensitive cursor for
		select codigo
		from soperaciones	

		open curOperaciones
		fetch curOperaciones into @operacionLista

		while( @@fetch_status = 0 )
		begin

			begin tran perfilPermisos 

				insert sperfilPermisos( 
					activo,
					perfil,
					sitio,
					menu,
					operacion ) 
				select 
					1,
					@perfil,
					@sitio,
					@menu,
					@operacionLista 

			if ( @@error = 0 ) 
			begin 
				set @Retorno = 0 
				commit tran perfilPermisos 
			end 
			else 
			begin 
				set @Retorno = 1 
				rollback tran perfilPermisos 
			end

			fetch curOperaciones into @operacionLista
		end

		close curOperaciones
		deallocate curOperaciones

	end