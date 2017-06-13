CREATE proc [dbo].[spSeleccionaAbiertosNominaAño]
@año int,@empresa int
as select noPeriodo, 'No. ' + CONVERT(varchar(50),noPeriodo) + ' del ' +CONVERT(varchar(50),fechaInicial) + ' al ' + CONVERT(varchar(50),fechaFinal)   descripcion from nPeriodoDetalle
where cerrado=0 and año=@año  and empresa=@empresa 
order by mes