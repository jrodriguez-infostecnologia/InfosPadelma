 CREATE PROCEDURE [dbo].[SpActualizaiItems] @empresa int,@codigo int,@tiempoReposicion int,@foto int,
@fechaActualiza datetime,@manejaIR bit,@compras bit,@ventas bit,
@activo bit,@minimo decimal,@maximo decimal,@descripcion varchar(950),
@descripcionAbreviada varchar(50),@referencia varchar(250),@uMedidaCompra varchar(10),
@uMedidaConsumo varchar(10),@papeleta varchar(50),@notas varchar(1550),@orden int,
@usuarioActualiza varchar(50),@grupoIR char(5),@tipo char(1),@Retorno int output 
 
AS begin tran iItems update iItems set tiempoReposicion = @tiempoReposicion,foto = @foto,
fechaActualiza = @fechaActualiza,manejaIR = @manejaIR,compras = @compras,orden=@orden,
ventas = @ventas,activo = @activo,minimo = @minimo,maximo = @maximo,descripcion = @descripcion,
descripcionAbreviada = @descripcionAbreviada,referencia = @referencia,uMedidaCompra = @uMedidaCompra,uMedidaConsumo = @uMedidaConsumo,
papeleta = @papeleta,notas = @notas,usuarioActualiza = @usuarioActualiza,grupoIR = @grupoIR,tipo = @tipo 
where empresa = @empresa and codigo = @codigo if (@@error = 0 ) begin set @Retorno = 0 commit tran iItems end else begin set @Retorno = 1 
rollback tran iItems end