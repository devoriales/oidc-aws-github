# devoriales.com - 2022
# Description: This is a simple lambda function that returns a JSON object.

import json

def lambda_handler(event, context):
    name = event["name"]
    # do not allow empty names
    if name == "":
        return {
            'statusCode': 400,
            'body': json.dumps('Name cannot be empty')
        }
    else:
        return {
            'statusCode': 200,
            'body': json.dumps('Hello from Lambda, ' + name)
        }
