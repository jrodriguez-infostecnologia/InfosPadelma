create proc [dbo].[spRetornaDatosContratoSeguridadSocial]
@empresa int,
@tercero varchar(50),
@noContrato int
as


select c.tipoDocumento,c.id,c.codigo,c.apellido1,c.apellido2, c.nombre1,c.nombre2,c.departamento,ciudad,a.tipoContizante,a.subTipoCotizante,
a.salario,a.centroTrabajo from nContratos a 
join nFuncionario b on a.tercero=b.tercero and a.empresa=b.empresa
join cTercero c on c.id=a.tercero and c.empresa=a.empresa
where a.empresa=@empresa and a.tercero=@tercero and a.id=@noContrato