#!/bin/bash -x
echo ${PORT}
exec mlflow server \
    --backend-store-uri=mysql://$DB_USER_ID:$DB_USER_KEY@$DB_ENDPOINT:$DB_PORT/$DB_NAME \
    --default-artifact-root=s3://$S3_BUCKET/
    --host $SERVER_HOST \
    --port $PORT