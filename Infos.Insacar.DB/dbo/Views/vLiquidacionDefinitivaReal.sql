CREATE VIEW dbo.vLiquidacionDefinitivaReal
AS
SELECT        a.empresa, SUBSTRING(CONVERT(varchar, CONVERT(money, RTRIM(tt.codigo)), 1), 1, LEN(CONVERT(varchar, CONVERT(money, RTRIM(tt.codigo)), 1)) - 3) AS identificacion, b.tercero AS codTercero, tt.descripcion, 
                         ISNULL(c.sueldo, cc.salario) AS sueldo, b.concepto AS codConcepto, s.descripcion AS Expr1, a.tipo, a.numero, a.año, a.mes, a.fecha, a.fechaRegistro, a.usuario, a.anulado, a.cerrado, a.estado, a.observacion, 
                         a.usuarioAnulado, a.fechaAnulado, b.noPeriodo, b.fechaInicial, b.fechaFinal, CASE WHEN s.noMostrar = 1 THEN b.cantidadR ELSE b.cantidad END AS cantidad, b.porcentaje, b.valorUnitario, 
                         CASE WHEN s.noMostrar = 1 THEN b.valorTotalR ELSE b.valorTotal END AS valorTotal, b.signo, b.saldo, b.noDias, b.entidad, b.contrato, b.basePrimas, b.baseCajaCompensacion, b.baseCesantias, 
                         b.baseVacaciones, b.baseIntereses, b.baseSeguridadSocial, b.manejaRango, b.baseEmbargo, b.noPrestamo, b.cantidadR, b.valorTotalR, cc.banco, cc.cuentaBancaria, cc.tipoCuenta, cc.claseContrato, 
                         bb.descripcion AS nombreBanco, cl.descripcion AS Expr2, tt.direccion, tc.descripcion AS nombreTipoCuenta, cc.formaPago, cc.entidadPension, cc.entidadEps, cc.entidadCesantias, cc.entidadCaja, cc.entidadArp, 
                         cc.entidadSena, cc.entidadIcbf, cc.fechaIngreso, cc.fechaRetiro, dbo.nCargo.codigo AS codigoCago, dbo.nCargo.descripcion AS Expr3, tt.codigo, cc.salario, cc.departamento, b.fecha AS Expr4, tt.codigo AS Expr5, 
                         s.noMostrar, s.prioridad, s.mostrarFecha, s.mostrarDetalle, b.tipoConcepto, b.desTipoConcepto, cc.fechaContratoHasta, cc.terminoContrato, cc.motivoRetiro, cc.tipoContizante, cc.tipoNomina, cc.salarioAnterior, 
                         cc.auxilioTransporte, cc.id, s.prestacionSocial, s.mostrarCantidad, d.codigo AS codCCosto, d.descripcion AS nombreCcosto, g.descripcion AS nombreDepartamento, g.codigo AS codDepto, ISNULL(c.entidadEps, 
                         cc.entidadEps) AS Expr6, ISNULL(c.entidadPension, cc.entidadPension) AS Expr7, ISNULL(h.razonSocial, '') AS nombreEPS, ISNULL(i.razonSocial, '') AS nombrePension, b.valorTotal AS vTotalNR
FROM            dbo.nLiquidacionNomina AS a INNER JOIN
                         dbo.nLiquidacionNominaDetalle AS b ON b.numero = a.numero AND b.tipo = a.tipo AND b.empresa = a.empresa INNER JOIN
                         dbo.cTercero AS tt ON a.empresa = tt.empresa AND tt.id = b.tercero INNER JOIN
                         dbo.nConcepto AS s ON s.codigo = b.concepto AND s.empresa = b.empresa INNER JOIN
                         dbo.nContratos AS cc ON a.empresa = cc.empresa AND b.tercero = cc.tercero AND b.contrato = cc.id INNER JOIN
                         dbo.cCentrosCosto AS d ON d.codigo = b.ccosto AND d.empresa = a.empresa INNER JOIN
                         dbo.gBanco AS bb ON a.empresa = bb.empresa AND cc.banco = bb.codigo INNER JOIN
                         dbo.nClaseContrato AS cl ON a.empresa = cl.empresa AND cc.claseContrato = cl.codigo INNER JOIN
                         dbo.gTipoCuenta AS tc ON a.empresa = tc.empresa AND cc.tipoCuenta = tc.codigo INNER JOIN
                         dbo.nCargo ON cc.empresa = dbo.nCargo.empresa AND cc.cargo = dbo.nCargo.codigo LEFT OUTER JOIN
                         dbo.nLiquidacionNominaDatos AS c ON c.numero = a.numero AND c.empresa = a.empresa AND c.tipo = b.tipo AND c.tercero = b.tercero LEFT OUTER JOIN
                         dbo.nDepartamento AS g ON g.codigo = b.departamento AND g.empresa = a.empresa LEFT OUTER JOIN
                         dbo.nEntidadEps AS j ON j.codigo = c.entidadEps AND j.empresa = a.empresa LEFT OUTER JOIN
                         dbo.nEntidadFondoPension AS k ON k.codigo = c.entidadPension AND k.empresa = a.empresa LEFT OUTER JOIN
                         dbo.cTercero AS h ON h.id = j.tercero AND h.empresa = a.empresa LEFT OUTER JOIN
                         dbo.cTercero AS i ON i.id = k.tercero AND i.empresa = a.empresa
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vLiquidacionDefinitivaReal';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'
         Begin Table = "cl"
            Begin Extent = 
               Top = 138
               Left = 532
               Bottom = 268
               Right = 741
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tc"
            Begin Extent = 
               Top = 138
               Left = 779
               Bottom = 251
               Right = 988
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "nCargo"
            Begin Extent = 
               Top = 138
               Left = 1026
               Bottom = 268
               Right = 1235
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 252
               Left = 285
               Bottom = 382
               Right = 494
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "g"
            Begin Extent = 
               Top = 252
               Left = 779
               Bottom = 382
               Right = 988
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "j"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 400
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "k"
            Begin Extent = 
               Top = 270
               Left = 532
               Bottom = 400
               Right = 741
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "h"
            Begin Extent = 
               Top = 270
               Left = 1026
               Bottom = 400
               Right = 1235
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "i"
            Begin Extent = 
               Top = 384
               Left = 285
               Bottom = 514
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vLiquidacionDefinitivaReal';


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
               Right = 501
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tt"
            Begin Extent = 
               Top = 6
               Left = 539
               Bottom = 136
               Right = 748
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "s"
            Begin Extent = 
               Top = 6
               Left = 786
               Bottom = 136
               Right = 1002
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cc"
            Begin Extent = 
               Top = 6
               Left = 1040
               Bottom = 136
               Right = 1267
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
         Begin Table = "bb"
            Begin Extent = 
               Top = 138
               Left = 285
               Bottom = 251
               Right = 494
            End
            DisplayFlags = 280
            TopColumn = 0
         End', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vLiquidacionDefinitivaReal';

