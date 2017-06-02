CREATE TABLE [dbo].[gRh] (
    [empresa]     INT           CONSTRAINT [DF_gRh_empresa] DEFAULT ((0)) NOT NULL,
    [codigo]      VARCHAR (50)  NOT NULL,
    [descripcion] VARCHAR (250) NOT NULL,
    CONSTRAINT [PK_gRh] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

