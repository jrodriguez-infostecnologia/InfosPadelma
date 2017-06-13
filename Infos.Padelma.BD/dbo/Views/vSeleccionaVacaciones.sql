﻿CREATE VIEW dbo.vSeleccionaVacaciones
AS
SELECT        dbo.nVacaciones.empresa, dbo.nVacaciones.periodoInicial, dbo.nVacaciones.periodoFinal, dbo.nVacaciones.empleado, dbo.nVacaciones.registro, dbo.nVacaciones.tipo, dbo.nVacaciones.fechaSalida, 
                         dbo.nVacaciones.fechaRetorno, dbo.nVacaciones.diasCausados, dbo.nVacaciones.diasTomados, dbo.nVacaciones.diasPendientes, dbo.nVacaciones.diasPagados, dbo.nVacaciones.valorPagado, 
                         dbo.nVacaciones.valorBase, dbo.nVacaciones.anulado, dbo.nVacaciones.fechaAnulado, dbo.nVacaciones.ejecutado, dbo.nVacaciones.pagaNomina, dbo.nVacaciones.acumulada, dbo.nVacaciones.liquidada, 
                         dbo.nVacacionesDetalle.concepto, dbo.nVacacionesDetalle.cantidad, dbo.nVacacionesDetalle.porcentaje, dbo.nVacacionesDetalle.valorUnitario, dbo.nVacacionesDetalle.valorTotal, dbo.nVacacionesDetalle.signo, 
                         dbo.nVacacionesDetalle.saldo, dbo.nVacacionesDetalle.noDias, dbo.nVacaciones.año, dbo.nVacaciones.mes, dbo.nVacaciones.periodo, dbo.nVacaciones.añoPago, dbo.nVacacionesDetalle.noPrestamo
FROM            dbo.nVacaciones LEFT OUTER JOIN
                         dbo.nVacacionesDetalle ON dbo.nVacaciones.empresa = dbo.nVacacionesDetalle.empresa AND dbo.nVacaciones.periodoInicial = dbo.nVacacionesDetalle.periodoInicial AND 
                         dbo.nVacaciones.periodoFinal = dbo.nVacacionesDetalle.periodoFinal AND dbo.nVacaciones.empleado = dbo.nVacacionesDetalle.empleado AND dbo.nVacaciones.registro = dbo.nVacacionesDetalle.registro
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vSeleccionaVacaciones';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'    Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vSeleccionaVacaciones';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[22] 4[39] 2[20] 3) )"
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
         Top = -576
         Left = 0
      End
      Begin Tables = 
         Begin Table = "nVacaciones"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 187
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 21
         End
         Begin Table = "nVacacionesDetalle"
            Begin Extent = 
               Top = 11
               Left = 441
               Bottom = 226
               Right = 650
            End
            DisplayFlags = 280
            TopColumn = 8
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 33
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
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
     ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vSeleccionaVacaciones';
