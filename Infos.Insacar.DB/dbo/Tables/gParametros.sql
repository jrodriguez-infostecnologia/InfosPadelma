CREATE TABLE [dbo].[gParametros] (
    [empresa]     INT           NOT NULL,
    [codigo]      VARCHAR (50)  NOT NULL,
    [descripcion] VARCHAR (250) NOT NULL,
    [valor]       VARCHAR (999) NULL,
    CONSTRAINT [PK_p_parametros] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

