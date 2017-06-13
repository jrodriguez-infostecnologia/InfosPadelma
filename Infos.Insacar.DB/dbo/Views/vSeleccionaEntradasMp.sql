CREATE VIEW dbo.vSeleccionaEntradasMp
AS
/***************************************************************************
Nombre: vSeleccionaEntradasMp
Tipo: Vista
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: 
Argumentos de salida: 

Descripción: Selecciona las entradas de materia prima por intervalo.
*****************************************************************************/ SELECT
                          1 AS orden, 'Día' AS item, YEAR(CONVERT(varchar(50), a.fechaProceso)) AS ano, CONVERT(varchar(50), CONVERT(date, a.fechaProceso)) AS intervalo, a.procedencia, a.item producto, SUM(a.pesoNeto) -SUM(a.pesoDescuento) 
                         AS pesoNeto, isnull(SUM(pesoneto) / NULLIF (dbo.fRetornaTotalFruta('D', 1, a.item, a.empresa, CONVERT(date, fechaProceso)), 0), 0) promedio, c.descripcion desProveedor, a.empresa, count(a.pesoNeto) 
                         contar
FROM            bRegistroBascula a JOIN
                         bProcedencia b ON b.codigo = a.procedencia AND b.empresa = a.empresa JOIN
                         cTercero c ON c.id = b.proveedor AND c.empresa = b.empresa JOIN
                         iItems d ON d .codigo = a.item AND d .empresa = a.empresa
WHERE        a.tipo = 'EMP' AND a.pesoNeto <> 0 AND d .referencia LIKE 'FRU%'
GROUP BY YEAR(CONVERT(varchar(50), fechaProceso)), CONVERT(varchar(50), CONVERT(date, fechaProceso)), a.procedencia, item, b.proveedor, c.descripcion, a.empresa, CONVERT(date, fechaProceso)
UNION
SELECT        3 AS orden, 'Mes', YEAR(fechaProceso), CONVERT(varchar(50), MONTH(fechaProceso)), procedencia, item, SUM(a.pesoNeto) -SUM(a.pesoDescuento), isnull(SUM(pesoneto) / NULLIF (dbo.fRetornaTotalFruta('M', CONVERT(varchar(50), 
                         MONTH(fechaProceso)), a.item, a.empresa, getdate()), 0), 0), c.descripcion, a.empresa, count(a.pesoNeto) contar
FROM            bRegistroBascula a JOIN
                         bProcedencia b ON b.codigo = a.procedencia AND b.empresa = a.empresa JOIN
                         cTercero c ON c.id = b.proveedor AND c.empresa = b.empresa JOIN
                         iItems d ON d .codigo = a.item AND d .empresa = a.empresa
WHERE        a.tipo = 'EMP' AND a.pesoNeto <> 0 AND d .referencia LIKE 'FRU%'
GROUP BY YEAR(fechaProceso), MONTH(fechaProceso), procedencia, item, c.descripcion, a.empresa
UNION
SELECT        4 AS orden, 'Año', YEAR(fechaProceso), CONVERT(varchar(50), YEAR(fechaProceso)), procedencia, item, SUM(pesoNeto) - sum (pesoDescuento), isnull(SUM(pesoneto) / NULLIF (dbo.fRetornaTotalFruta('A', CONVERT(varchar(50), 
                         year(fechaProceso)), a.item, a.empresa, getdate()), 0), 0) promedio, c.descripcion, a.empresa, count(a.pesoNeto) contar
FROM            bRegistroBascula a JOIN
                         bProcedencia b ON b.codigo = a.procedencia AND b.empresa = a.empresa JOIN
                         cTercero c ON c.id = b.proveedor AND c.empresa = b.empresa JOIN
                         iItems d ON d .codigo = a.item AND d .empresa = a.empresa
WHERE        a.tipo = 'EMP' AND a.pesoNeto <> 0 AND d .referencia LIKE 'FRU%'
GROUP BY YEAR(fechaProceso), YEAR(fechaProceso), procedencia, item, c.descripcion, a.empresa
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vSeleccionaEntradasMp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vSeleccionaEntradasMp';

