CREATE proc spSeleccionaContratistaProveedor
@empresa int
as

select distinct b.id,b.razonSocial,b.nit from nFuncionario a
join cTercero b on b.id=a.proveedor
where a.contratista=1 and a.empresa=@empresa
order by razonSocial