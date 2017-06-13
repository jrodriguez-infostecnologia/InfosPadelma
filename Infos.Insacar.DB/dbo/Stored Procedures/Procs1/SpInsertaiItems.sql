CREATE PROCEDURE [dbo].[SpInsertaiItems] @empresa int,@codigo int,@tiempoReposicion int,@foto int,@fechaRegistro datetime,
@fechaActualiza datetime,@manejaIR bit,@compras bit,@ventas bit,@activo bit,@minimo decimal,@maximo decimal,
@descripcion varchar(950),@descripcionAbreviada varchar(50),@referencia varchar(250),@uMedidaCompra varchar(50),
@uMedidaConsumo varchar(50),@papeleta varchar(50),@notas varchar(1550),@usuarioRegistro varchar(50),
@orden int ,@usuarioActualiza varchar(50),@grupoIR char(5),@tipo char(1),@Retorno int output  AS begin tran iItems 
insert iItems( empresa,codigo,tiempoReposicion,foto,fechaRegistro,fechaActualiza,manejaIR,compras,ventas,activo,minimo,
maximo,descripcion,descripcionAbreviada,referencia,uMedidaCompra,uMedidaConsumo,papeleta,notas,usuarioRegistro,
usuarioActualiza,grupoIR,tipo, orden ) select @empresa,@codigo,@tiempoReposicion,@foto,@fechaRegistro,@fechaActualiza,
@manejaIR,@compras,@ventas,@activo,@minimo,@maximo,@descripcion,@descripcionAbreviada,@referencia,@uMedidaCompra,
@uMedidaConsumo,@papeleta,@notas,@usuarioRegistro,@usuarioActualiza,@grupoIR,@tipo, @orden if (@@error = 0 ) begin set @Retorno = 0 commit tran iItems end else begin set @Retorno = 1 rollback tran iItems end