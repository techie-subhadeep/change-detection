-- Create View to Create Shipment
CREATE OR ALTER VIEW [dbo].[shipment]
AS
SELECT o.id          shipment_id,
    NAME          customer_name,
    address,
    contact,
    item,
    quantity,
    o.__change_at order_change_at,
    o.__change    order_change,
    c.__change_at customer_change_at,
    c.__change    customer_change
FROM   [dbo].[customer_delta] c,
    [dbo].[order_delta] o
WHERE  o.customer_id = c.id
    AND ( o.__change_at > Dateadd(second, -30, Getdate())
            OR c.__change_at > Dateadd(second, -30, Getdate()) );

