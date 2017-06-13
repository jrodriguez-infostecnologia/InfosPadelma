CREATE TABLE [dbo].[sMenu] (
    [codigo]      VARCHAR (150) NOT NULL,
    [modulo]      VARCHAR (150) NOT NULL,
    [pagina]      VARCHAR (550) CONSTRAINT [DF_menu_pagina] DEFAULT ('') NOT NULL,
    [descripcion] VARCHAR (550) NOT NULL,
    [activo]      BIT           CONSTRAINT [DF_sMenu_activo] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_menu] PRIMARY KEY CLUSTERED ([codigo] ASC, [modulo] ASC),
    CONSTRAINT [FK_sMenu_sModulos] FOREIGN KEY ([modulo]) REFERENCES [dbo].[sModulos] ([codigo])
);

