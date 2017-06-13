CREATE VIEW dbo.vSeleccionaPagosNomina
AS
SELECT        b.item, b.codigoBanco, c.descripcion AS nombreBanco, b.tercero, d.codigo AS identificacion, d.descripcion AS nombreTercero, b.claseContrato, e.descripcion AS nombreCalseContrato, f.cuentaBancaria, 
                         b.valorPago, d.direccion, f.tipoCuenta, g.descripcion AS nombreTipoCuenta, a.empresa, a.periodoNomina AS noPeriodo, a.año, a.mes, b.documentoNomina AS numero, b.noCheque, b.formaPago, a.anulado
FROM            dbo.nPagosNomina AS a INNER JOIN
                         dbo.nPagosNominaDetalle AS b ON a.año = b.año AND a.mes = b.mes AND a.periodoNomina = b.periodoNomina AND a.registro = b.registro AND a.empresa = b.empresa INNER JOIN
                         dbo.gBanco AS c ON c.codigo = a.Banco AND c.empresa = b.empresa INNER JOIN
                         dbo.cTercero AS d ON d.id = b.tercero AND d.empresa = b.empresa INNER JOIN
                         dbo.nClaseContrato AS e ON e.codigo = b.claseContrato AND e.empresa = b.empresa INNER JOIN
                         dbo.nContratos AS f ON f.tercero = b.tercero AND f.empresa = b.empresa AND f.id = b.noContrato INNER JOIN
                         dbo.gTipoCuenta AS g ON g.codigo = f.tipoCuenta AND g.empresa = f.empresa
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vSeleccionaPagosNomina';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'     End
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vSeleccionaPagosNomina';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[8] 2[24] 3) )"
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
         Left = -96
      End
      Begin Tables = 
         Begin Table = "a"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 263
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 25
               Left = 619
               Bottom = 137
               Right = 844
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "e"
            Begin Extent = 
               Top = 114
               Left = 28
               Bottom = 283
               Right = 253
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "f"
            Begin Extent = 
               Top = 138
               Left = 301
               Bottom = 267
               Right = 544
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "g"
            Begin Extent = 
               Top = 252
               Left = 582
               Bottom = 364
               Right = 807
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "d"
            Begin Extent = 
               Top = 0
               Left = 335
               Bottom = 129
               Right = 560
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 6
               Left = 301
               Bottom = 211
               Right = 526
            End
            DisplayFlags = 280
            TopColumn = 0
         End
 ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vSeleccionaPagosNomina';

