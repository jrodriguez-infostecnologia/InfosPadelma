CREATE TABLE [dbo].[pDensidad] (
    [empresa]     INT          NOT NULL,
    [item]        VARCHAR (50) NOT NULL,
    [temperatura] INT          NOT NULL,
    [densidad]    FLOAT (53)   NOT NULL,
    [activo]      BIT          NOT NULL,
    CONSTRAINT [PK_pDensidad] PRIMARY KEY CLUSTERED ([empresa] ASC, [item] ASC, [temperatura] ASC)
);

