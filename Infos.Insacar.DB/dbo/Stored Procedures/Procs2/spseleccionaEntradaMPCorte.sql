CREATE proc [dbo].[spseleccionaEntradaMPCorte]
@empresa int,
@fecha date
as
SELECT   1 AS orden, 'Día' AS item, YEAR(CONVERT(varchar(50), a.fechaProceso)) AS ano, CONVERT(varchar(50), CONVERT(date, a.fechaProceso)) AS intervalo, a.procedencia, a.item producto, 
case when YEAR(a.fechaProceso)=2015 and MONTH(a.fechaProceso)< 4 then SUM(a.pesoNeto) else  SUM(a.pesoNeto)- SUM(a.pesoDescuento) end AS peso, 
isnull(SUM(pesoneto) / NULLIF (dbo.fRetornaTotalFruta('D', 1, a.item, a.empresa, CONVERT(date, fechaProceso)), 0), 0) promedio, c.descripcion desProveedor, a.empresa, 
                         count(a.pesoNeto) contar
FROM            bRegistroBascula a JOIN
                         bProcedencia b ON b.codigo = a.procedencia AND b.empresa = a.empresa JOIN
                         cTercero c ON c.id = b.proveedor AND c.empresa = b.empresa JOIN
                         iItems d ON d .codigo = a.item AND d .empresa = a.empresa
WHERE        a.tipo = 'EMP' AND a.pesoNeto <> 0 AND d .referencia LIKE 'FRU%' and a.empresa=@empresa and convert(date,a.fechaProceso)=@fecha
GROUP BY YEAR(CONVERT(varchar(50), fechaProceso)), YEAR(a.fechaProceso), MONTH(a.fechaProceso),CONVERT(varchar(50), CONVERT(date, fechaProceso)), a.procedencia, item, b.proveedor, c.descripcion, a.empresa, CONVERT(date, fechaProceso)
UNION
SELECT        2 AS orden, 'Mes', YEAR(fechaProceso), CONVERT(varchar(50), MONTH(fechaProceso)), procedencia, item, SUM(a.pesoNeto) - SUM(a.pesoDescuento), isnull(SUM(pesoneto) / NULLIF (
dbo.fRetornaTotalFruta('M', CONVERT(varchar(50), MONTH(fechaProceso)), a.item, a.empresa,@fecha), 0), 0), c.descripcion, a.empresa, count(a.pesoNeto) contar
FROM            bRegistroBascula a JOIN
                         bProcedencia b ON b.codigo = a.procedencia AND b.empresa = a.empresa JOIN
                         cTercero c ON c.id = b.proveedor AND c.empresa = b.empresa JOIN
                         iItems d ON d .codigo = a.item AND d .empresa = a.empresa
WHERE        a.tipo = 'EMP' AND a.pesoNeto <> 0 AND d .referencia LIKE 'FRU%' and a.empresa=@empresa 
and convert(date,a.fechaProceso)<=@fecha and  MONTH(fechaProceso)=month(@fecha) and year(fechaProceso) = YEAR(@fecha)
GROUP BY YEAR(fechaProceso), MONTH(fechaProceso), procedencia, item, c.descripcion, a.empresa
UNION
SELECT        3 AS orden, 'Año', YEAR(fechaProceso), CONVERT(varchar(50), YEAR(fechaProceso)), procedencia, item, SUM(pesoNeto) - sum(pesoDescuento), isnull(SUM(pesoneto) / NULLIF (dbo.fRetornaTotalFruta('A', 
                         CONVERT(varchar(50), year(fechaProceso)), a.item, a.empresa, getdate()), 0), 0) promedio, c.descripcion, a.empresa, count(a.pesoNeto) contar
FROM            bRegistroBascula a JOIN
                         bProcedencia b ON b.codigo = a.procedencia AND b.empresa = a.empresa JOIN
                         cTercero c ON c.id = b.proveedor AND c.empresa = b.empresa JOIN
                         iItems d ON d .codigo = a.item AND d .empresa = a.empresa
WHERE        a.tipo = 'EMP' AND a.pesoNeto <> 0 AND d .referencia LIKE 'FRU%' and a.empresa=@empresa and convert(date,a.fechaProceso)<= @fecha and year(fechaProceso) = YEAR(@fecha)
GROUP BY YEAR(fechaProceso), procedencia, item, c.descripcion, a.empresa