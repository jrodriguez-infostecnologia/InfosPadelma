CREATE proc [dbo].[spSeleccionaConceptosIRyClase]
@empresa int
as
select *, a.descripcion + ' - ' + case when retencion=1 then 'R' else 'I'  end concadenacion from cConceptoIR a
join cClaseIR b on b.codigo=a.clase and b.empresa=a.empresa
where a.empresa=@empresa