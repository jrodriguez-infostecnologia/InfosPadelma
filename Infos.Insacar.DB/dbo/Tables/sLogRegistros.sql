CREATE TABLE [dbo].[sLogRegistros] (
    [usuario]        VARCHAR (50)  NOT NULL,
    [fecha]          DATETIME      NOT NULL,
    [operacion]      VARCHAR (50)  NOT NULL,
    [empresa]        INT           NULL,
    [entidad]        VARCHAR (250) NOT NULL,
    [estado]         CHAR (10)     NOT NULL,
    [mensajeSistema] VARCHAR (500) NULL,
    [ip]             VARCHAR (50)  NULL,
    CONSTRAINT [PK_sLogRegistros_1] PRIMARY KEY CLUSTERED ([usuario] ASC, [fecha] ASC, [operacion] ASC),
    CONSTRAINT [FK_sLogRegistros_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id]),
    CONSTRAINT [FK_sLogRegistros_sEstados] FOREIGN KEY ([estado]) REFERENCES [dbo].[sEstados] ([estado]),
    CONSTRAINT [FK_sLogRegistros_sOperaciones] FOREIGN KEY ([operacion]) REFERENCES [dbo].[sOperaciones] ([codigo]),
    CONSTRAINT [FK_sLogRegistros_sUsuarios] FOREIGN KEY ([usuario]) REFERENCES [dbo].[sUsuarios] ([usuario])
);

