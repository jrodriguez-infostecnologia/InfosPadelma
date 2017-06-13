CREATE proc [dbo].[spSeleccionaTercerosPagoCheques]
@periodo int,
@año int,
@numero varchar(50),
@empresa int
as

select tercero ,  '( ' + CONVERT(varchar(50), tercero) + ') ' + nombreTercero nombreTercero  from [dbo].[vSeleccionaPagosNomina]
where empresa=@empresa and noPeriodo=@periodo and numero=@numero
and noCheque<>''
and año=@año