
CREATE proc spInformeDescuentosNominaAportes
@empresa int,
@año int,
@mes int
as

declare @conceptoSalud varchar(50) = (select salud from nParametrosGeneral where empresa=@empresa)
declare @conceptoPension varchar(50) = (select pension from nParametrosGeneral where empresa=@empresa)
declare @conceptoFondoSolidaridad varchar(50)= (select fondoSolidaridad from nParametrosGeneral where empresa=@empresa)

select  entidadSaludN entidad, (select top 1 razonSocial from cTercero where empresa=@empresa and codigo=entidadSaludN) nombreEntidad , codigo, upper(descripcion) empleado, sum(valorTotal) valorTotal , Expr1 concepto from vLiquidacionDefinitivaReal a
where  empresa =@empresa and año=@año and mes=@mes
and  codConcepto = @conceptoSalud
group by entidadSaludN, codigo, descripcion, Expr1
union
select  entidadPensionN  entidad,(select top 1 razonSocial from cTercero where empresa=@empresa and codigo=entidadPensionN) nombreEntidad, codigo, upper(descripcion) empleado,sum(valorTotal) valorTotal, Expr1 concepto from vLiquidacionDefinitivaReal
where  empresa =@empresa and año=@año and mes=@mes
and  codConcepto = @conceptoPension
group by entidadPensionN, codigo, descripcion, Expr1
union
select  entidadPensionN entidad,(select top 1 razonSocial from cTercero where empresa=@empresa and codigo=entidadPensionN) nombreEntidad, codigo, upper(descripcion) empleado,sum(valorTotal)  valorTotal, Expr1 concepto from vLiquidacionDefinitivaReal
where  empresa =@empresa and año=@año and mes=@mes
and  codConcepto = @conceptoFondoSolidaridad
group by entidadPensionN, codigo, descripcion, Expr1