CREATE VIEW dbo.vSeguridadSocialEntidades
AS
/*salud*/ /*salud*/ SELECT 'Salud' concepto, aa.año, aa.mes, aa.idTercero, a.codigoTercero, bb.descripcion, b.codigo nitEntidad, b.razonSocial Entidad, aa.valorSalud valor, a.empresa
FROM          nSeguridadSocial aa
		join cTercero bb on bb.id=aa.idTercero and bb.empresa=aa.empresa
		join nContratos a on a.tercero=aa.idTercero and a.empresa=aa.empresa
		left join nCentroTrabajo h on h.codigo=a.centroTrabajo and h.empresa=a.empresa
		left join vEntidadEps b on b.codigo=a.entidadEps and b.empresa=a.empresa
		left join vEntidadPension c on c.codigo=a.entidadPension and c.empresa=a.empresa
		left join vEntidadCaja d on d.codigo=a.entidadCaja and d.empresa=a.empresa
		left join vEntidadArp e on e.codigo=a.entidadArp and e.empresa=a.empresa
		left join vEntidadSena f on f.codigo=a.entidadSena and f.empresa=a.empresa
		left join vEntidadIcbf g on g.codigo=a.entidadIcbf and g.empresa=a.empresa
/* pension*/ UNION
SELECT        'Pensión', aa.año, aa.mes, aa.idTercero, a.codigoTercero, bb.descripcion, c.codigo nitEntidad, c.razonSocial Entidad, aa.valorPension valor, a.empresa
FROM             nSeguridadSocial aa
		join cTercero bb on bb.id=aa.idTercero and bb.empresa=aa.empresa
		join nContratos a on a.tercero=aa.idTercero and a.empresa=aa.empresa
		left join nCentroTrabajo h on h.codigo=a.centroTrabajo and h.empresa=a.empresa
		left join vEntidadEps b on b.codigo=a.entidadEps and b.empresa=a.empresa
		left join vEntidadPension c on c.codigo=a.entidadPension and c.empresa=a.empresa
		left join vEntidadCaja d on d.codigo=a.entidadCaja and d.empresa=a.empresa
		left join vEntidadArp e on e.codigo=a.entidadArp and e.empresa=a.empresa
		left join vEntidadSena f on f.codigo=a.entidadSena and f.empresa=a.empresa
		left join vEntidadIcbf g on g.codigo=a.entidadIcbf and g.empresa=a.empresa
/* caja*/ UNION
SELECT        'Caja de compensación', aa.año, aa.mes, aa.idTercero, a.codigoTercero, bb.descripcion, d.codigo nitEntidad, d.razonSocial Entidad, aa.valorCaja valor, a.empresa
FROM             nSeguridadSocial aa
		join cTercero bb on bb.id=aa.idTercero and bb.empresa=aa.empresa
		join nContratos a on a.tercero=aa.idTercero and a.empresa=aa.empresa
		left join nCentroTrabajo h on h.codigo=a.centroTrabajo and h.empresa=a.empresa
		left join vEntidadEps b on b.codigo=a.entidadEps and b.empresa=a.empresa
		left join vEntidadPension c on c.codigo=a.entidadPension and c.empresa=a.empresa
		left join vEntidadCaja d on d.codigo=a.entidadCaja and d.empresa=a.empresa
		left join vEntidadArp e on e.codigo=a.entidadArp and e.empresa=a.empresa
		left join vEntidadSena f on f.codigo=a.entidadSena and f.empresa=a.empresa
		left join vEntidadIcbf g on g.codigo=a.entidadIcbf and g.empresa=a.empresa
/* ARP*/ UNION
SELECT        'Arp', aa.año, aa.mes, aa.idTercero, a.codigoTercero, bb.descripcion, e.codigo nitEntidad, e.razonSocial Entidad, aa.valorArp valor, a.empresa
FROM          nSeguridadSocial aa
		join cTercero bb on bb.id=aa.idTercero and bb.empresa=aa.empresa
		join nContratos a on a.tercero=aa.idTercero and a.empresa=aa.empresa
		left join nCentroTrabajo h on h.codigo=a.centroTrabajo and h.empresa=a.empresa
		left join vEntidadEps b on b.codigo=a.entidadEps and b.empresa=a.empresa
		left join vEntidadPension c on c.codigo=a.entidadPension and c.empresa=a.empresa
		left join vEntidadCaja d on d.codigo=a.entidadCaja and d.empresa=a.empresa
		left join vEntidadArp e on e.codigo=a.entidadArp and e.empresa=a.empresa
		left join vEntidadSena f on f.codigo=a.entidadSena and f.empresa=a.empresa
		left join vEntidadIcbf g on g.codigo=a.entidadIcbf and g.empresa=a.empresa
