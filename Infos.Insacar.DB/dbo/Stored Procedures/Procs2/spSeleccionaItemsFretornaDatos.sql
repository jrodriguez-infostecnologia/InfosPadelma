CREATE procedure [dbo].[spSeleccionaItemsFretornaDatos]
@empresa int
AS


	select 2 as orden,convert(varchar(50),codigo) codigo,descripcion
	from iItems
	where empresa=@empresa and tipo='P'
	and activo=1
	
	union
	
	select 3 as orden,convert(varchar(50),codigo) codigo,descripcion
	from gTipoTransaccion
	where
	modulo = 'basc'
	and empresa=@empresa
	and activo=1
	
	union 
	
	select 3 as orden,convert(varchar(50),codigo),descripcion
	from iItems
	where empresa=@empresa
	and tipo='M'
	and activo=1
	
	union
	
	select 1 as orden,'VIN','Vagonetas Finales'
	union
	
    select 1 as orden,'TDT','Tabla dencidad temperatura'
	
	union
	
	select 1 as orden,'TAT','Tabla Aforo Tanque'
	union
	
	select 1 as orden,'PDD','Peso Descuento Diario'
	
	union 
	
	select 1 as orden,'FPF','Fruta Procesada'
	
	union 
	
	select 1 as orden,'PND','Peso Neto Diario'
	
	union 
	select 1 as orden,'FPD','Fruta en patio sin destarar'
	
	union 
	
	select 1 as orden,'FDC','Fruta destarada hasta corte'
	union 
	
	select 1 as orden,'NVP','No vehiculos en patio sin destarar'
	union 
	select 1 as orden,'PVA','Peso Promedio Vagoneta Día Anterior'
	
	union 
	
	select 1 as orden,'PNS','Peso Neto Semanal'
	
	union 
	
	select 1 as orden,'PNM','Peso Neto Mensual'		
	
	union 
	
	select 1 as orden,'PNA','Peso Neto Anual'
	
	union 
	
	select 1 as orden,'SID','Saldo Inicial Diario'
	
	union 
	
	select 1 as orden,'SIS','Saldo Inicial Semanal'
	
	union 
	
	select 1 as orden,'SIM','Saldo Inicial Mensual'		
	
	union 
	
	select 1 as orden,'SIA','Saldo Inicial Anual'
	
	union 
	
	select 1 as orden,'SOD','Saldo Actual Diario'
	
	union 
	
	select 1 as orden,'SOS','Saldo Actual Semanal'
	
	union 
	
	select 1 as orden,'SOM','Saldo Actual Mensual'
	
	union 
	
	select 1 as orden,'SOA','Saldo Actual Anual'
		
	union 
	
	select 1 as orden,'TND','Transacción Producción Diario'
	
	union 
	
	select 1 as orden,'TNS','Transacción Producción Semanal'
	
	union 
	
	select 1 as orden,'TNM','Transacción Producción Mensual'
	
	union 
	
	select 1 as orden,'TNA','Transacción Producción Anual'											
	
	union
	
	select 1 as orden,'MOV','Movimientos Producción'
	
	union 
	
	select 1 as orden,'ZER','Funcion de Cero'
	
	union 
	
	select 4 orden, 'FAN','Fecha Anterior'
	
	union 
	
	select 4 orden, 'FAC','Fecha Actual'

	union 
	
	select 4 orden, 'FSI','Fecha Siguiente'
	
	order by orden,descripcion