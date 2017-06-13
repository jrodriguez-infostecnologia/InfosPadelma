create PROCEDURE [dbo].[SpDeletenTurnoDepartamento] 
	@empresa	int,
	@turno		varchar(50),
	@Retorno	int output  
	
AS 

	begin tran nTurnoDepartamento 
	
		delete nTurnoDepartamento 
		where 
		turno = @turno and empresa=@empresa
		
	if ( @@error = 0 ) 
	begin 
		set @Retorno = 0 
		commit tran nTurnoDepartamento 
	end 
	else 
	begin 
		set @Retorno = 1 
		rollback tran nTurnoDepartamento 
	end