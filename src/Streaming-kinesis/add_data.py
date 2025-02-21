import json
import datetime
import random
import boto3

kdsname = "Ingestion-Workshop"
region = "us-east-1"
client = boto3.client("kinesis", region_name=region)

def generate_data():
    event = {
        "event_id": random.randint(1000, 9999),
        "event_name": random.choice(["login", "purchase", "logout"]),
        "timestamp": datetime.datetime.now().isoformat(),
        "value": random.uniform(10.0, 100.0)
    }
    return event

while True:
    data = generate_data()
    response = client.put_record(
        StreamName = kdsname,
        Data = json.dumps(data),
        PartitionKey=str(data["event_id"])
    )
    print(f"Enviado: {data} | Status: {response['ResponseMetadata']['HTTPStatusCode']}")
