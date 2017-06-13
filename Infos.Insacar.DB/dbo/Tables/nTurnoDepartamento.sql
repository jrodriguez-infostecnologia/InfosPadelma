CREATE TABLE [dbo].[nTurnoDepartamento] (
    [empresa]      INT          NOT NULL,
    [turno]        VARCHAR (50) NOT NULL,
    [departamento] VARCHAR (50) NOT NULL,
    [activo]       BIT          NOT NULL,
    CONSTRAINT [PK_nTurnoDepartamento] PRIMARY KEY CLUSTERED ([empresa] ASC, [turno] ASC, [departamento] ASC)
);

