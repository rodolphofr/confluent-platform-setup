# Installation

1. From the project root, run the command below to provision the Confluent Control Center, Broker, and Schema Registry:

```sh
docker compose -f cp-noauth/docker-compose.yml
```

Each component of the Confluent Platform will start in a container. The command output may vary depending on your operating system and should look similar to the example below:

```sh
[+] Running 4/4
 ✔ Network cp-noauth_default  Created
 ✔ Container broker           Started
 ✔ Container schema-registry  Started
 ✔ Container control-center   Started
```

2. Check if the services have started and are running:

```sh
docker compose -f cp-noauth/docker-compose.yml ps
```

The output should look similar to:

```sh
NAME              IMAGE                                             COMMAND                  SERVICE           CREATED         STATUS         PORTS
broker            confluentinc/cp-kafka:7.9.0                       "/etc/confluent/dock…"   broker            2 minutes ago   Up 2 minutes   0.0.0.0:9092->9092/tcp, :::9092->9092/tcp, 0.0.0.0:9101->9101/tcp, :::9101->9101/tcp
control-center    confluentinc/cp-enterprise-control-center:7.9.0   "/etc/confluent/dock…"   control-center    2 minutes ago   Up 2 minutes   0.0.0.0:9021->9021/tcp, :::9021->9021/tcp
schema-registry   confluentinc/cp-schema-registry:7.9.0             "/etc/confluent/dock…"   schema-registry   2 minutes ago   Up 2 minutes   0.0.0.0:8081->8081/tcp, :::8081->8081/tcp
```

If any component fails to start, run the command `docker compose -f cp-noauth/docker-compose.yml up -d` again.

3. Navigate to the Control Center at http://localhost:9021. It may take one to two minutes for the platform to fully start and be ready for use.

## Interacting with the Confluent Kafka broker

You can interact with the broker and schema registry either via the Kafka CLI or through the Control Center.

## Via Kafka CLI

Let’s create a sample topic using the command below:

```
bin/kafka-topics.sh --bootstrap-server localhost:9092 \
 --create \
 --replication-factor 1 \
 --partitions 1 \
 --topic my-topic
```

The result should look like this:

```sh
Created topic my-topic
``` 

### Via Control Center

We can create topics with just a few clicks through the Control Center.

1. Go to http://localhost:9021.
2. Click on the **controlcenter.cluster** cluster.
3. In the navigation menu, click **Topics** to open the list of topics.
4. Click **+ Add topic**.
5. Enter the topic name and number of partitions.

We’ve now created a topic with just a few clicks and set its number of partitions.

> The Control Center offers a range of features that make developing applications with Kafka easier and save time. You can view, produce, and consume messages directly through the platform. Be sure to explore and try out its other capabilities.