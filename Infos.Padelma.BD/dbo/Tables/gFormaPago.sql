CREATE TABLE [dbo].[gFormaPago] (
    [empresa]     INT           NOT NULL,
    [codigo]      VARCHAR (50)  NOT NULL,
    [descripcion] VARCHAR (550) NOT NULL,
    [cheque]      BIT           CONSTRAINT [DF_gFormaPago_cheque] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_gFormaPago] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

