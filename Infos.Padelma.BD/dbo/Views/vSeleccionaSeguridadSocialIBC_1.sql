CREATE VIEW dbo.vSeleccionaSeguridadSocialIBC
AS
SELECT        año, mes, Codigo_Empleado, Id_Tipo_Documento, Id_Identificacion, Tipo_Cotizante, Subtipo_Cotizante, Id_Dpto_Ubi_Labora, Id_Cuidad_Ubi_Labora, nombre1, nombre2, apellido1, apellido2, Fecha_Ingreso, 
                         fechaRetiro, Sueldo_Basico, SUM(dias) AS dias, SUM(IBC) AS IBC, empresa, 0 AS tipoLiquidacion, Cod_Adm_Salud, Id_Salud_Ant, Nit_Adm_Salud, DV_Adm_Salud, Tarifa_Salud, pTarifa_Salud_empleador, 
                         Tarifa_Salud_inactividad, Cod_Adm_Pension, Nit_Adm_Pension, DV_Adm_Pension, Tarifa_Pension_Empleador, Tarifa_Pension, Tarifa_Pension_incactiva, Tarifa_Pension_Solidaridad, Cod_Adm_Arp, 
                         Nit_Adm_Arp, DV_Adm_Arp, Tarifa_Arp, Id_Caja, Cod_Adm_Caja, Nit_Adm_Caja, DV_Adm_Caja, Tarifa_Caja, Tarifa_Sena, Nit_Sena, DV_Sena, Tarifa_ICBF, Nit_ICBF, DV_ICBF, electivaProduccion, fechaInicial, 
                         fechaFinal, porcentajeSS, Nit_Aportante, DV_Aportante, Razon_Social_Aportante, Abreviatura_Tipo_Documento, Codigo_Tipo_Documento, razonSocial_Arp, razonSocial_Caja, razonSocial_Pension, 
                         razonSocial_Sena, razonSocial_ICBF, razonSocial_EPS, CodigoCentroTrabajo
FROM            dbo.vDatosSeguridadSocialTipoLiquidacion
GROUP BY año, mes, Codigo_Empleado, Id_Tipo_Documento, Id_Identificacion, Tipo_Cotizante, Subtipo_Cotizante, Id_Dpto_Ubi_Labora, Id_Cuidad_Ubi_Labora, nombre1, nombre2, apellido1, apellido2, Fecha_Ingreso, 
                         fechaRetiro, Sueldo_Basico, empresa, Cod_Adm_Salud, Id_Salud_Ant, Nit_Adm_Salud, DV_Adm_Salud, Tarifa_Salud, pTarifa_Salud_empleador, Tarifa_Salud_inactividad, Cod_Adm_Pension, Nit_Adm_Pension, 
                         DV_Adm_Pension, Tarifa_Pension_Empleador, Tarifa_Pension, Tarifa_Pension_incactiva, Tarifa_Pension_Solidaridad, Cod_Adm_Arp, Nit_Adm_Arp, DV_Adm_Arp, Tarifa_Arp, Id_Caja, Cod_Adm_Caja, 
                         Nit_Adm_Caja, DV_Adm_Caja, Tarifa_Caja, Tarifa_Sena, Nit_Sena, DV_Sena, Tarifa_ICBF, Nit_ICBF, DV_ICBF, electivaProduccion, fechaInicial, fechaFinal, porcentajeSS, Nit_Aportante, DV_Aportante, 
                         Razon_Social_Aportante, Abreviatura_Tipo_Documento, Codigo_Tipo_Documento, razonSocial_Arp, razonSocial_Caja, razonSocial_Pension, razonSocial_Sena, razonSocial_ICBF, razonSocial_EPS, 
                         CodigoCentroTrabajo
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vSeleccionaSeguridadSocialIBC';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[51] 4[12] 2[21] 3) )"
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
         Top = -96
         Left = -123
      End
      Begin Tables = 
         Begin Table = "vDatosSeguridadSocialTipoLiquidacion"
            Begin Extent = 
               Top = 102
               Left = 161
               Bottom = 296
               Right = 424
            End
            DisplayFlags = 280
            TopColumn = 61
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 29
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
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 2235
         Alias = 2880
         Table = 2880
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vSeleccionaSeguridadSocialIBC';

