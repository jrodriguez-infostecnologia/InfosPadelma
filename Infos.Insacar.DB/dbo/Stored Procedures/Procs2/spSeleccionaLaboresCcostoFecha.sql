CREATE proc spSeleccionaLaboresCcostoFecha
@fi date,
@ff date,
@empresa int
as

SELECT codCCosto,nombreCCosto,codLabor,nombreLabor,umedida, SUM(cantidadLabor) cantidadLabor,precioLabor,SUM(cantidadLabor) * precioLabor Total FROM vSeleccionaTransaccionesAgronomico
GROUP BY codCCosto,nombreCCosto,codLabor,nombreLabor,precioLabor,uMedida