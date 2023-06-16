-- Customer Table
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='customer' and xtype='U')
BEGIN
    CREATE TABLE [dbo].[customer] (
        [id]      INT            NOT NULL,
        [name]    NVARCHAR (50)  NOT NULL,
        [address] NVARCHAR (100) NOT NULL,
        [contact] NVARCHAR (50)  NOT NULL,
        CONSTRAINT [PK_customer] PRIMARY KEY CLUSTERED ([id] ASC)
    );

    INSERT INTO [dbo].[customer]
        ([id], [name], [address], [contact])
    VALUES
        (1, 'c1', 'address of c1', '9999999991'),
        (2, 'c2', 'address of c2', '9999999992'),
        (3, 'c3', 'address of c3', '9999999993');
END
GO

-- Order Table
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='order' and xtype='U')
BEGIN
    CREATE TABLE [dbo].[order] (
        [id]          INT           NOT NULL,
        [customer_id] INT           NOT NULL,
        [item]        NVARCHAR (50) NOT NULL,
        [quantity]    INT           NOT NULL,
        CONSTRAINT [PK_order] PRIMARY KEY CLUSTERED ([id] ASC)
    );

    INSERT INTO [dbo].[order]
    ([id], [customer_id], [item], [quantity])
    VALUES
    (1, 1, 'headphone', 1),
    (2, 1, 'sd-card', 5),
    (3, 2, 'iphone', 1);
END
GO
