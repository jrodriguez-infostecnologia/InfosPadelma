CREATE VIEW dbo.vPrecontabilizacionNomina
AS
SELECT        a.empresa, a.tipo, a.año, a.mes, a.periodoContable, a.registro, a.codigoEmpleado, a.identificacionEmpleado, b.descripcion AS desEmpleado, a.tipoNomina, a.docNomina, a.contrato AS noContrato, 
                         a.claseContrato, d.descripcion, d.electivaProduccion AS sena, a.periodoNomina, 'Periodo del: ' + CONVERT(varchar(50), c.fechaInicial, 112) + ' Hasta: ' + CONVERT(varchar(50), c.fechaFinal, 112) AS desPeriodo, 
                         a.manejaLabCam, a.manejaHE, a.mCcostoNomina, e.descripcion AS desmCcostoNomina, a.aCcostoNomina, f.descripcion AS desaCcostoNomina, a.departamento, g.descripcion AS desDepartamento, 
                         a.codigoConcepto, h.descripcion AS desConcepto, a.codigoLabor, i.descripcion AS desLabor, a.cuentaContable, j.nombre AS desCuentaContable, a.mCcostoContable, k.descripcion AS desmCCostoContable, 
                         a.aCcostoContable, l.descripcion AS desaCCostoContable, a.terceroContable, UPPER
                             ((SELECT        TOP (1) razonSocial
                                 FROM            dbo.cTercero
                                 WHERE        (a.terceroContable = codigo) AND (empresa = a.empresa) AND (codigo <> ''))) AS desTerceroContable, a.debito, a.credito, a.LoteDesarrollo, ISNULL(a.tipoConcepto, '') AS tipoConcepto, 
                         CASE WHEN a.debito > 0 THEN 'D' ELSE 'C' END AS naturaleza
FROM            dbo.cPrecontabilizacion AS a LEFT OUTER JOIN
                         dbo.cTercero AS b ON a.codigoEmpleado = b.id AND a.empresa = b.empresa LEFT OUTER JOIN
                         dbo.nPeriodoDetalle AS c ON c.noPeriodo = a.periodoNomina AND c.año = a.año AND a.empresa = c.empresa LEFT OUTER JOIN
                         dbo.nClaseContrato AS d ON d.codigo = a.claseContrato AND d.empresa = a.empresa LEFT OUTER JOIN
                         dbo.cCentrosCosto AS e ON a.mCcostoNomina = e.codigo AND a.empresa = e.empresa LEFT OUTER JOIN
                         dbo.cCentrosCosto AS f ON a.aCcostoNomina = f.codigo AND a.empresa = f.empresa LEFT OUTER JOIN
                         dbo.nDepartamento AS g ON a.departamento = g.codigo AND g.empresa = a.empresa LEFT OUTER JOIN
                         dbo.nConcepto AS h ON a.codigoConcepto = h.codigo AND h.empresa = a.empresa LEFT OUTER JOIN
                         dbo.aNovedad AS i ON a.codigoLabor = i.codigo AND a.empresa = i.empresa LEFT OUTER JOIN
                         dbo.cPuc AS j ON j.codigo = a.cuentaContable AND j.empresa = a.empresa LEFT OUTER JOIN
                         dbo.cCentrosCostoSigo AS k ON k.codigo = a.mCcostoContable AND k.empresa = a.empresa LEFT OUTER JOIN
                         dbo.cCentrosCostoSigo AS l ON l.codigo = a.aCcostoContable AND l.empresa = a.empresa AND l.auxiliar = 1 AND l.mayor = k.codigo
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vPrecontabilizacionNomina';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'      Begin Table = "h"
            Begin Extent = 
               Top = 138
               Left = 285
               Bottom = 268
               Right = 501
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "i"
            Begin Extent = 
               Top = 138
               Left = 539
               Bottom = 268
               Right = 748
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "j"
            Begin Extent = 
               Top = 138
               Left = 786
               Bottom = 268
               Right = 995
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "k"
            Begin Extent = 
               Top = 138
               Left = 1033
               Bottom = 268
               Right = 1242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "l"
            Begin Extent = 
               Top = 138
               Left = 1280
               Bottom = 268
               Right = 1489
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vPrecontabilizacionNomina';


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
               Right = 254
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 6
               Left = 292
               Bottom = 136
               Right = 501
            End
            DisplayFlags = 280
            TopColumn = 0
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
               Top = 6
               Left = 786
               Bottom = 136
               Right = 995
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "e"
            Begin Extent = 
               Top = 6
               Left = 1033
               Bottom = 136
               Right = 1242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "f"
            Begin Extent = 
               Top = 6
               Left = 1280
               Bottom = 136
               Right = 1489
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "g"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
   ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vPrecontabilizacionNomina';

