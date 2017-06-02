CREATE TABLE [dbo].[nCargo] (
    [empresa]       INT            NOT NULL,
    [codigo]        VARCHAR (50)   NOT NULL,
    [descripcion]   VARCHAR (550)  NOT NULL,
    [CNO]           VARCHAR (50)   NULL,
    [jefeInmediato] VARCHAR (50)   NULL,
    [salarioMaximo] MONEY          NULL,
    [observacion]   VARCHAR (5550) NULL,
    [activo]        BIT            NOT NULL,
    CONSTRAINT [PK_nCargo] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC),
    CONSTRAINT [FK_nCargo_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id])
);

