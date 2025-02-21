import json
import boto3
import datetime
import base64
from decimal import Decimal 

# Nome da tabela no DynamoDB
DYNAMODB_TABLE = "workshop_events"

# Inicializa o cliente do DynamoDB
dynamodb = boto3.resource("dynamodb", region_name="us-east-1")
table = dynamodb.Table(DYNAMODB_TABLE)

def lambda_handler(event, context):
    records = event.get("Records", [])

    for record in records:
        raw_data = base64.b64decode(record["kinesis"]["data"]).decode("utf-8")
        
        try:
            payload = json.loads(raw_data, parse_float=Decimal) 
        except json.JSONDecodeError as e:
            print(f"❌ Erro ao decodificar JSON: {e}")
            continue 

        # Transformação dos dados
        transformed_data = {
            "event_id": str(payload["event_id"]),
            "event_name": payload["event_name"],
            "timestamp": payload["timestamp"],
            "value": Decimal(str(payload["value"])),
            "processed": True,
            "processed_timestamp": datetime.datetime.utcnow().isoformat()
        }

        # Insere no DynamoDB
        table.put_item(Item=transformed_data)
        print(f"✅ Inserido no DynamoDB: {transformed_data}")

    return {"statusCode": 200, "body": "Dados processados com sucesso"}
