CREATE VIEW dbo.vSeleccionaDatosSeguridadSocialPlano2388
AS
SELECT DISTINCT 
                         a.año, a.mes, a.registro, a.idTercero, a.codigoTercero AS Identificacion, a.dPension, a.IBCpension, a.pPension, a.valorPension AS vPension, a.valorFondo AS vFondo, a.valorFondoSub AS vFondoSub, a.dSalud, 
                         a.IBCsalud, a.valorSalud AS vSalud, a.pSalud, a.IBCarl, a.pArl, a.valorArl, a.dArl, a.dCaja, a.IBCcaja, a.valorCaja AS vCaja, a.pCaja, a.valorSena AS vSena, a.valorICBF AS vIcbf, a.ING, a.RET, a.TDE, a.TAE, a.TDP, 
                         a.TAP, a.VSP, a.VST, a.SLN, a.IGE, a.LMA, a.VAC, a.AVP, a.VCT, a.IRL, a.exoneraSalud AS ExS, a.empresa, a.pFondo, a.apellido1, a.apellido2, a.nombre1, a.nombre2, a.ciudad, a.tipoCotizante, a.subTipoCotizante, 
                         b.nit AS Nit_Salud, b.dv AS Dv_Salud, b.codigoNacional AS CN_Salud, b.razonSocial AS Razon_Social_Salud, c.nit AS Nit_Pension, c.dv AS Dv_Pension, c.codigoNacional AS CN_Pension, 
                         c.razonSocial AS Razon_Social_Pension, d.nit AS Nit_Caja, d.dv AS Dv_Caja, d.razonSocial AS Razon_Social_Caja, d.codigoNacional AS CN_Caja, e.nit AS Nit_ARP, e.dv AS Dv_ARP, 
                         e.razonSocial AS Razon_Social_ARP, e.codigoNacional AS CN_ARP, f.nit AS Nit_Sena, f.dv AS Dv_Sena, f.razonSocial AS Razon_Social, f.codigoNacional AS CN_Sena, g.nit AS Nit_ICBF, g.dv AS Dv_ICBF, 
                         g.razonSocial AS Razon_Social_ICBF, g.codigoNacional AS CN_ICBF, h.nit AS Nit_Aportante, h.dv AS DV_Aportante, h.razonSocial AS Razon_Social_Aportante, a.departamento AS Id_Dpto_Ubi_Labora, 
                         SUBSTRING(a.ciudad, 3, LEN(a.ciudad)) AS Id_Cuidad_Ubi_Labora, i.descripcionCorta AS Abreviatura_Tipo_Documento, a.salario, a.pSena, a.pICBF, b.tercero AS terceroEPS, c.tercero AS terceroPension, 
                         d.tercero AS terceroCaja, e.tercero AS terceroARP, f.tercero AS terceroSena, g.tercero AS terceroICBF, a.horasLaboradas, a.extranjero, a.RecidenteExterior, a.fechaRadExterior, a.fechaIngreso, a.fechaRetiro, 
                         a.fechaVSP, a.fiSLN, a.ffSLN, a.fiIGE, a.ffIGE, a.fiLMA, a.ffLMA, a.fiVAC, a.ffVAC, a.fiVCT, a.ffVCT, a.fiIRL, a.ffIRL, a.correciones, a.salarioIntegral, a.indicadorAltoRiesgo, a.cotizacionVoluntariaAfiliado, 
                         a.cotizacionVoluntariaEmpleador, a.valorRetenido, a.totalPension, a.AFPdestino, a.terceroSalud, a.valorUPC, a.noAutorizacionEG, a.noAutorizacionLMA, a.valorIncapacidad, a.valorLMA, a.saludDestino, 
                         a.terceroArl, a.claseARL, a.centroTrabajo, a.IBCCajaOtros, a.pESAP, a.valorESAP, a.pMEN, a.valorMEN, a.tipoIDcotizanteUPC, a.noIDcotizanteUPC, a.contrato, a.tipoID
FROM            dbo.nSeguridadSocialPila AS a INNER JOIN
                         dbo.gEmpresa AS h ON a.empresa = h.id INNER JOIN
                         dbo.gTipoDocumento AS i ON a.empresa = i.empresa AND a.tipoID = i.codigo LEFT OUTER JOIN
                         dbo.vEntidadEps AS b ON b.tercero = a.terceroSalud AND b.empresa = a.empresa LEFT OUTER JOIN
                         dbo.vEntidadPension AS c ON c.tercero = a.terceroPension AND c.empresa = a.empresa LEFT OUTER JOIN
                         dbo.vEntidadCaja AS d ON d.tercero = a.terceroCaja AND d.empresa = a.empresa LEFT OUTER JOIN
                         dbo.vEntidadArp AS e ON e.tercero = a.terceroArl AND e.empresa = a.empresa LEFT OUTER JOIN
                         dbo.vEntidadSena AS f ON f.tercero = a.terceroSena AND f.empresa = a.empresa LEFT OUTER JOIN
                         dbo.vEntidadIcbf AS g ON g.tercero = a.terceroIcbf AND g.empresa = a.empresa
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vSeleccionaDatosSeguridadSocialPlano2388';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'        Begin Table = "f"
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
               Top = 138
               Left = 779
               Bottom = 268
               Right = 988
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
         Column = 2460
         Alias = 1335
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vSeleccionaDatosSeguridadSocialPlano2388';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[49] 4[13] 2[21] 3) )"
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
               Bottom = 335
               Right = 292
            End
            DisplayFlags = 280
            TopColumn = 89
         End
         Begin Table = "h"
            Begin Extent = 
               Top = 6
               Left = 330
               Bottom = 136
               Right = 539
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "i"
            Begin Extent = 
               Top = 6
               Left = 577
               Bottom = 136
               Right = 786
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 6
               Left = 824
               Bottom = 136
               Right = 1033
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 1071
               Bottom = 136
               Right = 1280
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
 ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vSeleccionaDatosSeguridadSocialPlano2388';

