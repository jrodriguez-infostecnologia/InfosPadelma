create proc spSeleccionaAuxiliaresBodega
 @empresa int,
 @bodega int
 as
 
 select ccosto,proveedor,cuenta from iBodega
 where empresa=@empresa and codigo=@bodega