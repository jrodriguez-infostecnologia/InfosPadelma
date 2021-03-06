﻿CREATE VIEW dbo.vValorAcumuladoPrimas
AS
SELECT        CASE WHEN a.concepto = f.vacaciones AND a.cantidad <= 15 THEN 0 ELSE CASE WHEN b.signo = 2 THEN a.valorTotal * - 1 ELSE a.valorTotal END END AS valorTotal, a.empresa, a.tercero, a.contrato, a.año, 
                         a.noPeriodo, a.numero, a.concepto, a.tipo, b.basePrimas, CASE WHEN a.concepto = f.vacaciones AND a.cantidad <= 15 THEN 0 ELSE CASE WHEN b.signo = 2 AND 
                         b.codigo <> f.suspenciones THEN a.cantidad * - 1 ELSE a.cantidad END END AS cantidad, b.sumaPrestacionSocial, b.ausentismo, b.descripcion AS nombreConcepto, b.baseCesantias
FROM            dbo.nLiquidacionNominaDetalle AS a INNER JOIN
                         dbo.nConcepto AS b ON b.codigo = a.concepto AND b.empresa = a.empresa INNER JOIN
                         dbo.nLiquidacionNomina AS e ON e.numero = a.numero AND e.tipo = a.tipo AND e.anulado = 0 AND a.empresa = e.empresa INNER JOIN
                         dbo.nParametrosGeneral AS f ON f.empresa = a.empresa
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vValorAcumuladoPrimas';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vValorAcumuladoPrimas';


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
         Begin Table = "a"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 221
               Right = 255
            End
            DisplayFlags = 280
            TopColumn = 27
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 6
               Left = 292
               Bottom = 192
               Right = 508
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "e"
            Begin Extent = 
               Top = 6
               Left = 546
               Bottom = 136
               Right = 755
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "f"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
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
   ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vValorAcumuladoPrimas';

