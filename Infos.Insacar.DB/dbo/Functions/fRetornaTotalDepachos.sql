
CREATE FUNCTION [dbo].[fRetornaTotalDepachos]
	( @tipo		varchar(50),
	  @valor	int,
	  @producto varchar(50),
	  @empresa	int,
	  @fecha	date	  )
RETURNS float
AS
/***************************************************************************
Nombre: fRetornaTotalFruta
Tipo: Función
Desarrollado: Infos Tacnologia SAS
Fecha: 06/02/2015

Argumentos de entrada: Producto, periodo
Argumentos de salida: Saldo Final
Descripción: 
***************************************************************************/
BEGIN

declare @dato float

if (@tipo='D')
begin 
	set @dato = isnull((select SUM(pesoNeto)  FROM            bRegistroBascula a
	join iItems b on b.codigo=a.item and b.empresa=a.empresa
	WHERE   a.tipo = 'DPT' AND pesoNeto <> 0 AND b.codigo =@producto and convert(date,fechaProceso)=@fecha
	GROUP BY YEAR(CONVERT(varchar(50), fechaProceso)), CONVERT(varchar(50), CONVERT(date, fechaProceso))),0)
end

if (@tipo='M')
begin 
	set @dato = isnull((select SUM(pesoNeto)  FROM            bRegistroBascula a
	join iItems b on b.codigo=a.item and b.empresa=a.empresa
	WHERE   a.tipo = 'DPT' AND pesoNeto <> 0 AND b.codigo =@producto and MONTH(fechaproceso)=@valor and YEAR(fechaproceso)=YEAR(@fecha)
	GROUP BY YEAR(fechaProceso), MONTH(fechaProceso)),0)
end

if (@tipo='A')
begin 
	set @dato = isnull((select SUM(pesoNeto)  FROM            bRegistroBascula a
	join iItems b on b.codigo=a.item and b.empresa=a.empresa
	WHERE   a.tipo = 'DPT' AND pesoNeto <> 0 AND b.codigo =@producto and YEAR(fechaproceso)=@valor
	GROUP BY YEAR(fechaProceso), YEAR(fechaProceso)),0)
end
		
	return @dato

END