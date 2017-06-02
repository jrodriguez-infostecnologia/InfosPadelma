create proc [dbo].[spVerificaRemisionComercializadoraImpre]
@numero varchar(50),
@tipoTran varchar(50),
@empresa int,
@retorno int output

as
declare 	@RemisionComer varchar(50) = (select remisionComer from gParametrosGenerales where empresa=@empresa)
set @retorno=0

	if( exists( select b.producto from  bRegistroBascula a, gTipoTransaccionProducto b
				where
				 a.empresa=b.empresa and
				a.item = b.producto and
				b.tipo in (@RemisionComer) and
			    a.tiquete = @numero) and
		@tipoTran in (select ordenenvio from gParametrosGenerales where empresa=@empresa )   ) 
	begin 
		set @retorno=1
	end