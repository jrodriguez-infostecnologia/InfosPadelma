CREATE proc [dbo].[spseleccionaEmtradaDPTCorte]
@empresa int,
@fecha date
as
SELECT    1 AS orden, 'Día' AS item, YEAR(CONVERT(varchar(50), a.fechaProceso)) AS ano, CONVERT(varchar(50), CONVERT(date, a.fechaProceso)) AS intervalo, c.descripcion desCliente, a.item producto, 
                         d .descripcion desProducto, SUM(a.pesoNeto) - SUM(a.pesoDescuento) AS pesoNeto, isnull(SUM(pesoneto) / NULLIF (dbo.fRetornaTotalDepachos('D', 1, a.item, a.empresa, CONVERT(date, fechaProceso)), 0), 0) 
                         promedio, a.empresa, count(a.pesoNeto) contar
FROM            bRegistroBascula a JOIN
                         logProgramacionVehiculo b ON b.numero = a.remision AND b.empresa = a.empresa JOIN
                         cTercero c ON c.id = b.tercero AND c.empresa = b.empresa JOIN
                         iItems d ON d .codigo = a.item AND d .empresa = a.empresa
WHERE        a.tipo = 'DPT' AND a.pesoNeto <> 0 and a.empresa=@empresa and convert(date,a.fechaProceso)=@fecha
GROUP BY YEAR(CONVERT(varchar(50), fechaProceso)), CONVERT(varchar(50), CONVERT(date, fechaProceso)), c.descripcion, item, d .descripcion, c.codigo, c.descripcion, a.empresa, CONVERT(date, fechaProceso)
UNION
SELECT     2 AS orden, 'Mes', YEAR(fechaProceso), CONVERT(varchar(50), MONTH(fechaProceso)), c.descripcion, item, d .descripcion, SUM(a.pesoNeto) - SUM(a.pesoDescuento), isnull(SUM(pesoneto) 
                         / NULLIF (dbo.fRetornaTotalDepachos('M', CONVERT(varchar(50), MONTH(fechaProceso)), a.item, a.empresa, getdate()), 0), 0), a.empresa, count(a.pesoNeto) contar
FROM            bRegistroBascula a JOIN
                         logProgramacionVehiculo b ON b.numero = a.remision AND b.empresa = a.empresa JOIN
                         cTercero c ON c.id = b.tercero AND c.empresa = b.empresa JOIN
                         iItems d ON d .codigo = a.item AND d .empresa = a.empresa
WHERE        a.tipo = 'DPT' AND a.pesoNeto <> 0 and a.empresa=@empresa and convert(date,a.fechaProceso)<=@fecha and  MONTH(fechaProceso)=month(@fecha)
GROUP BY YEAR(fechaProceso), MONTH(fechaProceso), c.descripcion, item, d .descripcion, a.empresa
UNION
SELECT        4 AS orden, 'Año', YEAR(fechaProceso), CONVERT(varchar(50), YEAR(fechaProceso)), c.descripcion, item, d .descripcion, SUM(pesoNeto) - sum(pesoDescuento), isnull(SUM(pesoneto) 
                         / NULLIF (dbo.fRetornaTotalDepachos('A', CONVERT(varchar(50), year(fechaProceso)), a.item, a.empresa, getdate()), 0), 0) promedio, a.empresa, count(a.pesoNeto) contar
FROM            bRegistroBascula a JOIN
                         logProgramacionVehiculo b ON b.numero = a.remision AND b.empresa = a.empresa JOIN
                         cTercero c ON c.id = b.tercero AND c.empresa = b.empresa JOIN
                         iItems d ON d .codigo = a.item AND d .empresa = a.empresa
WHERE        a.tipo = 'DPT' AND a.pesoNeto <> 0 and a.empresa=@empresa and convert(date,a.fechaProceso)<=@fecha and year(fechaProceso)= YEAR(@fecha)
GROUP BY YEAR(fechaProceso), YEAR(fechaProceso), c.descripcion, item, d .descripcion, a.empresa