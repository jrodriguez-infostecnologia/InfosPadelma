 CREATE PROCEDURE [dbo].[SpActualizagCiudad] @empresa int,@codigo varchar(50),@nombre varchar(150),@pais char(5),@departamento varchar(50),
@Retorno int output  AS begin tran gCiudad update gCiudad set nombre = @nombre,pais = @pais,departamento=@departamento
 where codigo = @codigo and empresa = @empresa 
if (@@error = 0 ) begin set @Retorno = 0 commit tran gCiudad end else begin set @Retorno = 1 rollback tran gCiudad end