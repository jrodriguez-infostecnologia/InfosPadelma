CREATE VIEW dbo.vLiquidacionCesancias
AS
SELECT        a.empresa, a.tipo, a.numero, a.año, a.mes, a.fecha, a.fechaRegistro, a.usuario, a.anulado, a.cerrado, a.estado, a.observacion, a.usuarioAnulado, a.fechaAnulado, b.registro, b.noPeriodo, b.tercero, b.concepto, 
                         b.fechaInicial, b.fechaFinal, b.ccosto, b.departamento, b.cantidad, b.porcentaje, b.valorUnitario, CASE WHEN s.signo = 1 THEN b.valorTotal ELSE b.valorTotal * - 1 END AS valorTotal, b.signo, b.saldo, b.noDias, 
                         b.entidad, b.contrato, b.basePrimas, b.baseCajaCompensacion, b.baseCesantias, b.baseVacaciones, b.baseIntereses, b.baseSeguridadSocial, b.manejaRango, b.baseEmbargo, b.noPrestamo, b.cantidadR, 
                         b.valorTotalR, dbo.nContratos.banco, dbo.nContratos.cuentaBancaria, dbo.nContratos.tipoCuenta, dbo.nContratos.claseContrato, dbo.gBanco.descripcion AS nombreBanco, 
                         dbo.nClaseContrato.descripcion AS nombreCalseContrato, dbo.nContratos.codigoTercero, dbo.cTercero.id, dbo.cTercero.razonSocial AS nombreTercero, dbo.cTercero.direccion, 
                         dbo.gTipoCuenta.descripcion AS nombreTipoCuenta, dbo.nContratos.formaPago, dbo.nContratos.entidadPension, dbo.nContratos.entidadEps, dbo.nContratos.entidadCesantias, dbo.nContratos.entidadCaja, 
                         dbo.nContratos.entidadArp, dbo.nContratos.entidadSena, dbo.nContratos.entidadIcbf, dbo.nContratos.fechaIngreso, dbo.nContratos.fechaRetiro, dbo.nCargo.codigo AS codigoCago, 
                         dbo.nCargo.descripcion AS nombreCargo, dbo.cTercero.codigo, dbo.nContratos.salario, dbo.nContratos.departamento AS codDepartamento, b.fecha AS fechaLabor, s.tipoLiquidacion, 
                         dbo.nContratos.tipoContizante, dbo.nContratos.subTipoCotizante, dbo.nParametrosTipoCotizante.salud, dbo.nParametrosTipoCotizante.pension, dbo.nParametrosTipoCotizante.fondoSolidaridad, 
                         dbo.nParametrosTipoCotizante.arp, dbo.nParametrosTipoCotizante.caja, dbo.nParametrosTipoCotizante.sena, dbo.nParametrosTipoCotizante.icbf, dbo.nClaseContrato.electivaProduccion, 
                         dbo.nClaseContrato.porcentajeSS, dbo.nCentroTrabajo.codigo AS centroTrabajo
FROM            dbo.nLiquidacionNomina AS a INNER JOIN
                         dbo.nLiquidacionNominaDetalle AS b ON b.numero = a.numero AND b.tipo = a.tipo AND b.empresa = a.empresa INNER JOIN
                         dbo.nContratos ON a.empresa = dbo.nContratos.empresa AND b.tercero = dbo.nContratos.tercero AND b.contrato = dbo.nContratos.id INNER JOIN
                         dbo.gBanco ON a.empresa = dbo.gBanco.empresa AND dbo.nContratos.banco = dbo.gBanco.codigo INNER JOIN
                         dbo.nClaseContrato ON a.empresa = dbo.nClaseContrato.empresa AND dbo.nContratos.claseContrato = dbo.nClaseContrato.codigo INNER JOIN
                         dbo.cTercero ON a.empresa = dbo.cTercero.empresa AND dbo.nContratos.tercero = dbo.cTercero.id INNER JOIN
                         dbo.gTipoCuenta ON a.empresa = dbo.gTipoCuenta.empresa AND dbo.nContratos.tipoCuenta = dbo.gTipoCuenta.codigo INNER JOIN
                         dbo.nCargo ON dbo.nContratos.empresa = dbo.nCargo.empresa AND dbo.nContratos.cargo = dbo.nCargo.codigo INNER JOIN
                         dbo.nConcepto AS s ON s.codigo = b.concepto AND s.empresa = b.empresa LEFT OUTER JOIN
                         dbo.nCentroTrabajo ON a.empresa = dbo.nCentroTrabajo.empresa AND dbo.nContratos.centroTrabajo = dbo.nCentroTrabajo.codigo LEFT OUTER JOIN
                         dbo.nTipoCotizante ON dbo.nContratos.empresa = dbo.nTipoCotizante.empresa AND dbo.nContratos.tipoContizante = dbo.nTipoCotizante.codigo LEFT OUTER JOIN
                         dbo.nSubTipoCotizante ON dbo.nContratos.empresa = dbo.nSubTipoCotizante.empresa AND dbo.nContratos.subTipoCotizante = dbo.nSubTipoCotizante.codigo LEFT OUTER JOIN
                         dbo.nParametrosTipoCotizante ON a.empresa = dbo.nParametrosTipoCotizante.empresa AND dbo.nTipoCotizante.codigo = dbo.nParametrosTipoCotizante.tipoCotizante AND 
                         dbo.nSubTipoCotizante.codigo = dbo.nParametrosTipoCotizante.subTipoCotizante
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vLiquidacionCesancias';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'
            TopColumn = 0
         End
         Begin Table = "nCargo"
            Begin Extent = 
               Top = 138
               Left = 285
               Bottom = 268
               Right = 494
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "s"
            Begin Extent = 
               Top = 138
               Left = 532
               Bottom = 268
               Right = 748
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "nCentroTrabajo"
            Begin Extent = 
               Top = 138
               Left = 1051
               Bottom = 268
               Right = 1260
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "nTipoCotizante"
            Begin Extent = 
               Top = 252
               Left = 38
               Bottom = 382
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "nSubTipoCotizante"
            Begin Extent = 
               Top = 252
               Left = 786
               Bottom = 382
               Right = 995
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "nParametrosTipoCotizante"
            Begin Extent = 
               Top = 270
               Left = 285
               Bottom = 400
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vLiquidacionCesancias';


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
         Begin Table = "nContratos"
            Begin Extent = 
               Top = 6
               Left = 539
               Bottom = 136
               Right = 766
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "gBanco"
            Begin Extent = 
               Top = 6
               Left = 804
               Bottom = 119
               Right = 1013
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "nClaseContrato"
            Begin Extent = 
               Top = 6
               Left = 1051
               Bottom = 136
               Right = 1260
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cTercero"
            Begin Extent = 
               Top = 120
               Left = 804
               Bottom = 250
               Right = 1013
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "gTipoCuenta"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 251
               Right = 247
            End
            DisplayFlags = 280', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vLiquidacionCesancias';

