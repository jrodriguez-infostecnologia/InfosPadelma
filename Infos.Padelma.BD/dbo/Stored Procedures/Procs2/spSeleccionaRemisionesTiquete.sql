
create proc [dbo].[spSeleccionaRemisionesTiquete]
@empresa int,
@tipoTran varchar(50),
@tiquete varchar(50),
 @nroDoc varchar(50) output,
 @nroComer varchar(50) output
as

declare @RemisionComer varchar(50) = (SELECT remisionComer FROM gParametrosGenerales WHERE empresa=@empresa)


execute spRetornaConsecutivoTransaccion @tipoTran,@empresa,@nroDoc output

	if( exists( select b.producto 
				from  bRegistroBascula a
				join  gTipoTransaccionProducto b on a.item = b.producto and b.empresa=a.empresa 
				join gParametrosGenerales c on c.empresa=a.empresa
				where b.tipo in (@RemisionComer) and
			    a.tiquete = @tiquete) and
		@tipoTran = ((SELECT ordenEnvio FROM gParametrosGenerales WHERE empresa=@empresa)) )
	begin 
		execute spRetornaConsecutivoTransaccion @RemisionComer,@empresa,@nroComer output

	end 

set @nroComer = isnull(@nroComer,'')
set @RemisionComer = isnull(@RemisionComer,'')