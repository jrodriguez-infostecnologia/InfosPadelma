CREATE proc [dbo].[spSeleccionaRegistroNovedades]
@empresa int ,
@fi date,
@ff date
as

select  ccosto, e.descripcion desCccosto ,a.fecha,d.codigo idTercero ,d.codigo diEmpleado,
 d.tercero codTrabajador , d.descripcion desEmpleado,a.numero , c.codigo idConcepto, c.descripcion desConcepto,
c.abreviatura abreviaturaConcepto, b.cantidad, b.valor  from nNovedades a
join nNovedadesDetalle b on b.numero=a.numero and b.tipo=b.tipo and b.empresa=a.empresa join gEmpresa f on f.id=a.empresa
left join nConcepto c on c.codigo=b.concepto and c.empresa=b.empresa
left join nFuncionario d on d.tercero=b.empleado and d.empresa=b.empresa
left join cCentrosCosto e on e.codigo=a.ccosto and e.empresa=a.empresa 
where a.empresa=@empresa and a.fecha between @fi and @ff