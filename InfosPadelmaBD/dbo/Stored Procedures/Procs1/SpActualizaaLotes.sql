
CREATE PROCEDURE [dbo].[SpActualizaaLotes] @empresa int,@añoSiembra int,@mesSiembra int,@palmasBrutas int,@palmasProduccion int,@NoLineas int,
@fechaRegistro datetime,@manejaSeccion bit,@activo bit,@hBrutas decimal(18,3),@hNetas decimal(18,3),@dSiembra decimal(18,3),@densidad decimal(18,3),
@codigo varchar(50),@finca varchar(50),@descripcion varchar(550),@usuario varchar(50),@foto varchar(1550),@seccion char(3),@variedad char(5),@desarrollo bit,@Retorno int output  
AS begin tran aLotes update aLotes set añoSiembra = @añoSiembra,mesSiembra = @mesSiembra,palmasBrutas = @palmasBrutas,palmasProduccion = @palmasProduccion,
NoLineas = @NoLineas,fechaRegistro = @fechaRegistro,manejaSeccion = @manejaSeccion,activo = @activo,hBrutas = @hBrutas,hNetas = @hNetas,dSiembra = @dSiembra,
densidad = @densidad,finca = @finca,descripcion = @descripcion,usuario = @usuario,foto = @foto,seccion = @seccion,variedad = @variedad, desarrollo=@desarrollo where empresa = @empresa 
and codigo = @codigo if (@@error = 0 ) begin set @Retorno = 0 commit tran aLotes end else begin set @Retorno = 1 rollback tran aLotes end