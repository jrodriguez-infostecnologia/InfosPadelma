 CREATE proc [dbo].[spSeleccionanNovedadesDetalle]
@tipo varchar(50),
@empresa int,
@numero varchar(50)
as

select a.*,b.descripcion,c.descripcion from nNovedadesDetalle a
left join nFuncionario b on b.tercero=a.empleado and b.empresa=a.empresa
left join nConcepto c on c.codigo=a.concepto and c.empresa=a.empresa
where numero=@numero and tipo=@tipo and a.empresa=@empresa