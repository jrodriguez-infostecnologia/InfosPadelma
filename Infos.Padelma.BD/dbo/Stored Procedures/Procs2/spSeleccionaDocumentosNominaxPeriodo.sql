
CREATE proc [dbo].[spSeleccionaDocumentosNominaxPeriodo]
@empresa int,
@año int,
@periodo int
as
select distinct numero,convert(varchar(50), numero) +' -	 Año: '  +CONVERT(varchar(50),año)+' -  Mes: '+ CONVERT(varchar(50), mes) + ' -  No periodo: '+ CONVERT(varchar(50), noPeriodo) documento 
 from vSeleccionaLiquidacionDefinitiva
where año=@año and noPeriodo=@periodo and empresa=@empresa
and anulado=0