CREATE TABLE [dbo].[nTurno] (
    [empresa]     INT           NOT NULL,
    [codigo]      VARCHAR (50)  NOT NULL,
    [descripcion] VARCHAR (250) NOT NULL,
    [horaInicio]  INT           NOT NULL,
    [horas]       INT           NOT NULL,
    [activo]      BIT           NOT NULL,
    CONSTRAINT [PK_nTurno] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

