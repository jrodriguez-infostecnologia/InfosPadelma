CREATE VIEW dbo.[vSeleccionLaboresProuduccion]
AS
SELECT        a.empresa, a.año, a.mes, DATENAME(MONTH, a.fecha) AS nombreMes, a.fecha, a.tipo, f.descripcion AS nombreTransaccion, a.numero, a.referencia, a.finca, i.descripcion AS nombreFinca, a.remision, 
                         a.observacion, a.fechaRegistro, CASE WHEN a.anulado = 0 THEN 'Aprobado' ELSE 'Anulado' END AS estado, a.fechaAnulado, b.novedad AS codLabor, b.registro AS registroLabor, b.uMedida, b.seccion, 
                         b.lote AS codLote, k.descripcion AS nombreLote, b.fecha AS fechaLabor, CASE WHEN b.signo = 1 THEN b.cantidad ELSE b.cantidad * - 1 END AS cantidadLabor, b.jornales AS jornalLabor, 
                         b.racimos AS racimoLabor, b.saldo AS saldoLabor, b.ejecutado, b.signo, a.anulado, k.añoSiembra, k.mesSiembra, k.palmasBrutas, k.palmasProduccion, k.hBrutas, k.hNetas, d.desCorta, d.claseLabor
FROM            dbo.aTransaccion AS a LEFT OUTER JOIN
                         dbo.aTransaccionNovedad AS b ON b.numero = a.numero AND b.tipo = a.tipo AND b.empresa = a.empresa LEFT OUTER JOIN
                         dbo.aNovedad AS d ON b.novedad = d.codigo AND d.empresa = b.empresa LEFT OUTER JOIN
                         dbo.gTipoTransaccion AS f ON f.codigo = a.tipo AND f.empresa = a.empresa LEFT OUTER JOIN
                         dbo.aFinca AS i ON i.codigo = a.finca AND i.empresa = a.empresa LEFT OUTER JOIN
                         dbo.aLotes AS k ON k.codigo = b.lote AND k.empresa = b.empresa
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vSeleccionLaboresProuduccion';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'Output = 720
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vSeleccionLaboresProuduccion';


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
               Right = 494
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "d"
            Begin Extent = 
               Top = 6
               Left = 532
               Bottom = 136
               Right = 741
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "f"
            Begin Extent = 
               Top = 6
               Left = 779
               Bottom = 136
               Right = 988
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "i"
            Begin Extent = 
               Top = 6
               Left = 1026
               Bottom = 136
               Right = 1235
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "k"
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
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vSeleccionLaboresProuduccion';

