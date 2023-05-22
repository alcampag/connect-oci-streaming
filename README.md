# connect-oci-streaming
Example for using Kafka Connect with OCI Streaming through a container image

# Prerequisites
* An OCI tenancy currently active
* An OCI Streaming instance with at least one Stream
* Kafka Connect Configuration Harness
* An OCI User with an Auth Token and relative permissions for OCI Streaming
* An OCI Object Storage Bucket
* Customer secret key of an OCI User capable of writing in an Object Storage bucket

# Running the sample Kafka Connect image with the S3 sink connector
1. Clone this repository and cd into it
2. Modify entrypoint.sh and Dockerfile with all the values needed to run the connector
3. Run the script run.sh
