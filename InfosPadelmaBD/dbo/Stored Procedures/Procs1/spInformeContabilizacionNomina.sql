CREATE proc spInformeContabilizacionNomina
@año int,
@mes int,
@empresa int
as

select * from vcontabilizacion
where año=@año and mes=@mes and empresa=@empresa
and anulado=0