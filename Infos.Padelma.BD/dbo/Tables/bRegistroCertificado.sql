CREATE TABLE [dbo].[bRegistroCertificado] (
    [empresa]       INT          NOT NULL,
    [tipo]          VARCHAR (50) NOT NULL,
    [numero]        VARCHAR (50) NOT NULL,
    [finca]         VARCHAR (50) NULL,
    [certificado]   VARCHAR (50) NOT NULL,
    [fechaRegistro] DATETIME     NOT NULL,
    [usuario]       VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_bRegistroCertificado_1] PRIMARY KEY CLUSTERED ([empresa] ASC, [tipo] ASC, [numero] ASC, [certificado] ASC)
);

