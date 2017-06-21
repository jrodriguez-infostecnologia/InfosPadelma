CREATE proc [dbo].[spSeleccionaPeriodoDetalle]
@año int,
@empresa int
as

select * , +CONVERT(varchar(50),año)+' -  Mes: '+ CONVERT(varchar(50), mes) + ' -  No periodo: '+ CONVERT(varchar(50), noPeriodo) descripcion  from nPeriodoDetalle
where empresa=@empresa and año=@año