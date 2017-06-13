CREATE TABLE [dbo].[bRemision] (
    [empresa]             INT          NOT NULL,
    [codigo]              VARCHAR (50) NOT NULL,
    [fechaCreacion]       DATETIME     NOT NULL,
    [fechaImpresion]      DATETIME     NULL,
    [fechaAsignacion]     DATETIME     NULL,
    [usuario]             VARCHAR (50) NOT NULL,
    [funcionarioAsignado] INT          NULL,
    [estado]              CHAR (1)     NOT NULL,
    CONSTRAINT [PK_pRemision] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC),
    CONSTRAINT [CK_pRemision] CHECK ([Estado]='U' OR [Estado]='A' OR [Estado]='I' OR [Estado]='G' OR [estado]='T')
);

