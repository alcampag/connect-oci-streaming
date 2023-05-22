FROM confluentinc/cp-kafka-connect

ENV CONNECT_PLUGIN_PATH="/usr/share/java,/usr/share/confluent-hub-components"

# Choose the connectors to install on the image
RUN confluent-hub install --no-prompt confluentinc/kafka-connect-s3:10.4.3

# Kafka bootstrap server
ENV CONNECT_BOOTSTRAP_SERVERS=
# Group ID for the consumer or producer
ENV CONNECT_GROUP_ID=

# Insert connect harness OCID
ENV CONNECT_CONFIG_STORAGE_TOPIC=
ENV CONNECT_OFFSET_STORAGE_TOPIC=
ENV CONNECT_STATUS_STORAGE_TOPIC=

ENV CONNECT_KEY_CONVERTER=org.apache.kafka.connect.json.JsonConverter
ENV CONNECT_VALUE_CONVERTER=org.apache.kafka.connect.json.JsonConverter
ENV CONNECT_INTERNAL_KEY_CONVERTER=org.apache.kafka.connect.json.JsonConverter
ENV CONNECT_INTERNAL_VALUE_CONVERTER=org.apache.kafka.connect.json.JsonConverter

# Disable schemas
ENV CONNECT_KEY_CONVERTER_SCHEMAS_ENABLE=false
ENV CONNECT_VALUE_CONVERTER_SCHEMAS_ENABLE=false

ENV CONNECT_REST_ADVERTISED_HOST_NAME=localhost

ENV CONNECT_SASL_MECHANISM=PLAIN
ENV CONNECT_SECURITY_PROTOCOL=SASL_SSL
# Insert connection string from OCI Streaming
ENV CONNECT_SASL_JAAS_CONFIG=

# PRODUCER configurations for source connectors
ENV CONNECT_PRODUCER_SASL_MECHANISM=PLAIN
ENV CONNECT_PRODUCER_SECURITY_PROTOCOL=SASL_SSL
# Insert connection string from OCI Streaming
ENV CONNECT_PRODUCER_SASL_JAAS_CONFIG=

# CONSUMER configurations for sink connectors
ENV CONNECT_CONSUMER_MAX_POLL_RECORDS=1000
ENV CONNECT_CONSUMER_SASL_MECHANISM=PLAIN
ENV CONNECT_CONSUMER_SECURITY_PROTOCOL=SASL_SSL
# Insert connection string from OCI Streaming
ENV CONNECT_CONSUMER_SASL_JAAS_CONFIG=

# Configure AWS Credentials (if in OCI, Customer Secret Key to write on Object Storage)
ENV AWS_ACCESS_KEY_ID=
ENV AWS_SECRET_ACCESS_KEY=

COPY --chmod=0755 entrypoint.sh ./entrypoint.sh

# Launch Kafka Connect
ENTRYPOINT ["./entrypoint.sh"]
