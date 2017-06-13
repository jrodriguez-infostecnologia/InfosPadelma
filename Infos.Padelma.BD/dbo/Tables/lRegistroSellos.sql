CREATE TABLE [dbo].[lRegistroSellos] (
    [empresa]        INT            NOT NULL,
    [tipo]           VARCHAR (50)   NOT NULL,
    [numero]         VARCHAR (50)   NOT NULL,
    [Sello]          VARCHAR (50)   NOT NULL,
    [fecha]          DATETIME       NOT NULL,
    [usuario]        VARCHAR (50)   NOT NULL,
    [imagen]         VARCHAR (8000) NULL,
    [url]            VARCHAR (8000) NULL,
    [anulado]        BIT            CONSTRAINT [DF_lRegistroSellos_anulado] DEFAULT ((0)) NULL,
    [usuarioAnulado] VARCHAR (50)   NULL,
    [fechaAnulado]   DATETIME       NULL,
    CONSTRAINT [PK_lRegistroSello] PRIMARY KEY CLUSTERED ([empresa] ASC, [tipo] ASC, [numero] ASC, [Sello] ASC)
);

