CREATE proc [dbo].[spSeleccionaLaboresTerceroFechaLiquidacion]
@empresa int
as

declare @fi date, @ff date

select @fi=fechaInical, @ff=fechaFinal  from tmpliquidacionNomina

--select @fi, @ff

select * from vSeleccionaTransaccionesAgronomico
where fechaTransaccion between @fi and @ff and codEmpresa=@empresa
and anulado=0  and idTercero in (select tercero from tmpliquidacionNomina)