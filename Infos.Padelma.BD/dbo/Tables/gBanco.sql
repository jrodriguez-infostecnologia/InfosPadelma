CREATE TABLE [dbo].[gBanco] (
    [empresa]     INT           NOT NULL,
    [codigo]      VARCHAR (50)  NOT NULL,
    [descripcion] VARCHAR (550) NOT NULL,
    CONSTRAINT [PK_p_bancos] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC),
    CONSTRAINT [FK_gBanco_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id])
);

