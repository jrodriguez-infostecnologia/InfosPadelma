CREATE VIEW dbo.vTransaccionAgronomico
AS
SELECT DISTINCT 
                         a.empresa AS codEmpresa, h.razonSocial AS nombreEmpresa, a.año, a.mes, DATENAME(MONTH, a.fecha) AS nombreMes, a.fecha AS fechaTransaccion, a.tipo AS codtransaccion, 
                         f.descripcion AS nombreTransaccion, a.numero AS numeroTransaccion, a.referencia, a.finca AS codFinca, i.descripcion AS nombreFinca, a.remision, a.observacion, a.fechaRegistro, 
                         g.descripcion AS usuarioRegistro, CASE WHEN a.anulado = 0 THEN 'Aprobado' ELSE 'Anulado' END AS estado, j.descripcion AS usuarioAnulado, a.fechaAnulado, b.novedad AS codLabor, 
                         b.registro AS registroLabor, b.uMedida, b.seccion, b.lote AS codLote, k.descripcion AS nombreLote, b.fecha AS fechaLabor, CASE WHEN b.signo = 1 THEN b.cantidad ELSE b.cantidad * - 1 END AS cantidadLabor, 
                         b.jornales AS jornalLabor, b.racimos AS racimoLabor, b.saldo AS saldoLabor, b.ejecutado, b.signo, c.registro AS registroTercero, c.tercero AS idTercero, SUBSTRING(CONVERT(varchar, CONVERT(money, 
                         RTRIM(e.codigo)), 1), 1, LEN(CONVERT(varchar, CONVERT(money, RTRIM(e.codigo)), 1)) - 3) AS codTercero, e.descripcion AS nombreTercero, 
                         CASE WHEN b.signo = 1 THEN c.cantidad ELSE c.cantidad * - 1 END AS cantidadTercero, c.jornales AS jornalTercero, c.precioLabor, n.codigo AS codCargo, n.descripcion AS nombreCargo, o.codigo AS codCCosto, 
                         o.descripcion AS nombreCCosto, d.descripcion AS nombreLabor, a.anulado, l.codigo AS codConcepto, l.descripcion AS nombreConcepto, 
                         CASE WHEN b.signo = 1 THEN c.valorTotal ELSE c.valorTotal * - 1 END AS valorTotalTercero, k.añoSiembra, k.palmasBrutas, k.palmasProduccion, x.codigo AS codGrupoLabor, 
                         x.descripcion AS nombreGrupoLabor, c.contrato
FROM            dbo.aTransaccion AS a INNER JOIN
                         dbo.aTransaccionNovedad AS b ON b.numero = a.numero AND b.tipo = a.tipo AND b.empresa = a.empresa INNER JOIN
                         dbo.aTransaccionTercero AS c ON c.numero = b.numero AND c.tipo = b.tipo AND c.empresa = b.empresa AND c.registroNovedad = b.registro INNER JOIN
                         dbo.aNovedad AS d ON b.novedad = d.codigo AND d.empresa = b.empresa INNER JOIN
                         dbo.aGrupoNovedad AS x ON x.codigo = d.grupo AND x.empresa = d.empresa INNER JOIN
                         dbo.nConcepto AS l ON l.codigo = d.concepto AND l.empresa = d.empresa INNER JOIN
                         dbo.cTercero AS e ON e.id = c.tercero AND e.empresa = c.empresa INNER JOIN
                         dbo.gTipoTransaccion AS f ON f.codigo = a.tipo AND f.empresa = a.empresa INNER JOIN
                         dbo.sUsuarios AS g ON g.usuario = a.usuarioRegistro INNER JOIN
                         dbo.gEmpresa AS h ON h.id = a.empresa LEFT OUTER JOIN
                         dbo.aFinca AS i ON i.codigo = a.finca AND i.empresa = a.empresa LEFT OUTER JOIN
                         dbo.nContratos AS m ON m.tercero = c.tercero AND m.empresa = c.empresa AND m.id = c.contrato LEFT OUTER JOIN
                         dbo.nCargo AS n ON n.codigo = m.cargo AND n.empresa = m.empresa LEFT OUTER JOIN
                         dbo.cCentrosCosto AS o ON o.codigo = c.ccosto AND o.empresa = m.empresa LEFT OUTER JOIN
                         dbo.aLotes AS k ON k.codigo = b.lote AND k.empresa = b.empresa LEFT OUTER JOIN
                         dbo.sUsuarios AS j ON j.usuario = a.usuarioAnulado
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vTransaccionAgronomico';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'      Begin Table = "f"
            Begin Extent = 
               Top = 138
               Left = 532
               Bottom = 268
               Right = 741
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "g"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 400
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "h"
            Begin Extent = 
               Top = 270
               Left = 285
               Bottom = 400
               Right = 494
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "i"
            Begin Extent = 
               Top = 270
               Left = 532
               Bottom = 400
               Right = 741
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "m"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 532
               Right = 265
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "n"
            Begin Extent = 
               Top = 402
               Left = 303
               Bottom = 532
               Right = 512
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "o"
            Begin Extent = 
               Top = 402
               Left = 550
               Bottom = 532
               Right = 759
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "k"
            Begin Extent = 
               Top = 10
               Left = 1044
               Bottom = 335
               Right = 1253
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "j"
            Begin Extent = 
               Top = 534
               Left = 285
               Bottom = 664
               Right = 494
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
         Alias = 1815
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vTransaccionAgronomico';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[38] 4[22] 2[28] 3) )"
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
               Top = 138
               Left = 38
               Bottom = 268
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "x"
            Begin Extent = 
               Top = 534
               Left = 38
               Bottom = 664
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "l"
            Begin Extent = 
               Top = 6
               Left = 779
               Bottom = 136
               Right = 995
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
   ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vTransaccionAgronomico';

