CREATE proc [dbo].[spSeleccionaContabilizaNominaTipoPeriodo]
@empresa int,
@año int,
@periodo int,
@tipo varchar(50)
as

select * from vContabilizacion
where empresa=@empresa and año=@año and periodoNomina = @periodo and tipoliquidacion=@tipo