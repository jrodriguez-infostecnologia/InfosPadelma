CREATE TABLE [dbo].[gRegimenTributario] (
    [empresa]     INT          NOT NULL,
    [codigo]      CHAR (1)     NOT NULL,
    [descripcion] VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_p_regimentributario] PRIMARY KEY CLUSTERED ([codigo] ASC, [empresa] ASC)
);

