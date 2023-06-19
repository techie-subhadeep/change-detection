from utils.get_shipments import get_shipments_from_source
from utils.update_shipment import update_destination_shipment
from utils.filter_shipment_updates import filter_shipment_updates
from loguru import logger
import time


while True:
    logger.info("Fetching updates for source")
    shipments = get_shipments_from_source()
    for s in shipments:
        action = "D"
        if s[7] == "D" or s[9] == "D":
            action = "D"
        else:
            action = s[7]

        filter_shipment_updates(
            update_destination_shipment,
            action=action,
            id=s[0],
            customer_name=s[1],
            address=s[2],
            contact=s[3],
            item=s[4],
            quantity=s[5],
        )()
    time.sleep(30)
