#!/bin/bash

/etc/confluent/docker/run &

# Wait for Kafka Connect listener
echo "Waiting for Kafka Connect to start listening on localhost"
while : ; do
  curl_status=$(curl -s -o /dev/null -w %{http_code} http://localhost:8083/connectors)
  echo -e $(date) " Kafka Connect listener HTTP state: " $curl_status " (waiting for 200)"
  if [ $curl_status -eq 200 ] ; then
    break
  fi
  sleep 5 
done

# Create the connector, see relative connector configuration for the connector
#  <CONNECTOR_NAME> ---> Name of the connector to create
#  <TOPICS> ---> List of topics to listen to
#  <BUCKET_NAME> ---> Name of the bucket where to write the records
#  <STORE_URL> ----> https://<namespace>.compat.objectstorage.<region>.oraclecloud.com
#  <S3_REGION> ---> Oracle Cloud Region

echo -e "\n--\n+> Creating S3 sink connector"
curl -s -X PUT -H  "Content-Type:application/json" http://localhost:8083/connectors/<CONNECTOR_NAME>/config \
    -d '{
     "connector.class":"io.confluent.connect.s3.S3SinkConnector",
     "tasks.max":"1",
     "topics":"<TOPICS>",
     "format.class":"io.confluent.connect.s3.format.json.JsonFormat",
     "storage.class":"io.confluent.connect.s3.storage.S3Storage",
     "flush.size":"1",
     "s3.bucket.name":"<BUCKET_NAME>",
     "store.url":"<STORE_URL>",
     "s3.region":"<S3_REGION>",
     "errors.tolerance": "all"
}'
sleep infinity
