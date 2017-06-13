CREATE proc [dbo].[spSeleccionaPesoLoteRacimosPeriodo]
@fecha date,
@empresa int,
@lote varchar(50),
@finca varchar(50),
@valor decimal(18,3) output 
as

set @valor = ISNULL((select top 1 pesoRacimo from aLotePesosPeriodo where @fecha between fechainicial and fechafinal and empresa=@empresa and lote=@lote and finca=@finca),0)