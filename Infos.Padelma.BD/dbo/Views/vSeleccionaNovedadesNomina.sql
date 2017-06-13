CREATE VIEW dbo.vSeleccionaNovedadesNomina
AS
SELECT        a.empresa, a.tipo, a.numero, a.fecha AS fechatransaccion, a.ccosto AS codccostocab, c.descripcion AS ccostocab, a.observacion, a.anulado, a.concepto AS codconceptocab, d.descripcion AS conceptocap, 
                         b.registro, b.concepto AS codconceptodet, e.descripcion AS conceptodet, b.empleado AS codempleado, f.razonSocial AS empleado, b.cantidad, b.valor, b.añoInicial, b.añoFinal, b.periodoInicial, b.periodoFinal, 
                         b.frecuencia, b.detalle, b.liquidada, b.anulado AS Expr1
FROM            dbo.nNovedades AS a INNER JOIN
                         dbo.nNovedadesDetalle AS b ON a.tipo = b.tipo AND a.numero = b.numero AND a.empresa = b.empresa LEFT OUTER JOIN
                         dbo.cCentrosCosto AS c ON a.ccosto = c.codigo AND a.empresa = b.empresa LEFT OUTER JOIN
                         dbo.nConcepto AS d ON a.concepto = d.codigo AND d.empresa = a.empresa LEFT OUTER JOIN
                         dbo.nConcepto AS e ON b.concepto = e.codigo AND e.empresa = a.empresa LEFT OUTER JOIN
                         dbo.cTercero AS f ON b.empleado = f.id AND f.empresa = a.empresa
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
               Right = 507
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 545
               Bottom = 136
               Right = 754
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "d"
            Begin Extent = 
               Top = 6
               Left = 792
               Bottom = 136
               Right = 1008
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "e"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 254
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "f"
            Begin Extent = 
               Top = 138
               Left = 292
               Bottom = 268
               Right = 501
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
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
        ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vSeleccionaNovedadesNomina';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vSeleccionaNovedadesNomina';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N' Output = 720
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vSeleccionaNovedadesNomina';

