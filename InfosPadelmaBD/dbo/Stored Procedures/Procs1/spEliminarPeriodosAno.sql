CREATE proc spEliminarPeriodosAno
@año int,
@empresa int,
@retorno int output
as
declare @error int


begin tran Actualiza

		delete from cPeriodo
		where año=@año and empresa=@empresa
		
		
		select @error = @@error
		
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