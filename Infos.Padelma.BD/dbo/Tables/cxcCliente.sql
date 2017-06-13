CREATE TABLE [dbo].[cxcCliente] (
    [empresa]       INT           NOT NULL,
    [idTercero]     INT           NOT NULL,
    [codigo]        VARCHAR (10)  NOT NULL,
    [descripcion]   VARCHAR (550) NOT NULL,
    [activo]        BIT           NOT NULL,
    [contacto]      VARCHAR (550) NOT NULL,
    [direccion]     VARCHAR (950) NOT NULL,
    [telefono]      VARCHAR (50)  NOT NULL,
    [email]         VARCHAR (90)  NOT NULL,
    [ciudad]        CHAR (5)      NULL,
    [fechaRegistro] DATETIME      NOT NULL,
    CONSTRAINT [PK_cCliente] PRIMARY KEY CLUSTERED ([empresa] ASC, [idTercero] ASC, [codigo] ASC),
    CONSTRAINT [FK_cCliente_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id])
);

