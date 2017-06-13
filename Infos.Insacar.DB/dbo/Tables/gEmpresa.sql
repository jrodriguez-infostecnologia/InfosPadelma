CREATE TABLE [dbo].[gEmpresa] (
    [id]            INT           NOT NULL,
    [nit]           VARCHAR (50)  NOT NULL,
    [dv]            CHAR (1)      NOT NULL,
    [razonSocial]   VARCHAR (550) NOT NULL,
    [activo]        BIT           NOT NULL,
    [fechaRegistro] DATETIME      NOT NULL,
    [extractora]    BIT           CONSTRAINT [DF_gEmpresa_extractora] DEFAULT ((0)) NOT NULL,
    [tercero]       INT           NULL,
    CONSTRAINT [PK_gEmpresa] PRIMARY KEY CLUSTERED ([id] ASC)
);

