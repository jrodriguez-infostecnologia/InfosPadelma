CREATE TABLE [dbo].[nModoCampo] (
    [empresa] INT           NOT NULL,
    [modo]    VARCHAR (50)  NOT NULL,
    [entidad] VARCHAR (250) NOT NULL,
    [campo]   VARCHAR (250) NOT NULL,
    CONSTRAINT [PK_nModoCampo] PRIMARY KEY CLUSTERED ([empresa] ASC, [modo] ASC, [entidad] ASC, [campo] ASC)
);

