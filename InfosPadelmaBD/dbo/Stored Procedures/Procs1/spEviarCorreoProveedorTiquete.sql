create proc [dbo].[spEviarCorreoProveedorTiquete]
@tiqueteN varchar(50), @empresa int
as

DECLARE @tableXML NVARCHAR(MAX);	
DECLARE @periodo char(6), @tipo varchar(50),
@pesoTara varchar(50), @pesoBruto varchar(50), @desEmpresa varchar(200),
@pesoNeto varchar(50), @numero varchar(50),
@fecha varchar(50),  @Idconductor varchar(500),
@tiquete varchar(50),@remision varchar(50),
@Nosacos varchar(50),@NoRacimos varchar(50),@remolque varchar(50),
@producto varchar(50),@procedencia varchar(50),@CodProveedor varchar(50),
@nombreProveedor varchar(50),@codTercero varchar(50), 
@planta varchar(50),@conductor varchar(50),@nombreConductor varchar(500),
@dura varchar(50),@tenera varchar(50), @impureza varchar(50),
@vahiculo varchar(50),@product varchar(50),@finca varchar(50),@nombreTercero varchar(500),@correo varchar(600)

select @desempresa= razonSocial from gempresa 
where id=@empresa

select	@fecha= a.fechaproceso,
		@tipo=a.tipo,
		@numero=a.numero,
		@tiquete=a.tiquete,
		@remision=a.remision,
		@pesoBruto=a.pesoBruto,
		@pesoTara=a.peosTara,
		@pesoNeto=a.pesoNeto,
		@procedencia=a.procedencia,
		@finca=b.descripcion,
		@vahiculo=a.vehiculo,
		@remolque=a.remolque,
		@Idconductor=h.idOperario,
		@nombreConductor =h.nombreOperario,
		@NoRacimos=a.racimos,
		@Nosacos=a.sacos,
		@nombreProveedor= f.descripcion,
		@nombreTercero=g.descripcion	
		 from bRegistroBascula a
		 join aJerarquiaCampo b on b.codigo=a.jerarquiaCampo
		 join lProducto c on c.codigo=a.producto
		 join bProcedencia d on d.codigo=a.procedencia
		 join cxpProveedor e on e.codigo=d.proveedor
		 join cTerceros f on f.codigo =e.codigo
		 join cTerceros g on g.codigo=d.tercero
		 join bregistroporteria h on h.remision=a.remision
		 where tiquete=@tiqueteN and empresa=@empresa

select @correo=direccion from bProcedenciaDireccionE
where procedencia=@procedencia and empresa=@empresa
	 
  
select @dura=valor from lRegistroAnalisis a
where numero=@numero and tipo=@tipo
and a.analisis='FD' and empresa=@empresa
select @tenera=valor from lRegistroAnalisis a
where numero=@numero and tipo=@tipo
and a.analisis='FT' and empresa=@empresa


