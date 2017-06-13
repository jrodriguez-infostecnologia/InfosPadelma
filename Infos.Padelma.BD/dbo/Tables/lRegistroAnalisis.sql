CREATE TABLE [dbo].[lRegistroAnalisis] (
    [empresa]  INT          NOT NULL,
    [tipo]     VARCHAR (50) NOT NULL,
    [numero]   VARCHAR (50) NOT NULL,
    [analisis] VARCHAR (10) NOT NULL,
    [fecha]    DATETIME     NOT NULL,
    [valor]    FLOAT (53)   CONSTRAINT [DF_lRegistroAnalisis_valor] DEFAULT ((0)) NOT NULL,
    [usuario]  VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_lRegistroAnalisis_1] PRIMARY KEY CLUSTERED ([empresa] ASC, [tipo] ASC, [numero] ASC, [analisis] ASC)
);

