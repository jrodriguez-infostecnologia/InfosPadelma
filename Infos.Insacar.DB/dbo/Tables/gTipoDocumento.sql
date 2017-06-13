CREATE TABLE [dbo].[gTipoDocumento] (
    [empresa]          INT           NOT NULL,
    [codigo]           VARCHAR (50)  NOT NULL,
    [descripcion]      VARCHAR (250) NOT NULL,
    [descripcionCorta] VARCHAR (50)  NOT NULL,
    [codigoTD]         INT           NOT NULL,
    CONSTRAINT [PK_gTipoDocumento] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

