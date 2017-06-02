CREATE proc [dbo].[spSeleccionaPrecioNovedadAñoTercero]
@empresa int,
@novedad varchar(50),
@año int,
@tercero int,
@fechaNovedad date,
@precio money output
as
declare @VDSM money = isnull((select vSalarioMinimo/30 from nParametrosAno where empresa=@empresa and ano=@año),1)

set @precio = 0

if exists(select * from nContratos where empresa=@empresa and tercero=@tercero and fechaIngreso<=@fechaNovedad 
and id = (select max(id) from nContratos where tercero=@tercero and empresa=@empresa and activo=1) and activo=1)
begin
	set @VDSM = isnull((select salario/30 from nContratos where empresa=@empresa and tercero=@tercero and id = (select max(id) from nContratos where tercero=@tercero and empresa=@empresa)),1)

	set @precio=  isnull((select top 1 case when baseSueldo = 1 then @VDSM else  precioDestajo end FROM aNovedadLotePrecio
	where empresa= @empresa and novedad=@novedad and año=@año ),0)
end
else
begin
	if exists(select * from  nFuncionario where empresa=@empresa and tercero=@tercero and contratista=1)
	begin
		set @precio=  isnull((select top 1 case when baseSueldo = 1 then @VDSM else  precioContratistas end FROM aNovedadLotePrecio
		where empresa= @empresa and novedad=@novedad and año=@año and precioDestajo>0 ),0)
	end
	
	if exists(select * from  nFuncionario where empresa=@empresa and tercero=@tercero and otros=1)
	begin
		set @precio=  isnull((select top 1 case when baseSueldo = 1 then @VDSM else  precioOtros end FROM aNovedadLotePrecio
		where empresa= @empresa and novedad=@novedad and año=@año and precioDestajo>0 ),0)
	end

end