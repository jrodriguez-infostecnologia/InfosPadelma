
CREATE PROCEDURE [dbo].[spConsecutivoEstructuraCC]
@empresa int,
@consecutivo int output
AS
/***************************************************************************
Nombre: spConsecutivoEstructuraCC
Tipo: Procedimiento Almacenado
Desarrollado: Infos Tecnologia

Argumentos de entrada: 
Argumentos de salida: Consecutivo de la entidad.
Descripción: Retorna el consecutivo del código para la entidad nCcostoNomina
*****************************************************************************/

if not exists(select top 1 * from cEstructuraCCosto where empresa=@empresa)
set @consecutivo=1
else
select top 1  @consecutivo = nivel + 1 from cEstructuraCCosto where empresa=@empresa
order by nivel desc