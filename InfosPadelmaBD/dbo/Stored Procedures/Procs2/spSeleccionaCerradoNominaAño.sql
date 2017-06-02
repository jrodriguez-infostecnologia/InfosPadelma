create proc [dbo].[spSeleccionaCerradoNominaAño]
@año int,@empresa int
as select noPeriodo, 'No. ' + CONVERT(varchar(50),noPeriodo) + ' del ' +CONVERT(varchar(50),fechaInicial) + ' al ' + CONVERT(varchar(50),fechaFinal)   descripcion from nPeriodoDetalle
where cerrado=1 and año=@año  and empresa=@empresa 
order by mes