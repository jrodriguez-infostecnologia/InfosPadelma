CREATE proc spSeleccioDocumentosCausacionNomina
@empresa int
as

select * from cContabilizacion
where empresa=@empresa
order by numero desc