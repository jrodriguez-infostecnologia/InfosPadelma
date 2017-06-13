CREATE proc [dbo].[spGeneraPlanoSeguridadSocial2388]
@empresa int,
@año int,
@mes int
as

create table #plano (codigo int, valor varchar(1000))

insert #plano
select distinct 1,  '01'+ 
'0'+
RIGHT(replicate('0',4) + '1',4)+ CONVERT(char(200), substring(Razon_Social_Aportante,1,200))
+'NI'
+CONVERT(char(16), substring(Nit_Aportante,1,16))
+ DV_Aportante+'E'
+ CONVERT(char(20),'')
+'U' +CONVERT(char(50),'')
+ '14-28 '
+ convert(varchar(50),año)+'-'+ RIGHT(replicate('0',2)
+ convert(varchar(2),mes),2) 
+ convert(varchar(50),año)+'-'+ RIGHT(replicate('0',2) + convert(varchar(2),mes+1),2)
+RIGHT(replicate('0',10) + '0',10)
+CONVERT(char(10),'')
+ RIGHT(replicate('0',5) + cast(count(mes) as varchar),5)
+RIGHT(replicate('0',12) + cast(cast(sum(IBCsalud) as int) as varchar),12) 
+'1 '
+'01'
 from vSeleccionaDatosSeguridadSocialPlano2388
