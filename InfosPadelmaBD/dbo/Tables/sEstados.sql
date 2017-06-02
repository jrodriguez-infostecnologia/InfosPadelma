CREATE TABLE [dbo].[sEstados] (
    [estado]      CHAR (10)     NOT NULL,
    [descripcion] VARCHAR (150) NOT NULL,
    CONSTRAINT [PK_estados] PRIMARY KEY CLUSTERED ([estado] ASC)
);

