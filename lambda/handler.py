import json
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    logger.info("Lambda triggered with event: %s", json.dumps(event))

    records = event.get("Records", [])

    for record in records:
        body = record.get("body")
        logger.info("Received SQS message body: %s", body)

    return {
        "statusCode": 200,
        "body": json.dumps({"message": f"Processed {len(records)} records"})
    }
