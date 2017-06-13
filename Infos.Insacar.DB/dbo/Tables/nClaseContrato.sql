CREATE TABLE [dbo].[nClaseContrato] (
    [empresa]            INT             NOT NULL,
    [codigo]             VARCHAR (50)    NOT NULL,
    [descripcion]        VARCHAR (550)   NOT NULL,
    [terminoFijo]        BIT             NOT NULL,
    [activo]             BIT             NOT NULL,
    [electivaProduccion] BIT             NULL,
    [porcentaje]         DECIMAL (18, 3) NULL,
    [porcentajeSS]       DECIMAL (18, 3) NULL,
    CONSTRAINT [PK_nClaseContrato] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

