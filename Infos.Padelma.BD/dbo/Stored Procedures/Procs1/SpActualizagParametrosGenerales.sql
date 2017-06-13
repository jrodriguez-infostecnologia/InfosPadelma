create PROCEDURE 
[dbo].[SpActualizagParametrosGenerales] @empresa int,@entradas varchar(50),@entradasAlt varchar(50),@salidas varchar(50),@salidasAlt varchar(50),@pesajes varchar(50),@pesajesAlt varchar(50),@fruta varchar(50),@frutaAlt varchar(50),@almendra varchar(50),@almedraAlt varchar(50),@nuez varchar(50),@nuezAlt varchar(50),@crudo varchar(50),@crudoAlt varchar(50),@palmiste varchar(50),@palmisteAlt varchar(50),@blanqueado varchar(50),@blanqueadoAlt varchar(50),@cascarilla varchar(50),@cascarillaAlt varchar(50),@torta varchar(50),@tortaAlt varchar(50),@raquiz varchar(50),@raquizAlt varchar(50),@raquizPrensado varchar(50),@raquizPrensadoAlt varchar(50),@fibra varchar(50),@fibraAlt varchar(50),@tiquete varchar(50),@tiqueteAlt varchar(50),@ordenEnvio varchar(50),@ordenEnvioAlt varchar(50),@remisionComer varchar(50),@remisionComerAlt varchar(50),@remisionInt varchar(50),@remisionIntAlt varchar(50),@ordenSalida varchar(50),@ordenSalidaAlt varchar(50),
@anulado	varchar(50),
@anuladoAlt	varchar(50),	
@frutaDura	varchar(50)	,
@frutaDuraAlt	varchar(50)	,
@frutaTenera	varchar(50)	,
@frutaTeneraAlt	varchar(50)	,
@agl	varchar(50)	,
@aglAlt	varchar(50)	,
@humedad	varchar(50)	,
@humedadAlt	varchar(50)	,
@impurezas	varchar(50)	,
@impurezasAlt	varchar(50)	,
@Retorno int output  AS begin tran gParametrosGenerales 


update gParametrosGenerales set entradas = @entradas,entradasAlt = @entradasAlt,salidas = @salidas,salidasAlt = @salidasAlt,pesajes = @pesajes,pesajesAlt = @pesajesAlt,fruta = @fruta,frutaAlt = @frutaAlt,almendra = @almendra,almedraAlt = @almedraAlt,nuez = @nuez,nuezAlt = @nuezAlt,crudo = @crudo,crudoAlt = @crudoAlt,palmiste = @palmiste,palmisteAlt = @palmisteAlt,blanqueado = @blanqueado,blanqueadoAlt = @blanqueadoAlt,cascarilla = @cascarilla,cascarillaAlt = @cascarillaAlt,torta = @torta,tortaAlt = @tortaAlt,raquiz = @raquiz,raquizAlt = @raquizAlt,raquizPrensado = @raquizPrensado,raquizPrensadoAlt = @raquizPrensadoAlt,fibra = @fibra,fibraAlt = @fibraAlt,tiquete = @tiquete,tiqueteAlt = @tiqueteAlt,ordenEnvio = @ordenEnvio, remisionComer=@remisionComer, remisionComerAlt=@remisionComerAlt, remisionInt=@remisionInt, remisionIntAlt=@remisionIntAlt, ordenEnvioAlt=@ordenEnvioAlt, ordenSalida=@ordenSalida, ordenSalidaAlt=@ordenSalidaAlt,
anulado=@anulado	,
anuladoAlt=@anuladoAlt	,
frutaDura=@frutaDura	,
frutaDuraAlt = @frutaDuraAlt,	
frutaTenera	= @frutaTenera,
frutaTeneraAlt=@frutaTeneraAlt,	
agl	=@agl,
aglAlt=@aglAlt	,
humedad = @humedad	,
humedadAlt= @humedadAlt	,
impurezas=@impurezas	,
impurezasAlt = @impurezasAlt	
where empresa = @empresa

 if (@@error = 0 ) begin set @Retorno = 0 commit tran gParametrosGenerales end else begin set @Retorno = 1 rollback tran gParametrosGenerales end