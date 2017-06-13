CREATE TABLE [dbo].[nDiasHabilesCc] (
    [empresa] INT          NOT NULL,
    [ccosto]  VARCHAR (50) NOT NULL,
    [de]      INT          NOT NULL,
    [hasta]   INT          NOT NULL,
    [activo]  BIT          NOT NULL,
    CONSTRAINT [PK_nDiasHabilesCc] PRIMARY KEY CLUSTERED ([empresa] ASC, [ccosto] ASC)
);

