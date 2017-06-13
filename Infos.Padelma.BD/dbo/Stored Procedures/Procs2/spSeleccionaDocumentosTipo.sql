CREATE proc [dbo].[spSeleccionaDocumentosTipo]
@empresa int,
@tipo varchar(50),
@año int
as

select *, numero +' - '+ observacion cadena from cContabilizacion
where empresa=@empresa and tipoLiquidacion=@tipo
and año=@año and anulado=0
order by numero desc