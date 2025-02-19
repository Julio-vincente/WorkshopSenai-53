import json
import boto3 
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('GameEvents')

def lambda_handler(event, context):
    for record in event['Records']:
        payload = json.loads(record['Kinesis']['data'])
        table.put_item(Item={
            'event_id': str(payload['event_id']),
            'event_name': payload['event_name'],
            'timestamp': payload['timestamp'],
            'value': payload['value']
        })  
        logger.info(f"Inserindo item na tabela: {payload}")