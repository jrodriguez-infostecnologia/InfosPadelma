CREATE VIEW dbo.vSeleccionaDatosSeguridadSocialPlano
AS
SELECT        aa.año, aa.mes, aa.registro, aa.idTercero, aa.codigoTercero AS Identificacion, bb.descripcion AS NombreEmpleado, aa.dPension, aa.IBCpension, aa.pPension, aa.valorPension AS vPension, 
                         aa.valorFondo AS vFondo, aa.valorFondoSub AS vFondoSub, aa.dSalud, aa.IBCsalud, aa.valorSalud AS vSalud, aa.pSalud, aa.IBCarp AS IBCarl, aa.pArp, aa.valorArp, aa.dArp, aa.dCaja, aa.IBCcaja, 
                         aa.valorCaja AS vCaja, aa.pCaja, aa.valorSena AS vSena, aa.valorIcbf AS vIcbf, aa.ING, aa.RET, aa.TDE, aa.TAE, aa.TDP, aa.TAP, aa.VSP, aa.VTE, aa.VST, aa.SLN, aa.IGE, aa.LMA, aa.VAC, aa.AVP, aa.VCT, aa.IRP, 
                         aa.exoneraSalud AS ExS, aa.empresa, aa.pFondo, bb.apellido1, bb.apellido2, bb.nombre1, bb.nombre2, bb.ciudad, dbo.nTipoCotizante.codigo AS tipoCotizante, 
                         dbo.nSubTipoCotizante.codigo AS subTipoCotizante, b.nit AS Nit_Salud, b.dv AS Dv_Salud, b.codigoNacional AS CN_Salud, b.razonSocial AS Razon_Social_Salud, c.nit AS Nit_Pension, c.dv AS Dv_Pension, 
                         c.codigoNacional AS CN_Pension, c.razonSocial AS Razon_Social_Pension, d.nit AS Nit_Caja, d.dv AS Dv_Caja, d.razonSocial AS Razon_Social_Caja, d.codigoNacional AS CN_Caja, e.nit AS Nit_ARP, 
                         e.dv AS Dv_ARP, e.razonSocial AS Razon_Social_ARP, e.codigoNacional AS CN_ARP, f.nit AS Nit_Sena, f.dv AS Dv_Sena, f.razonSocial AS Razon_Social, f.codigoNacional AS CN_Sena, g.nit AS Nit_ICBF, 
                         g.dv AS Dv_ICBF, g.razonSocial AS Razon_Social_ICBF, g.codigoNacional AS CN_ICBF, dbo.gEmpresa.nit AS Nit_Aportante, dbo.gEmpresa.dv AS DV_Aportante, 
                         dbo.gEmpresa.razonSocial AS Razon_Social_Aportante, SUBSTRING(bb.ciudad, 1, 2) AS Id_Dpto_Ubi_Labora, SUBSTRING(bb.ciudad, 3, LEN(bb.ciudad)) AS Id_Cuidad_Ubi_Labora, 
                         dbo.gTipoDocumento.descripcionCorta AS Abreviatura_Tipo_Documento, aa.salario, f.pAporte AS pSena, g.pAporte AS pICBF, b.tercero AS terceroEPS, c.tercero AS terceroPension, d.tercero AS terceroCaja, 
                         e.tercero AS terceroARP, f.tercero AS terceroSena, g.tercero AS terceroICBF
FROM            dbo.nSeguridadSocial AS aa INNER JOIN
                         dbo.cTercero AS bb ON bb.id = aa.idTercero AND bb.empresa = aa.empresa INNER JOIN
                         dbo.nContratos AS a ON a.tercero = aa.idTercero AND a.empresa = aa.empresa AND a.id =
                             (SELECT        MAX(id) AS Expr1
                               FROM            dbo.nContratos AS z
                               WHERE        (a.tercero = tercero) AND (a.empresa = empresa)) INNER JOIN
                         dbo.nCentroTrabajo AS h ON h.codigo = a.centroTrabajo AND h.empresa = a.empresa INNER JOIN
                         dbo.nSubTipoCotizante ON a.empresa = dbo.nSubTipoCotizante.empresa AND a.subTipoCotizante = dbo.nSubTipoCotizante.codigo INNER JOIN
                         dbo.nTipoCotizante ON a.empresa = dbo.nTipoCotizante.empresa AND a.tipoContizante = dbo.nTipoCotizante.codigo INNER JOIN
                         dbo.gEmpresa ON bb.empresa = dbo.gEmpresa.id INNER JOIN
                         dbo.gTipoDocumento ON aa.empresa = dbo.gTipoDocumento.empresa AND bb.tipoDocumento = dbo.gTipoDocumento.codigo LEFT OUTER JOIN
                         dbo.vEntidadEps AS b ON b.codigo = a.entidadEps AND b.empresa = a.empresa LEFT OUTER JOIN
                         dbo.vEntidadPension AS c ON c.codigo = a.entidadPension AND c.empresa = a.empresa LEFT OUTER JOIN
                         dbo.vEntidadCaja AS d ON d.codigo = a.entidadCaja AND d.empresa = a.empresa LEFT OUTER JOIN
                         dbo.vEntidadArp AS e ON e.codigo = a.entidadArp AND e.empresa = a.empresa LEFT OUTER JOIN
                         dbo.vEntidadSena AS f ON f.codigo = a.entidadSena AND f.empresa = a.empresa LEFT OUTER JOIN
                         dbo.vEntidadIcbf AS g ON g.codigo = a.entidadIcbf AND g.empresa = a.empresa
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vSeleccionaDatosSeguridadSocialPlano';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'80
            TopColumn = 0
         End
         Begin Table = "gTipoDocumento"
            Begin Extent = 
               Top = 206
               Left = 344
               Bottom = 418
               Right = 553
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 6
               Left = 1044
               Bottom = 185
               Right = 1253
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 142
               Left = 0
               Bottom = 380
               Right = 209
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "d"
            Begin Extent = 
               Top = 11
               Left = 1502
               Bottom = 242
               Right = 1711
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "e"
            Begin Extent = 
               Top = 10
               Left = 1266
               Bottom = 263
               Right = 1475
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "f"
            Begin Extent = 
               Top = 13
               Left = 628
               Bottom = 261
               Right = 837
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "g"
            Begin Extent = 
               Top = 27
               Left = 1048
               Bottom = 268
               Right = 1257
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 57
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
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
         Column = 2460
         Alias = 2235
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vSeleccionaDatosSeguridadSocialPlano';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[39] 4[29] 2[16] 3) )"
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
         Begin Table = "aa"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 282
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 19
         End
         Begin Table = "bb"
            Begin Extent = 
               Top = 193
               Left = 109
               Bottom = 586
               Right = 318
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "a"
            Begin Extent = 
               Top = 14
               Left = 456
               Bottom = 358
               Right = 683
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "h"
            Begin Extent = 
               Top = 6
               Left = 797
               Bottom = 136
               Right = 1006
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "nSubTipoCotizante"
            Begin Extent = 
               Top = 246
               Left = 1513
               Bottom = 376
               Right = 1722
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "nTipoCotizante"
            Begin Extent = 
               Top = 266
               Left = 1300
               Bottom = 396
               Right = 1509
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "gEmpresa"
            Begin Extent = 
               Top = 355
               Left = 497
               Bottom = 534
               Right = 706
            End
            DisplayFlags = 2', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vSeleccionaDatosSeguridadSocialPlano';