/*Fondo*/ UNION
SELECT        'Fondo de solidaridad', aa.año, aa.mes, aa.idTercero, a.codigoTercero, bb.descripcion, c.codigo nitEntidad, c.razonSocial Entidad, isnull(aa.valorFondo, 0) + isnull(aa.valorFondoSub, 0) valor, a.empresa
FROM            nSeguridadSocial aa
		join cTercero bb on bb.id=aa.idTercero and bb.empresa=aa.empresa
		join nContratos a on a.tercero=aa.idTercero and a.empresa=aa.empresa
		left join nCentroTrabajo h on h.codigo=a.centroTrabajo and h.empresa=a.empresa
		left join vEntidadEps b on b.codigo=a.entidadEps and b.empresa=a.empresa
		left join vEntidadPension c on c.codigo=a.entidadPension and c.empresa=a.empresa
		left join vEntidadCaja d on d.codigo=a.entidadCaja and d.empresa=a.empresa
		left join vEntidadArp e on e.codigo=a.entidadArp and e.empresa=a.empresa
		left join vEntidadSena f on f.codigo=a.entidadSena and f.empresa=a.empresa
		left join vEntidadIcbf g on g.codigo=a.entidadIcbf and g.empresa=a.empresa
/* ICBF*/ UNION
SELECT        'Icbf', aa.año, aa.mes, aa.idTercero, a.codigoTercero, bb.descripcion, g.codigo nitEntidad, g.razonSocial Entidad, valorIcbf valor, a.empresa
FROM            nSeguridadSocial aa
		join cTercero bb on bb.id=aa.idTercero and bb.empresa=aa.empresa
		join nContratos a on a.tercero=aa.idTercero and a.empresa=aa.empresa
		left join nCentroTrabajo h on h.codigo=a.centroTrabajo and h.empresa=a.empresa
		left join vEntidadEps b on b.codigo=a.entidadEps and b.empresa=a.empresa
		left join vEntidadPension c on c.codigo=a.entidadPension and c.empresa=a.empresa
		left join vEntidadCaja d on d.codigo=a.entidadCaja and d.empresa=a.empresa
		left join vEntidadArp e on e.codigo=a.entidadArp and e.empresa=a.empresa
		left join vEntidadSena f on f.codigo=a.entidadSena and f.empresa=a.empresa
		left join vEntidadIcbf g on g.codigo=a.entidadIcbf and g.empresa=a.empresa
/* Sena*/ UNION
SELECT        'Sena', aa.año, aa.mes, aa.idTercero, a.codigoTercero, bb.descripcion, f.codigo nitEntidad, f.razonSocial Entidad, valorSena, a.empresa
FROM            nSeguridadSocial aa
		join cTercero bb on bb.id=aa.idTercero and bb.empresa=aa.empresa
		join nContratos a on a.tercero=aa.idTercero and a.empresa=aa.empresa
		left join nCentroTrabajo h on h.codigo=a.centroTrabajo and h.empresa=a.empresa
		left join vEntidadEps b on b.codigo=a.entidadEps and b.empresa=a.empresa
		left join vEntidadPension c on c.codigo=a.entidadPension and c.empresa=a.empresa
		left join vEntidadCaja d on d.codigo=a.entidadCaja and d.empresa=a.empresa
		left join vEntidadArp e on e.codigo=a.entidadArp and e.empresa=a.empresa
		left join vEntidadSena f on f.codigo=a.entidadSena and f.empresa=a.empresa
		left join vEntidadIcbf g on g.codigo=a.entidadIcbf and g.empresa=a.empresa
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vSeguridadSocialEntidades';


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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vSeguridadSocialEntidades';

