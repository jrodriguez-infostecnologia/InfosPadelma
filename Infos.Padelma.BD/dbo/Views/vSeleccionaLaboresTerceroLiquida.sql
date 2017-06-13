CREATE VIEW dbo.vSeleccionaLaboresTerceroLiquida
AS
SELECT        a.fecha, a.tipo, a.numero, b.novedad AS labor, b.fecha AS fechaLabor, c.tercero, c.cantidad, c.precioLabor, d.concepto, d.empresa, d.descripcion AS desLabor, b.lote, c.jornales, b.uMedida, DATENAME(WEEKDAY, 
                         b.fecha) AS diaSemana, f.prefijo, b.signo, b.racimos, c.contrato
FROM            dbo.aTransaccion AS a INNER JOIN
                         dbo.aTransaccionNovedad AS b ON b.numero = a.numero AND b.empresa = a.empresa AND b.tipo = a.tipo INNER JOIN
                         dbo.aTransaccionTercero AS c ON c.numero = b.numero AND c.empresa = b.empresa AND c.tipo = b.tipo AND c.registroNovedad = b.registro INNER JOIN
                         dbo.aNovedad AS d ON d.codigo = b.novedad AND d.empresa = b.empresa INNER JOIN
                         dbo.cTercero AS e ON e.id = c.tercero AND c.empresa = e.empresa INNER JOIN
                         dbo.gTipoTransaccion AS f ON f.empresa = a.empresa AND f.codigo = a.tipo
WHERE        (a.anulado = 0)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vSeleccionaLaboresTerceroLiquida';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'0
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 1110
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vSeleccionaLaboresTerceroLiquida';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[27] 4[34] 2[20] 3) )"
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
               Bottom = 136
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 6
               Left = 285
               Bottom = 136
               Right = 494
            End
            DisplayFlags = 280
            TopColumn = 15
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 532
               Bottom = 136
               Right = 741
            End
            DisplayFlags = 280
            TopColumn = 17
         End
         Begin Table = "d"
            Begin Extent = 
               Top = 6
               Left = 779
               Bottom = 136
               Right = 988
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "e"
            Begin Extent = 
               Top = 6
               Left = 1026
               Bottom = 136
               Right = 1235
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
            TopColumn = 5
         End
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
         Width = 150', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vSeleccionaLaboresTerceroLiquida';

