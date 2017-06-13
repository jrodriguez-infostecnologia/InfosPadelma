CREATE PROCEDURE [dbo].[SpGetnTipoCotizante] AS 
select empresa, codigo, codigo + ' - ' + descripcion as descripcion,observacion, activo, fechaRegistro, usuario from nTipoCotizante GO