where año=@año and mes=@mes and empresa=@empresa
group by Nit_Aportante,Razon_Social_Aportante,DV_Aportante,año,mes
insert #plano
select  2, '02'
+ RIGHT(replicate('0',5) + convert(varchar(50),ROW_NUMBER() OVER(ORDER BY registro)),5)
+ CONVERT(char(2), substring(Abreviatura_Tipo_Documento,1,2))
+ convert(char(16),ltrim(rtrim(Identificacion)))
+ TipoCotizante
+ SubtipoCotizante
+convert(char(1),extranjero)
+convert(char(1),RecidenteExterior)
+ Id_Dpto_Ubi_Labora
+ Id_Cuidad_Ubi_Labora
+ convert(char(20),ltrim(rtrim(UPPER(apellido1))))
+ convert(char(30),ltrim(rtrim(UPPER(apellido2))))
+ convert(char(20),ltrim(rtrim(UPPER(nombre1))))
+ convert(char(30),ltrim(rtrim(UPPER(nombre2))))
+convert(char(1),ING)
+convert(char(1),RET)
+convert(char(1),TDE)
+convert(char(1),TAE)
+convert(char(1),TDP)
+convert(char(1),TAP)
+convert(char(1),VSP)
+convert(char(1),correciones)
+convert(char(1), VST)
+convert(char(1),SLN)
+convert(char(1),IGE)
+convert(char(1),LMA)
+convert(char(1),VAC)
+convert(char(1),AVP)
+convert(char(1),VCT)
+RIGHT(replicate('0',2)+convert(varchar(2),IRL),2)
+convert(char(6),substring(isnull(case when IBCpension=0 then '' else  CN_Pension end,''),1,6))
+ convert(char(6),'')
+ convert(char(6),substring(isnull(CN_Salud,''),1,6))
+ convert(char(6),'')
+ convert(char(6),substring(isnull(case when IBCcaja=0 and IBCpension=0 then '' else  CN_caja end,''),1,6))
+ RIGHT(replicate('0',2) + cast(cast(dPension as int) as varchar),2)
+ RIGHT(replicate('0',2) + cast(cast(dSalud as int) as varchar),2)
+ RIGHT(replicate('0',2) + cast(cast(dArl as int) as varchar),2)
+ RIGHT(replicate('0',2) + cast(cast(dCaja as int) as varchar),2)
+ RIGHT(replicate('0',9) + cast(cast(salario as int) as varchar),9)
+ convert(char(1),'')
+ RIGHT(replicate('0',9) + cast(cast(IBCPension as int) as varchar),9)
+ RIGHT(replicate('0',9) + cast(cast(IBCSalud as int) as varchar),9)
+ RIGHT(replicate('0',9) + cast(cast(IBCarl as int) as varchar),9)
+ RIGHT(replicate('0',9) + cast(cast(IBCCaja as int) as varchar),9)
+ cast(convert(decimal(18,5),(isnull(pPension,0)/100)) as varchar) --capo 46
+ RIGHT(replicate('0',9) + cast(cast(vPension as int) as varchar),9)--47
+ RIGHT(replicate('0',9) + cast(cast(0 as int) as varchar),9)--48
+ RIGHT(replicate('0',9) + cast(cast(0 as int) as varchar),9)--48
+ RIGHT(replicate('0',9) + cast(cast(isnull(vPension,0) as int) as varchar),9) -- suma de 47,48, y 49
+ RIGHT(replicate('0',9) + cast(cast(isnull(vFondo,0) as int) as varchar),9)
+ RIGHT(replicate('0',9) + cast(cast(vFondoSub as int) as varchar),9)
+ RIGHT(replicate('0',9) + cast(cast(0 as int) as varchar),9)
+ cast(convert(decimal(18,5),((pSalud)/100)) as varchar)
+ RIGHT(replicate('0',9) + cast(cast(vSalud as int) as varchar),9)
+ RIGHT(replicate('0',9) + cast(cast(0 as int) as varchar),9)
+ convert(char(15),'')
+ RIGHT(replicate('0',9) + cast(cast(0 as int) as varchar),9)
+ convert(char(15),'')
+ RIGHT(replicate('0',9) + cast(cast(0 as int) as varchar),9)
+ cast(convert(decimal(18,7),((pArl)/100)) as varchar)
+ RIGHT(replicate('0',9) + cast(cast(0 as int) as varchar),9)
+ RIGHT(replicate('0',9) + cast(cast(valorArl as int) as varchar),9)
+ cast(convert(decimal(18,5),((isnull(pCaja,0))/100)) as varchar)
+ RIGHT(replicate('0',9) + cast(cast(vCaja as int) as varchar),9)
+ cast(convert(decimal(18,5),((isnull(pSena,0))/100)) as varchar)
+ RIGHT(replicate('0',9) + cast(cast(isnull(vSena,0) as int) as varchar),9)
+ cast(convert(decimal(18,5),((isnull(pICBF,0))/100)) as varchar)
+ RIGHT(replicate('0',9) + cast(cast(isnull(vIcbf,0) as int) as varchar),9)
+ cast(convert(decimal(18,5),((0)/100)) as varchar)
+ RIGHT(replicate('0',9) + cast(cast(0 as int) as varchar),9)
+ cast(convert(decimal(18,5),((0)/100)) as varchar)
+ RIGHT(replicate('0',9) + cast(cast(0 as int) as varchar),9)
+ convert(char(18),'')
+ convert(char(7),ExS)
+ convert(char(1),'') ----Campo nuevo
+ convert(char(1),'') ----Campo nuevo 2358---
+ convert(char(10),(REPLACE( convert(char(10),isnull(fechaIngreso,''),126) ,'1900-01-01','')))
+ convert(char(10),(REPLACE(  convert(char(10),isnull(fechaRetiro,''),126) ,'1900-01-01','')))
+ convert(char(10),(REPLACE(  convert(char(10),isnull(fechaVSP,''),126) ,'1900-01-01','')))
+ convert(char(10),(REPLACE(  convert(char(10),isnull(fiSLN,''),126) ,'1900-01-01','')))
+ convert(char(10),(REPLACE(  convert(char(10),isnull(ffSLN,''),126) ,'1900-01-01','')))
+ convert(char(10),(REPLACE(  convert(char(10),isnull(fiIGE,''),126) ,'1900-01-01','')))
+ convert(char(10),(REPLACE(  convert(char(10),isnull(ffIGE,''),126) ,'1900-01-01','')))
+ convert(char(10),(REPLACE(  convert(char(10),isnull(fiLMA,''),126) ,'1900-01-01','')))
+ convert(char(10),(REPLACE(  convert(char(10),isnull(ffLMA,''),126) ,'1900-01-01','')))
+ convert(char(10),(REPLACE(  convert(char(10),isnull(fiVAC,''),126) ,'1900-01-01','')))
+ convert(char(10),(REPLACE(  convert(char(10),isnull(ffVAC,''),126) ,'1900-01-01','')))
+ convert(char(10),(REPLACE(  convert(char(10),isnull(fiVCT,''),126) ,'1900-01-01','')))
+ convert(char(10),(REPLACE( convert(char(10),isnull(ffVCT,''),126) ,'1900-01-01','')))
+ convert(char(10),(REPLACE(  convert(char(10),isnull(fiIRL,''),126) ,'1900-01-01','')))
+ convert(char(10),(REPLACE(  convert(char(10),isnull(ffIRL,''),126),'1900-01-01','')))
+ RIGHT(replicate('0',9) + cast(cast(IBCCajaOtros as int) as varchar),9)
+ RIGHT(replicate('0',3) + cast(cast(horasLaboradas as int) as varchar),3)
+ convert(char(10),(REPLACE(  convert(char(10),isnull(fechaRadExterior,''),126),'1900-01-01','')))
from vSeleccionaDatosSeguridadSocialPlano2388 
where año=@año and mes=@mes and empresa=@empresa
insert #plano
select  3, '03'--1
+ RIGHT(replicate('0',5) + convert(varchar(50),ROW_NUMBER() OVER(ORDER BY CN_Pension)),5)--2
+ convert(char(6),substring(isnull(CN_Pension,''),1,6))--3
+ convert(char(16),isnull(Nit_Pension,''))--4
+ convert(char(1),isnull(DV_Pension,''))--5
+ RIGHT(replicate('0',10) + cast(cast(sum(vPension) as int) as varchar),10)--6
+ RIGHT(replicate('0',10) + cast(cast(0 as int) as varchar),10)--7
+ RIGHT(replicate('0',10) + cast(cast(0 as int) as varchar),10)--8
+ RIGHT(replicate('0',10) + cast(cast(sum(vFondo + vFondoSub) as int) as varchar),10)--9
+ RIGHT(replicate('0',10) + cast(cast(sum(vFondo) as int) as varchar),10)--10
+ RIGHT(replicate('0',4) + cast(cast(0 as int) as varchar),4)--11
+ RIGHT(replicate('0',10) + cast(cast(0 as int) as varchar),10)--12
+ RIGHT(replicate('0',10) + cast(cast(0 as int) as varchar),10)--13
+ RIGHT(replicate('0',10) + cast(cast(0 as int) as varchar),10)--14
+ RIGHT(replicate('0',10) + cast(cast(sum(vPension + vFondo) as int) as varchar),10)--15
+ RIGHT(replicate('0',6) + cast(cast(count(Nit_Pension) as int) as varchar),6)
from vSeleccionaDatosSeguridadSocialPlano2388
where año=@año and mes=@mes and empresa=@empresa and SLN<>'X' and Nit_Pension is not null and Nit_Pension<>''
group by CN_Pension,Nit_Pension,DV_Pension 
insert #plano
select  4, '04' + RIGHT(replicate('0',5) + convert(varchar(50),ROW_NUMBER() OVER(ORDER BY CN_Salud)),5)--2
+ convert(char(6),substring(isnull(CN_Salud,''),1,6))--3
+ convert(char(16),isnull(Nit_Salud,''))--4
+ convert(char(1),isnull(DV_Salud,''))--5
+ RIGHT(replicate('0',10) + cast(cast(sum(isnull(vSalud,0)) as int) as varchar),10)--6
+ RIGHT(replicate('0',10) + cast(cast(0 as int) as varchar),10)--7
+ convert(char(15),'')--8
+ RIGHT(replicate('0',10) + cast(cast(sum(0) as int) as varchar),10)--9
+ convert(char(15),'')--10
+ RIGHT(replicate('0',10) + cast(cast(0 as int) as varchar),10)--11
+ RIGHT(replicate('0',10) + cast(cast(sum(0+vSalud) as int) as varchar),10)--12
+ RIGHT(replicate('0',4) + cast(cast(0 as int) as varchar),4)--13
+ RIGHT(replicate('0',10) + cast(cast(0 as int) as varchar),10)--14
+ RIGHT(replicate('0',10) + cast(cast(0 as int) as varchar),10)--15
+ RIGHT(replicate('0',10) + cast(cast(sum(0+vSalud) as int) as varchar),10)--16
+ RIGHT(replicate('0',10) + cast(cast(sum(0+vSalud) as int) as varchar),10)--17
+ RIGHT(replicate('0',10) + cast(cast(0 as int) as varchar),10)--18
+ RIGHT(replicate('0',10) + cast(cast(0 as int) as varchar),10)--19
+ RIGHT(replicate('0',10) + cast(cast(0 as int) as varchar),10)--20
+ RIGHT(replicate('0',10) + cast(cast(sum(0+vSalud) as int) as varchar),10)--21
+ RIGHT(replicate('0',10) + cast(cast(sum(0+vSalud) as int) as varchar),10)--22
+ RIGHT(replicate('0',10) + cast(cast(sum(0+vSalud) as int) as varchar),10)--23
+ RIGHT(replicate('0',10) + cast(cast(0 as int) as varchar),10)--24
+ RIGHT(replicate('0',6) + cast(cast(count(Nit_Salud) as int) as varchar),6)--25
from vSeleccionaDatosSeguridadSocialPlano2388
where año=@año and mes=@mes and empresa=@empresa and SLN<>'X' and Nit_Salud is not null
group by CN_Salud,Nit_Salud,DV_Salud
insert #plano
select  5, '05' + RIGHT(replicate('0',5) + convert(varchar(50),ROW_NUMBER() OVER(ORDER BY CN_arp)),5)--2
+ convert(char(6),substring(CN_Arp,1,6))--3
+ convert(char(16),Nit_Arp)--4
+ convert(char(1),DV_Arp)--5
+ RIGHT(replicate('0',10) + cast(cast(sum(valorArl) as int) as varchar),10)--6
+ convert(char(15),'')--7
+ RIGHT(replicate('0',10) + cast(cast(0 as int) as varchar),10)--8
+ RIGHT(replicate('0',10) + cast(cast(0 as int) as varchar),10)--9
+ RIGHT(replicate('0',10) + cast(cast(sum(valorArl) as int) as varchar),10)--10
+ RIGHT(replicate('0',4) + cast(cast(0 as int) as varchar),4)--11
+ RIGHT(replicate('0',10) + cast(cast(0 as int) as varchar),10)--12
+ RIGHT(replicate('0',10) + cast(cast(sum(valorArl) as int) as varchar),10)--13
+ RIGHT(replicate('0',10) + cast(cast(0 as int) as varchar),10)--14
+ RIGHT(replicate('0',10) + cast(cast(0 as int) as varchar),10)--15
+ RIGHT(replicate('0',10) + cast(cast(sum(valorArl) as int) as varchar),10)--16
+ RIGHT(replicate('0',10) + cast(cast(sum(valorArl * 0.01) as int) as varchar),10)--17
+ RIGHT(replicate('0',6) + cast(cast(count(Nit_Salud) as int) as varchar),6)--28
from vSeleccionaDatosSeguridadSocialPlano2388
where año=@año and mes=@mes and empresa=@empresa and SLN<>'X' and Nit_Arp is not null
group by CN_arp,Nit_arp,DV_Arp
insert #plano
select  6, '06' + RIGHT(replicate('0',5) + convert(varchar(50),ROW_NUMBER() OVER(ORDER BY CN_caja)),5)--2
+ convert(char(6),substring(isnull(CN_Caja,''),1,6))--3
+ convert(char(16),isnull(Nit_Caja,''))--4
+ convert(char(1),isnull(DV_Caja,''))--5
+ RIGHT(replicate('0',10) + cast(cast(sum(vCaja) as int) as varchar),10)--6
+ RIGHT(replicate('0',4) + cast(cast(0 as int) as varchar),4)--7
+ RIGHT(replicate('0',10) + cast(cast(0 as int) as varchar),10)--8
+ RIGHT(replicate('0',10) + cast(cast(sum(vCaja) as int) as varchar),10)--9
+ RIGHT(replicate('0',6) + cast(cast(count(Nit_Caja) as int) as varchar),6)--28
from vSeleccionaDatosSeguridadSocialPlano2388
where año=@año and mes=@mes and empresa=@empresa and SLN<>'X' and Nit_Caja is not null
group by CN_Caja,Nit_Caja,DV_caja
insert #plano
select  7, '07' + RIGHT(replicate('0',5) + convert(varchar(50),ROW_NUMBER() OVER(ORDER BY Nit_Sena)),5)--2
+ convert(char(16),Nit_Sena)--4
+ convert(char(1),DV_Sena)--5
+ RIGHT(replicate('0',10) + cast(cast(sum(vSena) as int) as varchar),10)--6
+ RIGHT(replicate('0',4) + cast(cast(0 as int) as varchar),4)--7
+ RIGHT(replicate('0',10) + cast(cast(0 as int) as varchar),10)--8
+ RIGHT(replicate('0',10) + cast(cast(sum(vSena) as int) as varchar),10)--9
+ RIGHT(replicate('0',6) + cast(cast(count(Nit_Sena) as int) as varchar),6)--28
from vSeleccionaDatosSeguridadSocialPlano2388
where año=@año and mes=@mes and empresa=@empresa and SLN<>'X' and Nit_Sena is not null
group by Nit_Sena,DV_Sena
insert #plano
select  8, '08' + RIGHT(replicate('0',5) + convert(varchar(50),ROW_NUMBER() OVER(ORDER BY Nit_ICBF)),5)--2
+ convert(char(16),Nit_ICBF)--4
+ convert(char(1),DV_ICBF)--5
+ RIGHT(replicate('0',10) + cast(cast(sum(vICBF) as int) as varchar),10)--6
+ RIGHT(replicate('0',4) + cast(cast(0 as int) as varchar),4)--7
+ RIGHT(replicate('0',10) + cast(cast(0 as int) as varchar),10)--8
+ RIGHT(replicate('0',10) + cast(cast(sum(vICBF) as int) as varchar),10)--9
+ RIGHT(replicate('0',6) + cast(cast(count(Nit_ICBF) as int) as varchar),6)--28
from vSeleccionaDatosSeguridadSocialPlano2388
where año=@año and mes=@mes and empresa=@empresa and SLN<>'X' and Nit_ICBF is not null
group by Nit_ICBF,DV_ICBF


select valor from #plano
order by codigo 
drop table #plano