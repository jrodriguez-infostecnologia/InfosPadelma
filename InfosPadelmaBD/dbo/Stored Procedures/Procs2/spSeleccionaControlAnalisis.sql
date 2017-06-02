
create PROCEDURE [dbo].[spSeleccionaControlAnalisis]
	@transaccion varchar(50),
	@empresa int,
	@retorno	int output
AS
/***************************************************************************

*****************************************************************************/
		 declare @control varchar(2)
				 
		select @control=concurrencia from gTipoTransaccionConcurrencia where transaccion=@transaccion and empresa=@empresa
		
		set @control = ISNULL(@control,'')

		
		if(@control='H')
		begin
		set @retorno=0
		end 
	
		if @control='D'
		begin 
		set @retorno=1
		end
		
		if @control ='S'
		begin 
		set @retorno=2
		end
		
		if @control = 'M'
		begin 
		set 
		@retorno=3
		end

		if @control =''
		begin 
		set 
		@retorno=100
		end