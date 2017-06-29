INSERT INTO sMenu 
SELECT 'ModificacionPrimas' codigo, modulo, 'ModificacionPrimas.aspx' pagina, 'Liquidacion - Primas' descripcion, 1 activo FROM sMenu WHERE pagina = 'LiquidacionPrimas.aspx';
INSERT INTO sPerfilPermisos
SELECT perfil, sitio, 'ModificacionPrimas' menu, operacion, activo 
FROM sPerfilPermisos WHERE menu = 'LiquidacionPrimas';