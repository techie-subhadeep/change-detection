from gql import gql, Client
from gql.transport.websockets import WebsocketsTransport
from utils.update_shipment import update_destination_shipment
from loguru import logger
from pprint import pprint

transport = WebsocketsTransport(
    url="ws://hasura:8080/v1/graphql", headers={"x-hasura-admin-secret": "secret"}
)

gql_client = Client(
    transport=transport,
    fetch_schema_from_transport=True,
)

query = gql(
    r"""
    subscription {
        shipment(
            where: {seconds_passed: {_lte: 30}},
            order_by: {seconds_passed: asc}
        ) {
            address
            contact
            item
            customer_name
            quantity
            shipment_id
            order_change
            customer_change
        }
    }
"""
)

logger.info("Starting Hasura Watcher")
for result in gql_client.subscribe(query):
    logger.info("Received Update")
    logger.info(pprint(result))
    shipments = result["shipment"]
    for s in shipments:
        action = "D"
        if s["order_change"] == "D" or s["customer_change"] == "D":
            action = "D"
        else:
            action = s["order_change"]

        update_destination_shipment(
            action=action,
            id=s["shipment_id"],
            customer_name=s["customer_name"],
            address=s["address"],
            contact=s["contact"],
            item=s["item"],
            quantity=s["quantity"],
        )