SET @tableXML ='<html><body><span style="color:#17365d">
<H3>Tiquete Recibo de Fruta '+@desempresa+'</H3></span>
<span style="color:#17365d">
<H3>Proveedor: ' + @nombreProveedor +' </H3></span>
<span style="color:#17365d">
<H3>Tercero: ' + @nombreTercero +' </H3></span>
<table style="border-right: silver 1px solid; border-top: silver 1px solid; border-left: silver 1px solid; border-bottom: silver 1px solid;">
<tr style="width: 100px; background-color: lavender; text-align: center; vertical-align: middle; line-height: normal; letter-spacing: normal; font-weight: bold;"> 
<td style="width: 100px;border-right: silver 1px solid; border-top: silver 1px solid; border-left: silver 1px solid; border-bottom: silver 1px solid;"> Fecha </td> 
<td style="border-right: silver 1px solid; border-top: silver 1px solid; border-left: silver 1px solid; border-bottom: silver 1px solid;"> Tiquete </td>
<td style="border-right: silver 1px solid; border-top: silver 1px solid; border-left: silver 1px solid; border-bottom: silver 1px solid;"> Remision </td> 
<td style="border-right: silver 1px solid; border-top: silver 1px solid; border-left: silver 1px solid; border-bottom: silver 1px solid;"> PesoBruto </td> 
<td style="border-right: silver 1px solid; border-top: silver 1px solid; border-left: silver 1px solid; border-bottom: silver 1px solid;"> PesoTara </td>
<td style="border-right: silver 1px solid; border-top: silver 1px solid; border-left: silver 1px solid; border-bottom: silver 1px solid;"> PesoNeto </td>
<td style="border-right: silver 1px solid; border-top: silver 1px solid; border-left: silver 1px solid; border-bottom: silver 1px solid;"> Procedencia </td>
<td style="border-right: silver 1px solid; border-top: silver 1px solid; border-left: silver 1px solid; border-bottom: silver 1px solid;"> Finca </td>
<td style="border-right: silver 1px solid; border-top: silver 1px solid; border-left: silver 1px solid; border-bottom: silver 1px solid;"> Vehiculo </td>
<td style="border-right: silver 1px solid; border-top: silver 1px solid; border-left: silver 1px solid; border-bottom: silver 1px solid;"> Remolque </td>
<td style="border-right: silver 1px solid; border-top: silver 1px solid; border-left: silver 1px solid; border-bottom: silver 1px solid;"> CC_Conductor </td>
<td style="border-right: silver 1px solid; border-top: silver 1px solid; border-left: silver 1px solid; border-bottom: silver 1px solid;"> Nombre_Conductor </td>
<td style="border-right: silver 1px solid; border-top: silver 1px solid; border-left: silver 1px solid; border-bottom: silver 1px solid;"> No_Racimos </td>
<td style="border-right: silver 1px solid; border-top: silver 1px solid; border-left: silver 1px solid; border-bottom: silver 1px solid;"> No_Sacos </td>
<td style="border-right: silver 1px solid; border-top: silver 1px solid; border-left: silver 1px solid; border-bottom: silver 1px solid;"> Analisis_FD </td>
<td style="border-right: silver 1px solid; border-top: silver 1px solid; border-left: silver 1px solid; border-bottom: silver 1px solid;"> Analisis_FT </td>
</tr>
<tr>
<td style="border-right: silver 1px solid; border-top: silver 1px solid; border-left: silver 1px solid; border-bottom: silver 1px solid;"> ' + isnull(@fecha,'') + ' </td> 
<td style="border-right: silver 1px solid; border-top: silver 1px solid; border-left: silver 1px solid; border-bottom: silver 1px solid;"> ' + isnull(@tiquete,'') + ' </td> 
<td style="border-right: silver 1px solid; border-top: silver 1px solid; border-left: silver 1px solid; border-bottom: silver 1px solid;"> ' + isnull(@remision,'') + ' </td>
<td style="border-right: silver 1px solid; border-top: silver 1px solid; border-left: silver 1px solid; border-bottom: silver 1px solid;"> ' + isnull(@pesoBruto,'')+ ' </td> 
<td style="border-right: silver 1px solid; border-top: silver 1px solid; border-left: silver 1px solid; border-bottom: silver 1px solid;"> ' + isnull(@pesoBruto,'')+ ' </td> 
<td style="border-right: silver 1px solid; border-top: silver 1px solid; border-left: silver 1px solid; border-bottom: silver 1px solid;"> ' + isnull(@pesoNeto,'')+ ' </td>
<td style="border-right: silver 1px solid; border-top: silver 1px solid; border-left: silver 1px solid; border-bottom: silver 1px solid;"> ' + isnull(@procedencia,'')+ ' </td>
<td style="border-right: silver 1px solid; border-top: silver 1px solid; border-left: silver 1px solid; border-bottom: silver 1px solid;"> ' + isnull(@finca,'')+ ' </td>
<td style="border-right: silver 1px solid; border-top: silver 1px solid; border-left: silver 1px solid; border-bottom: silver 1px solid;"> ' + isnull(@vahiculo,'')+ ' </td>
<td style="border-right: silver 1px solid; border-top: silver 1px solid; border-left: silver 1px solid; border-bottom: silver 1px solid;"> ' + isnull(@remolque,'')+ ' </td>
<td style="border-right: silver 1px solid; border-top: silver 1px solid; border-left: silver 1px solid; border-bottom: silver 1px solid;"> ' + isnull(@Idconductor,'')+ ' </td>
<td style="border-right: silver 1px solid; border-top: silver 1px solid; border-left: silver 1px solid; border-bottom: silver 1px solid;"> ' + isnull(@nombreConductor,'')+ ' </td>
<td style="border-right: silver 1px solid; border-top: silver 1px solid; border-left: silver 1px solid; border-bottom: silver 1px solid;"> ' + isnull(@NoRacimos,'')+ ' </td>
<td style="border-right: silver 1px solid; border-top: silver 1px solid; border-left: silver 1px solid; border-bottom: silver 1px solid;"> ' + isnull(@Nosacos,'')+ ' </td>
<td style="border-right: silver 1px solid; border-top: silver 1px solid; border-left: silver 1px solid; border-bottom: silver 1px solid;"> ' + isnull(@dura,'')+ ' </td>
<td style="border-right: silver 1px solid; border-top: silver 1px solid; border-left: silver 1px solid; border-bottom: silver 1px solid;"> ' + isnull(@tenera,'')+ ' </td>
</tr> </table>
<H3>Departamento de Sistemas</H3>
<H3>Nota: Este correo se genera automáticamente solo para el envio de información, por favor no responda a este correo.</H3>
</body></html>'






declare @sujetos varchar(250)='Recibo de Fruta '+@desempresa+' - Tiquete No. ' + @tiquete

if (@tipo='EMP' and @tiquete<>'' and @pesoNeto<>0 and @correo is not null)
begin
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'INFOSTIQUETE',
    @recipients = @correo,		
    -- @copy_recipients=N'desarrollo@palmaceite.com',		
    @subject = @sujetos,
    @body = @tableXML,
    @body_format = 'HTML',
    @importance = 'High'
end