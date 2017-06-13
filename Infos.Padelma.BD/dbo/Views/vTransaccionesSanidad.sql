/*where a.empresa=1 */
CREATE VIEW dbo.vTransaccionesSanidad
AS
SELECT        a.empresa, a.tipo, a.numero, a.fecha AS fechaT, a.finca AS codFinca, g.descripcion AS finca, a.seccion, a.remision, a.nota AS notaEncabezado, a.referencia, a.usuario, a.fechaRegistro, a.anulado, a.fechaAnulado, 
                         a.usuarioAprobado, a.fechaAprobado, aa.registro, aa.fecha AS fechaL, a.lote, aa.linea, aa.palma, aa.item AS idNovedad, h.descripcion AS Novedad, aa.uMedida, aa.cantidad, aa.detalle AS notaDetalle, 
                         aa.ejecutado, aa.usuarioEjecturado, aa.naturaleza, aa.caracteristica AS codCaracteristica, f.descripcion AS caracteristica, aa.grupoCaracteristica AS codGruCara, e.descripcion AS grupoCaracteristica
FROM            dbo.aSanidad AS a INNER JOIN
                         dbo.aSanidadDetalle AS aa ON a.numero = aa.numero AND a.tipo = aa.tipo AND a.empresa = aa.empresa INNER JOIN
                         dbo.aNovedad AS b ON aa.item = b.codigo AND a.empresa = b.empresa LEFT OUTER JOIN
                         dbo.aLotes AS c ON a.lote = c.codigo AND a.empresa = c.empresa LEFT OUTER JOIN
                         dbo.aSecciones AS d ON a.seccion = d.codigo AND d.empresa = a.empresa LEFT OUTER JOIN
                         dbo.aGrupoCaracteristica AS e ON e.codigo = aa.grupoCaracteristica AND aa.empresa = e.empresa LEFT OUTER JOIN
                         dbo.aCaracteristica AS f ON f.codigo = aa.caracteristica AND aa.empresa = e.empresa INNER JOIN
                         dbo.aFinca AS g ON a.finca = g.codigo AND a.empresa = g.empresa INNER JOIN
                         dbo.aNovedad AS h ON aa.item = h.codigo AND aa.empresa = h.empresa
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vTransaccionesSanidad';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'       Begin Table = "g"
            Begin Extent = 
               Top = 138
               Left = 779
               Bottom = 268
               Right = 988
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "h"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 400
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vTransaccionesSanidad';


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
         Begin Table = "aa"
            Begin Extent = 
               Top = 6
               Left = 285
               Bottom = 136
               Right = 494
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 6
               Left = 532
               Bottom = 136
               Right = 741
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 779
               Bottom = 136
               Right = 988
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "d"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "e"
            Begin Extent = 
               Top = 138
               Left = 285
               Bottom = 268
               Right = 494
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "f"
            Begin Extent = 
               Top = 138
               Left = 532
               Bottom = 268
               Right = 741
            End
            DisplayFlags = 280
            TopColumn = 0
         End
  ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vTransaccionesSanidad';

