import pyodbc
import os
from loguru import logger


def update_destination_shipment(
    action: str,
    id: int,
    customer_name: str,
    address: str,
    contact: str,
    item: str,
    quantity: str,
    **_,
):
    """
    Update
    Args:
        action (str): _description_
        id (int): _description_
        customer_name (str): _description_
        address (str): _description_
        contact (str): _description_
        item (str): _description_
        quantity (str): _description_
    """
    with pyodbc.connect(os.environ.get("DESTINATION_DB_CONNSTR")) as cnxn:
        with cnxn.cursor() as cursor:
            if action.upper() == "D":
                cursor.execute("DELETE FROM [dbo].[shipment] WHERE id = ?", (id,))
                logger.warning(f"Deleted Shipment {id}")
            else:
                cursor.execute(
                    """
                MERGE shipment AS target
                USING (
                    VALUES (?, ?, ?, ?, ?, ?)
                ) AS source (id, customer_name, address, contact, item, quantity)
                ON target.id = source.id
                WHEN MATCHED THEN
                    UPDATE SET
                        target.customer_name = source.customer_name,
                        target.address = source.address,
                        target.contact = source.contact,
                        target.item = source.item,
                        target.quantity = source.quantity,
                        target.modifed_at = GETDATE()
                WHEN NOT MATCHED THEN
                    INSERT (id, customer_name, address, contact, item, quantity)
                    VALUES (source.id, source.customer_name, source.address, source.contact, source.item, source.quantity);
                """,
                    (id, customer_name, address, contact, item, quantity),
                )
                logger.info(f"Updated Shipment {id}")
                cnxn.commit()
                logger.info(f"Changes Committed for Shipment {id}")
