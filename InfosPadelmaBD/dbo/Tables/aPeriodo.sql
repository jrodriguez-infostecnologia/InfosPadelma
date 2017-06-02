CREATE TABLE [dbo].[aPeriodo] (
    [empresa]     INT           NOT NULL,
    [año]         INT           NOT NULL,
    [mes]         INT           NOT NULL,
    [descripcion] VARCHAR (550) NOT NULL,
    [periodo]     VARCHAR (6)   NOT NULL,
    [cerrado]     BIT           CONSTRAINT [DF_aPeriodo_cerrado] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_aPeriodo] PRIMARY KEY CLUSTERED ([empresa] ASC, [año] ASC, [mes] ASC)
);

