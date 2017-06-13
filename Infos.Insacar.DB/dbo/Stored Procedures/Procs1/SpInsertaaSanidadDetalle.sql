CREATE PROCEDURE [dbo].[SpInsertaaSanidadDetalle] @fecha date,@empresa int,@registro int,@linea int,@palma int,@item int,@fechaEjecutado datetime,@usuarioEjecturado datetime,@ejecutado bit,@cantidad decimal,@tipo varchar(50),@numero varchar(50),@lote varchar(50),@uMedida varchar(50),@detalle varchar(550),@referenciaDetalle varchar(50), @gCaracteristica int, @caracteristica int,  @Retorno int output  AS begin tran aSanidadDetalle 

declare @naturaleza int

select  @naturaleza=naturaleza from aNovedad
where codigo=@item and empresa=@empresa 

insert aSanidadDetalle( fecha,empresa,registro,linea,palma,item,fechaEjecutado,usuarioEjecturado,ejecutado,cantidad,tipo,numero,lote,uMedida,detalle,referenciaDetalle, grupoCaracteristica, caracteristica, naturaleza ) select @fecha,@empresa,@registro,@linea,@palma,@item,@fechaEjecutado,@usuarioEjecturado,@ejecutado,@cantidad,@tipo,@numero,@lote,@uMedida,@detalle,@referenciaDetalle, @gCaracteristica, @caracteristica, @naturaleza if (@@error = 0 ) begin set @Retorno = 0 commit tran aSanidadDetalle end else begin set @Retorno = 1 rollback tran aSanidadDetalle end