import json
import base64

# Criando um evento JSON válido para o Kinesis
data = {
    "event_id": 1234,
    "event_name": "login",
    "timestamp": "2024-02-03T12:00:00",
    "value": 50
}

# Convertendo o dicionário para string JSON e codificando em Base64
encoded_data = base64.b64encode(json.dumps(data).encode()).decode()

# Criando a estrutura de evento para a Lambda
event = {
    "Records": [
        {
            "kinesis": {
                "data": encoded_data
            }
        }
    ]
}

# Salvando o arquivo event.json no caminho correto
event_file_path = r"C:\Users\julio\event.json"
with open(event_file_path, "w") as f:
    json.dump(event, f)

print(f"Arquivo {event_file_path} gerado com sucesso!")
