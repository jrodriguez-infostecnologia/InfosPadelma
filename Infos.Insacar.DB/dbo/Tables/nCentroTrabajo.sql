CREATE TABLE [dbo].[nCentroTrabajo] (
    [empresa]     INT             NOT NULL,
    [codigo]      VARCHAR (50)    NOT NULL,
    [descripcion] VARCHAR (550)   NOT NULL,
    [porcentaje]  DECIMAL (18, 3) NOT NULL,
    [activo]      BIT             NOT NULL,
    CONSTRAINT [PK_nCantroTrabajo] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

