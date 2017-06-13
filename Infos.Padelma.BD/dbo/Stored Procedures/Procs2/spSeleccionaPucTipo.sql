

create PROCEDURE [dbo].[spSeleccionaPucTipo]
	@tipo	varchar(50),
	@empresa int
AS
/***************************************************************************
Nombre: spSeleccionaPucTipo
Tipo: Procedimiento Almacenado
Desarrollado: Ricardo A. Matíz Gómez
Fecha: 08/08/2011

Argumentos de entrada: Tipo cuenta
Argumentos de salida: 
Descripción: Selecciona el Puc por tipo de cuenta
*****************************************************************************/

	if( @tipo = 'T' )
	begin
		select *,codigo + ' - ' + nombre as cadena
		from cPuc
		where empresa=@empresa
		order by codigo		
	end	
	else
	begin
		select *,codigo + ' - ' + nombre as cadena
		from cPuc
		where
		tipo = @tipo and
		empresa=@empresa
		order by codigo		
	end