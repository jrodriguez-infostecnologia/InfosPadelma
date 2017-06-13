CREATE TABLE [dbo].[nTablaSmlvRedondeoARP] (
    [empresa] INT          NOT NULL,
    [año]     INT          NOT NULL,
    [dia]     FLOAT (53)   NOT NULL,
    [riesgo]  VARCHAR (50) NOT NULL,
    [IBC]     FLOAT (53)   NOT NULL,
    [valor]   FLOAT (53)   NOT NULL,
    CONSTRAINT [PK_nTablaSmlvRedondeoARP] PRIMARY KEY CLUSTERED ([empresa] ASC, [año] ASC, [dia] ASC, [riesgo] ASC)
);

