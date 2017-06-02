CREATE proc spSeleccionaConceptosNomina
@empresa int
as

select
codigo,
descripcion,
abreviatura,
case  when signo= 1 then 'Devengo'
else 
case  when signo= 2 then 'Deduccido'  
else 'N.A' end end signo,
case  when tipoLiquidacion= 1 then 'horas'
else 
case  when tipoLiquidacion= 2 then 'Días'
else
case  when tipoLiquidacion= 3 then 'Valo fijo'
else 
case  when tipoLiquidacion= 4 then 'Calculado'
else
case  when tipoLiquidacion= 5 then 'Fijo periodo' 
else
case  when tipoLiquidacion= 6 then 'Fijo mes'
else 
case  when tipoLiquidacion= 7 then 'Valor unidad' 
end end end end end end end tipoLiquidacion ,
base,
porcentaje,
valor,
valorMinimo,
case when basePrimas= 1 then 'si' else 'no' end basePrimas,
case when baseCajaCompensacion= 1 then 'si' else 'no' end baseCajaCompensacion,
case when baseCesantias= 1 then 'si' else 'no' end baseCesantias,
case when baseVacaciones= 1 then 'si' else 'no' end baseVacaciones,
case when baseIntereses= 1 then 'si' else 'no' end baseIntereses,
case when baseSeguridadSocial= 1 then 'si' else 'no' end baseSeguridadSocial,
case when controlaSaldo= 1 then 'si' else 'no' end controlaSaldo,
case when manejaRango= 1 then 'si' else 'no' end manejaRango,
case when ingresoGravado= 1 then 'si' else 'no' end ingresoGravado,
case when activo= 1 then 'si' else 'no' end activo,
case when fijo= 1 then 'si' else 'no' end fijo,
case when baseEmbargo= 1 then 'si' else 'no' end baseEmbargo,
prioridad,
case when descuentaDomingo= 1 then 'si' else 'no' end descuentaDomingo,
case when descuentaTransporte= 1 then 'si' else 'no' end descuentaTransporte
from nConcepto 
where empresa=@empresa