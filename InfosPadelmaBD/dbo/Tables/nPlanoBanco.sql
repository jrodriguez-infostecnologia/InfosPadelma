CREATE TABLE [dbo].[nPlanoBanco] (
    [empresa]       INT          NOT NULL,
    [banco]         VARCHAR (50) NOT NULL,
    [usuario]       VARCHAR (50) NOT NULL,
    [fechaRegistro] DATETIME     NOT NULL,
    CONSTRAINT [PK_nPlanoBanco_1] PRIMARY KEY CLUSTERED ([empresa] ASC, [banco] ASC)
);

