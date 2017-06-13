create proc [dbo].[spSeleccionaAbiertosNomina]
@año int,@mes int,@empresa int
as select noPeriodo, 'No. ' + CONVERT(varchar(50),noPeriodo) + ' del ' +CONVERT(varchar(50),fechaInicial) + ' al ' + CONVERT(varchar(50),fechaFinal)   descripcion from nPeriodoDetalle
where cerrado=0 and año=@año and mes=@mes and empresa=@empresa 
order by mes