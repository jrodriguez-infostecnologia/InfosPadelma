CREATE VIEW dbo.vTransaccionesCampoLiquidacion
AS
SELECT        a.año, a.mes, a.fecha, b.novedad, b.uMedida, b.lote, c.registro AS registroTercero, c.registroNovedad, CASE WHEN b.signo = 1 THEN c.cantidad ELSE c.cantidad * - 1 END AS cantidadTercero, 
                         c.jornales AS jornalesTercero, d.concepto, c.precioLabor, f.codigo AS idConcepto, f.descripcion AS desConcepto, f.abreviatura, f.signo, f.tipoLiquidacion, f.base, f.porcentaje AS porcConcepto, f.valor, 
                         f.valorMinimo, f.basePrimas, f.baseCajaCompensacion, f.baseCesantias, f.baseVacaciones, f.baseIntereses, f.baseSeguridadSocial, f.controlaSaldo, f.manejaRango AS manjaRangoConcepto, f.ingresoGravado, 
                         f.controlConcepto, f.validaPorcentaje, f.fijo, f.baseEmbargo, f.prioridad, f.descuentaDomingo, f.descuentaTransporte, a.tipo, a.numero, b.seccion, MAX(h.salario) AS salario, c.tercero, b.fecha AS fechaNovedad, 
                         a.empresa, CASE WHEN d .naturaleza = 2 OR
                         b.signo = 2 THEN (c.valorTotal * - 1) ELSE c.valorTotal END AS valorTotal, c.ejecutado, a.anulado, d.claseLabor, MAX(h.id) AS contrato, c.periodo, c.contrato AS Expr1
FROM            dbo.aTransaccion AS a INNER JOIN
                         dbo.aTransaccionNovedad AS b ON a.numero = b.numero AND a.tipo = b.tipo AND a.empresa = b.empresa INNER JOIN
                         dbo.aTransaccionTercero AS c ON c.numero = b.numero AND c.tipo = b.tipo AND c.empresa = b.empresa AND c.registroNovedad = b.registro INNER JOIN
                         dbo.aNovedad AS d ON b.novedad = d.codigo AND b.empresa = d.empresa INNER JOIN
                         dbo.nConcepto AS f ON d.concepto = f.codigo AND f.empresa = d.empresa INNER JOIN
                         dbo.nContratos AS h ON h.tercero = c.tercero AND h.empresa = c.empresa AND h.id = c.contrato
WHERE        (a.anulado = 0)
GROUP BY a.año, a.mes, a.fecha, b.novedad, b.uMedida, b.lote, c.registro, c.registroNovedad, b.signo, c.cantidad, c.jornales, d.concepto, c.precioLabor, f.codigo, f.descripcion, f.abreviatura, f.signo, f.tipoLiquidacion, f.base, 
                         f.porcentaje, f.valor, f.valorMinimo, f.basePrimas, f.baseCajaCompensacion, f.baseCesantias, f.baseVacaciones, f.baseIntereses, f.baseSeguridadSocial, f.controlaSaldo, f.manejaRango, f.ingresoGravado, 
                         f.controlConcepto, f.validaPorcentaje, f.fijo, f.baseEmbargo, f.prioridad, f.descuentaDomingo, f.descuentaTransporte, a.tipo, a.numero, b.seccion, c.tercero, b.fecha, a.empresa, d.naturaleza, c.valorTotal, 
                         c.ejecutado, a.anulado, d.claseLabor, c.periodo, c.contrato
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vTransaccionesCampoLiquidacion';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'00
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 13170
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vTransaccionesCampoLiquidacion';


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
            TopColumn = 17
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
               Bottom = 211
               Right = 741
            End
            DisplayFlags = 280
            TopColumn = 13
         End
         Begin Table = "d"
            Begin Extent = 
               Top = 6
               Left = 779
               Bottom = 343
               Right = 988
            End
            DisplayFlags = 280
            TopColumn = 19
         End
         Begin Table = "f"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 254
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "h"
            Begin Extent = 
               Top = 138
               Left = 292
               Bottom = 268
               Right = 519
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
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 15', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vTransaccionesCampoLiquidacion';

