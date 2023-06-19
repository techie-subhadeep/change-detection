from typing import List, Tuple, Any
import pyodbc
import os


def get_shipments_from_source() -> List[Tuple[Any]]:
    with pyodbc.connect(os.environ.get("SOURCE_DB_CONNSTR")) as cnxn:
        with cnxn.cursor() as cursor:
            cursor.execute(
                """
            SELECT o.id          shipment_id,
                NAME          customer_name,
                address,
                contact,
                item,
                quantity,
                o.delta_change_at order_change_at,
                o.delta_change    order_change,
                c.delta_change_at customer_change_at,
                c.delta_change    customer_change
            FROM   [dbo].[customer_delta] c,
                [dbo].[order_delta] o
            WHERE  o.customer_id = c.id
            ORDER BY order_change_at, customer_change_at
            """
            )
            rows = cursor.fetchall()
            return rows
