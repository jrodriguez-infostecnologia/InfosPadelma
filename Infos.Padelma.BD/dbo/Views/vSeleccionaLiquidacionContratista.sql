CREATE VIEW dbo.vSeleccionaLiquidacionContratista
AS
SELECT        dbo.aTransaccion.empresa, dbo.aTransaccion.año, dbo.aTransaccion.mes, dbo.aTransaccion.tipo, dbo.aTransaccion.numero, dbo.aTransaccionNovedad.fecha, dbo.aNovedad.codigo, dbo.aNovedad.descripcion, 
                         dbo.aTransaccionTercero.lote, dbo.aTransaccionTercero.cantidad, dbo.aTransaccionNovedad.uMedida, dbo.aTransaccionTercero.precioLabor, dbo.aTransaccionTercero.jornales, 
                         dbo.aTransaccionTercero.valorTotal, dbo.nFuncionario.tercero, dbo.nFuncionario.codigo AS identificacion, dbo.nFuncionario.descripcion AS nombreTercero, dbo.aTransaccion.anulado, 
                         dbo.nFuncionario.contratista, dbo.cTercero.nit, dbo.cTercero.dv, dbo.cTercero.razonSocial, dbo.aTransaccion.fecha AS fechaT, dbo.aLotes.descripcion AS nombreLote
FROM            dbo.aTransaccion INNER JOIN
                         dbo.aTransaccionNovedad ON dbo.aTransaccion.empresa = dbo.aTransaccionNovedad.empresa AND dbo.aTransaccion.tipo = dbo.aTransaccionNovedad.tipo AND 
                         dbo.aTransaccion.numero = dbo.aTransaccionNovedad.numero INNER JOIN
                         dbo.aTransaccionTercero ON dbo.aTransaccion.empresa = dbo.aTransaccionTercero.empresa AND dbo.aTransaccion.tipo = dbo.aTransaccionTercero.tipo AND 
                         dbo.aTransaccion.numero = dbo.aTransaccionTercero.numero AND dbo.aTransaccionNovedad.registro = dbo.aTransaccionTercero.registroNovedad INNER JOIN
                         dbo.aNovedad ON dbo.aTransaccion.empresa = dbo.aNovedad.empresa AND dbo.aTransaccionTercero.novedad = dbo.aNovedad.codigo INNER JOIN
                         dbo.nFuncionario ON dbo.aTransaccion.empresa = dbo.nFuncionario.empresa AND dbo.aTransaccionTercero.tercero = dbo.nFuncionario.tercero INNER JOIN
                         dbo.cTercero ON dbo.aTransaccion.empresa = dbo.cTercero.empresa AND dbo.nFuncionario.proveedor = dbo.cTercero.id LEFT OUTER JOIN
                         dbo.aLotes ON dbo.aTransaccionTercero.empresa = dbo.aLotes.empresa AND dbo.aTransaccionTercero.lote = dbo.aLotes.codigo
WHERE        (dbo.aTransaccion.anulado = 0) AND (dbo.nFuncionario.contratista = 1)
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vSeleccionaLiquidacionContratista';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'
            DisplayFlags = 280
            TopColumn = 4
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vSeleccionaLiquidacionContratista';


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
         Begin Table = "aTransaccion"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "aTransaccionNovedad"
            Begin Extent = 
               Top = 6
               Left = 285
               Bottom = 136
               Right = 494
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "aTransaccionTercero"
            Begin Extent = 
               Top = 6
               Left = 532
               Bottom = 136
               Right = 741
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "aNovedad"
            Begin Extent = 
               Top = 6
               Left = 779
               Bottom = 136
               Right = 988
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "nFuncionario"
            Begin Extent = 
               Top = 6
               Left = 1026
               Bottom = 136
               Right = 1235
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cTercero"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "aLotes"
            Begin Extent = 
               Top = 186
               Left = 911
               Bottom = 316
               Right = 1120
            End', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vSeleccionaLiquidacionContratista';

