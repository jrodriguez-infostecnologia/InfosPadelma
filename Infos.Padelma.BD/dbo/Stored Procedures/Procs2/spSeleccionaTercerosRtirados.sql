CREATE proc [dbo].[spSeleccionaTercerosRtirados]
@empresa int
as

select a.tercero, 'Cod. '+ convert(varchar(50),a.tercero) +' -  Id. ' + convert(varchar(50),a.codigo) +' - '+ a.descripcion descripcion,
'No. Contrato ('+ convert(varchar,b.id)+') - Fecha Retiro ' + CONVERT(varchar, b.fechaRetiro,103) desContrato,b.id noContrato
from nFuncionario a 
join nContratos b on a.tercero=b.tercero and a.empresa=b.empresa
join nProrroga c on c.contrato=b.id and c.tercero=b.tercero and c.tipo='R' and c.empresa=b.empresa
join nClaseContrato d on d.codigo=b.claseContrato and d.empresa=b.empresa and d.electivaProduccion=0
where a.empresa=@empresa  
and convert(varchar,b.tercero)+convert(varchar,b.id) not in (select convert(varchar,b.tercero)+convert(varchar,b.contrato) from nLiquidacionNomina a
join  nLiquidacionNominaDetalle b on b.numero =a.numero and b.tipo=a.tipo and b.empresa=a.empresa where a.empresa=@empresa and a.tipo='LQC' and anulado=0)