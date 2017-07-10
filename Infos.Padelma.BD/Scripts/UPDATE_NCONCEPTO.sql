UPDATE 
conce
SET habilitaValorTotal = 1
FROM 
nConcepto conce
INNER JOIN aNovedad nov 
ON nov.empresa = conce.empresa
AND nov.concepto = conce.codigo;
UPDATE  nConcepto SET habilitaValorTotal = 1
WHERE descripcion LIKE '%uxilio De Transporte Ley%';
