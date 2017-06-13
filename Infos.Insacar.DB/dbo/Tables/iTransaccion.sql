CREATE TABLE [dbo].[iTransaccion] (
    [empresa]        INT          NOT NULL,
    [tipo]           VARCHAR (50) NOT NULL,
    [numero]         VARCHAR (50) NOT NULL,
    [año]            INT          NOT NULL,
    [mes]            INT          NOT NULL,
    [naturaleza]     VARCHAR (1)  NOT NULL,
    [vigencia]       INT          NOT NULL,
    [fecha]          DATE         NOT NULL,
    [tercero]        INT          NOT NULL,
    [referencia]     VARCHAR (50) NOT NULL,
    [tipoSalida]     VARCHAR (50) NULL,
    [talonario]      VARCHAR (50) NULL,
    [departamento]   VARCHAR (50) NULL,
    [usuario]        VARCHAR (50) NOT NULL,
    [usuarioAnulado] VARCHAR (50) NULL,
    [fechaRegistro]  DATETIME     NOT NULL,
    [fechaAnulado]   DATETIME     NULL,
    [anulado]        BIT          NULL,
    CONSTRAINT [PK_iTransaccion] PRIMARY KEY CLUSTERED ([empresa] ASC, [tipo] ASC, [numero] ASC)
);

