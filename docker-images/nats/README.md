# NATS Cluster Configuration Example

This `docker-compose.yml` file serves as an illustration of a NATS cluster configuration. The setup involves launching three instances of NATS: `nats`, `nats-1`, and `nats-2`.

## NATS Server Configuration 

The `max_payload` parameter is configured to handle payloads of up to 64 MB, facilitating the transmission of large data sets. It is advisable to adjust this value accordingly, especially when transferring database rows that contain substantial amounts of data in the form of blobs.

