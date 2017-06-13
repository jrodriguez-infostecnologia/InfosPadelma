CREATE VIEW dbo.vSeleccionaPreliquidacion
AS
SELECT        SUBSTRING(CONVERT(varchar, CONVERT(money, RTRIM(c.codigo)), 1), 1, LEN(CONVERT(varchar, CONVERT(money, RTRIM(c.codigo)), 1)) - 3) AS identificacion, c.id AS codTercero, 
                         c.razonSocial AS nombreTercero, d.codigo AS codCCosto, d.descripcion AS nombreCcosto, e.salario AS sueldo, f.descripcion AS nombreCargo, a.concepto AS codConcepto, b.descripcion AS nombreConcepto, 
                         CASE WHEN b.noMostrar = 1 THEN a.cantidadPadelma ELSE a.cantidad END AS cantidad, CASE WHEN b.noMostrar = 1 THEN a.valorPadelma ELSE a.valorTotal END AS valorConcepto, a.saldo, a.noPeriodo, 
                         a.fecha, a.fechaInical, a.fechaFinal, a.año, a.mes, CONVERT(varchar(4), a.año) + RTRIM(RIGHT('00' + RTRIM(a.mes), 2)) AS periodoUnido, DATENAME(MONTH, a.fecha) AS nombreMes, 
                         g.descripcion AS nombreDepartamento, g.codigo AS codDepto, a.signo, a.empresa, e.entidadEps, e.entidadPension, h.razonSocial AS nombreEPS, 
                         CASE WHEN e.entidadPension = '' THEN '' ELSE i.razonSocial END AS nombrePension, b.prioridad, b.mostrarFecha, b.noMostrar, b.mostrarDetalle, a.tipoConcepto, a.desTipoConcepto, b.mostrarCantidad
FROM            dbo.tmpliquidacionNomina AS a LEFT OUTER JOIN
                         dbo.nConcepto AS b ON a.concepto = b.codigo AND a.empresa = b.empresa LEFT OUTER JOIN
                         dbo.cTercero AS c ON c.id = a.tercero AND c.empresa = a.empresa LEFT OUTER JOIN
                         dbo.cCentrosCosto AS d ON d.codigo = a.ccosto AND d.empresa = a.empresa LEFT OUTER JOIN
                         dbo.nContratos AS e ON e.tercero = a.tercero AND e.empresa = a.empresa AND e.id = a.noContrato LEFT OUTER JOIN
                         dbo.nCargo AS f ON f.codigo = e.cargo AND f.empresa = e.empresa LEFT OUTER JOIN
                         dbo.nDepartamento AS g ON g.codigo = e.departamento AND g.empresa = e.empresa LEFT OUTER JOIN
                         dbo.nEntidadEps AS j ON j.codigo = e.entidadEps AND j.empresa = e.empresa LEFT OUTER JOIN
                         dbo.nEntidadFondoPension AS k ON k.codigo = e.entidadPension AND k.empresa = e.empresa LEFT OUTER JOIN
                         dbo.cTercero AS h ON h.id = j.tercero AND h.empresa = e.empresa LEFT OUTER JOIN
                         dbo.cTercero AS i ON i.id = k.tercero AND i.empresa = e.empresa
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'       Begin Table = "j"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 532
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "k"
            Begin Extent = 
               Top = 402
               Left = 285
               Bottom = 532
               Right = 494
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
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vSeleccionaPreliquidacion';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vSeleccionaPreliquidacion';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[9] 2[32] 3) )"
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
               Right = 501
            End
            DisplayFlags = 280
            TopColumn = 32
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 539
               Bottom = 136
               Right = 748
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
               Right = 512
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "f"
            Begin Extent = 
               Top = 138
               Left = 550
               Bottom = 268
               Right = 759
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
  ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vSeleccionaPreliquidacion';

