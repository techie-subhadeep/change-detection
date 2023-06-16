-- Create Customer Change Tables
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='customer_delta' and xtype='U')
BEGIN
    SELECT *
    INTO [dbo].[customer_delta]
    FROM [dbo].[customer]
    WHERE 1 = 0;

    ALTER TABLE [dbo].[customer_delta]
    ADD [__change_id] UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() NOT NULL,
        [__change_at] DATETIME NOT NULL,
        [__change] VARCHAR(1) NOT NULL;
    
    ALTER TABLE [dbo].[customer_delta]
    ADD CONSTRAINT [PK_customer_delta] PRIMARY KEY ([__change_id]);
END
GO

-- Create Order Change Tables
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='order_delta' and xtype='U')
BEGIN
    SELECT *
    INTO [dbo].[order_delta]
    FROM [dbo].[order]
    WHERE 1 = 0;

    ALTER TABLE [dbo].[order_delta]
    ADD [__change_id] UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() NOT NULL,
        [__change_at] DATETIME NOT NULL,
        [__change] VARCHAR(1) NOT NULL;
    
    ALTER TABLE [dbo].[order_delta]
    ADD CONSTRAINT [PK_order_delta] PRIMARY KEY ([__change_id]);
END
GO
