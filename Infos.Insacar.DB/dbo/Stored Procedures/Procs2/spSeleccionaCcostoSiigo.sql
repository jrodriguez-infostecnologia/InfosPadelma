CREATE proc [dbo].[spSeleccionaCcostoSiigo]
@empresa int,
@auxiliar bit
as


select isnull(mayor,'')+codigo as codigo , isnull(mayor + ' - ','') +  codigo +' - '+ descripcion as      descripcion from cCentrosCostoSigo
where activo=1 and empresa=@empresa and auxiliar=@auxiliar 
--and isnull(mayor,'')+codigo='00351'