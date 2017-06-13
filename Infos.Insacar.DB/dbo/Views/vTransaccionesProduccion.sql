CREATE VIEW dbo.vTransaccionesProduccion
AS
SELECT        dbo.pTransaccion.empresa, dbo.pTransaccion.tipo, dbo.pTransaccion.numero, dbo.pTransaccion.año, dbo.pTransaccion.mes, dbo.pTransaccion.fecha, dbo.pTransaccion.producto, dbo.pTransaccion.usuario, 
                         dbo.pTransaccion.usuarioAnulado, dbo.pTransaccion.fechaRegistro, dbo.pTransaccion.anulado, dbo.pTransaccion.fechaAnulado, dbo.pTransaccion.Observacion, dbo.pTransaccionDetalle.registro, 
                         dbo.pTransaccionDetalle.movimiento, dbo.pTransaccionDetalle.valor, iItemsProductos.referencia AS refProducto, iItemsMovimientos.referencia AS refMovimiento, dbo.pProductoMovimiento.almacena, 
                         dbo.pProductoMovimiento.mCalcular, dbo.pProductoMovimiento.mDecimal, dbo.pProductoMovimiento.mInforme
FROM            dbo.pTransaccion INNER JOIN
                         dbo.pTransaccionDetalle ON dbo.pTransaccion.empresa = dbo.pTransaccionDetalle.empresa AND dbo.pTransaccion.tipo = dbo.pTransaccionDetalle.tipo AND 
                         dbo.pTransaccion.numero = dbo.pTransaccionDetalle.numero INNER JOIN
                         dbo.iItems AS iItemsMovimientos ON dbo.pTransaccionDetalle.empresa = iItemsMovimientos.empresa AND dbo.pTransaccionDetalle.movimiento = iItemsMovimientos.codigo INNER JOIN
                         dbo.iItems AS iItemsProductos ON dbo.pTransaccion.empresa = iItemsProductos.empresa AND dbo.pTransaccion.producto = iItemsProductos.codigo INNER JOIN
                         dbo.pProductoMovimiento ON dbo.pTransaccion.empresa = dbo.pProductoMovimiento.empresa AND dbo.pTransaccionDetalle.movimiento = dbo.pProductoMovimiento.movimiento AND 
                         dbo.pTransaccion.producto = dbo.pProductoMovimiento.producto
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vTransaccionesProduccion';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vTransaccionesProduccion';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[21] 4[45] 2[20] 3) )"
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
         Begin Table = "pTransaccion"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 198
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pTransaccionDetalle"
            Begin Extent = 
               Top = 12
               Left = 363
               Bottom = 208
               Right = 572
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "iItemsMovimientos"
            Begin Extent = 
               Top = 253
               Left = 530
               Bottom = 383
               Right = 739
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "iItemsProductos"
            Begin Extent = 
               Top = 285
               Left = 243
               Bottom = 415
               Right = 452
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "pProductoMovimiento"
            Begin Extent = 
               Top = 20
               Left = 688
               Bottom = 150
               Right = 897
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
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 1635
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
        ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vTransaccionesProduccion';

