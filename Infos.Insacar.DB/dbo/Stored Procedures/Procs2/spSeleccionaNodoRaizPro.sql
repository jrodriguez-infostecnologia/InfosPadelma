CREATE PROCEDURE [dbo].[spSeleccionaNodoRaizPro]
@empresa int
AS
/***************************************************************************
Nombre: spSeleccionaNodoRaizPro
Tipo: Procedimiento Almacenado
INFOS TECNOLOGIA S.A.S
Argumentos de entrada: 
Argumentos de salida: 
Descripción: Selecciona los nodos padre de las jerarquías.
*****************************************************************************/

	select * from pJerarquia
	where
	nivel = 1
	and empresa=@empresa