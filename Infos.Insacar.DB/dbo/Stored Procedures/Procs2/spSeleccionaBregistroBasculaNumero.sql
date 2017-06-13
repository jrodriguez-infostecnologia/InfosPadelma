create PROCEDURE [dbo].[spSeleccionaBregistroBasculaNumero]
	@numero	varchar(50),
	@empresa int
AS
/***************************************************************************
Nombre: spSeleccionaBregistroBasculaNumero
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia SAS

Argumentos de entrada: Número de transacción
Argumentos de salida: 
Descripción: Selecciona el registro de báscula por número de transacción
*****************************************************************************/

	select * from bRegistroBascula
	where
	numero = @numero and
	tipo <> 'ANULADO' and empresa=@empresa