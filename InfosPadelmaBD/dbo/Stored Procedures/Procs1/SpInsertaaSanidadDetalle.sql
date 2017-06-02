CREATE PROCEDURE [dbo].[SpInsertaaSanidadDetalle] @fecha date,@empresa int,@registro int,@linea int, @palma int, @item varchar(50),@fechaEjecutado datetime,@usuarioEjecturado datetime,@ejecutado bit,@cantidad decimal(18,2),@tipo varchar(50),@numero varchar(50),@uMedida varchar(50),@detalle varchar(550),@referenciaDetalle varchar(50), @gCaracteristica int, @caracteristica int,  @Retorno int output  AS begin tran aSanidadDetalle 

declare @naturaleza int

select  @naturaleza=naturaleza from aNovedad
where codigo=@item and empresa=@empresa 

insert aSanidadDetalle( fecha,empresa,registro,linea,item,fechaEjecutado,usuarioEjecturado,ejecutado,cantidad,tipo,numero,uMedida,detalle,referenciaDetalle, grupoCaracteristica, caracteristica, naturaleza, palma ) select @fecha,@empresa,@registro,@linea,@item,@fechaEjecutado,@usuarioEjecturado,@ejecutado,@cantidad,@tipo,@numero,@uMedida,@detalle,@referenciaDetalle, @gCaracteristica, @caracteristica, @naturaleza,@palma if (@@error = 0 ) begin set @Retorno = 0 commit tran aSanidadDetalle end else begin set @Retorno = 1 rollback tran aSanidadDetalle end