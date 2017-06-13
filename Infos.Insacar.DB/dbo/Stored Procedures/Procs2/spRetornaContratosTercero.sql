CREATE proc [dbo].[spRetornaContratosTercero]
@empresa int,
@tercero int
as

select 'No contrato:	'+CONVERt(varchar(50), id) + '	Fecha entrada:	'+ CONVERT(varchar(50),fechaIngreso,103) 
+'	-	'+ nClaseContrato.descripcion +' Hasta: '+ 
case when fechaContratoHasta is null then ''
else   CONVERT(varchar(50),fechaIngreso,103) end  contrato  ,* 
from nContratos 
join nClaseContrato on ncontratos.claseContrato = nClaseContrato.codigo and nContratos.empresa=nClaseContrato.empresa
where tercero=@tercero and ncontratos.empresa=@empresa 
and ncontratos.activo= 1
and id not in ( select contrato from nProrroga where tipo='R' and tercero=@tercero and empresa=@empresa)