# Simulated Infrastructure
Simulated infrastructure components for local development. This is a work in progress, I'll add or update things here periodically. Its just meant as a collector for useful scripts, containers and configurations.

Requires docker to be installed, then you can use the docker-compose.yml file in this folder to stand up infrastructure components for local development. These will all communicate on a named bridge network so if you plan to build microservices you should stand them up on the same network so they can easily talk to one another.

If you find any bugs with any of the files in this repository please report them as issues and if you want to submit fixes please fork the repo and submit a PR. I'll merge any submitted PRs periodically.

Docker Compose Documentation:<br>
https://docs.docker.com/reference/cli/docker/compose/

## LocalStack
* https://www.localstack.cloud/
* AWS_ACCESS_KEY_ID: admin (optional)
* AWS_SECRET_KEY: admin (optional)
* Bridge Network: internal-network
```shell
docker compose up localstack --detach
docker compose logs localstack --follow
docker compose down localstack --rmi all --remove-orphans
```

## ActiveMQ Classic
 * https://activemq.apache.org/
 * Username: admin
 * Password: admin
 * Bridge Network: internal-network
```shell
docker compose up activemq --detach
docker compose logs activemq --follow
docker compose down activemq --rmi all --remove-orphans
```

## Kafka
 * https://kafka.apache.org/
 * Username: N/A
 * Password: N/A
 * Bridge Network: internal-network
```shell
docker compose up kafka --detach
docker compose logs kafka --follow
docker compose down kafka --rmi all --remove-orphans
```

## Cassandra
 * https://cassandra.apache.org/
 * Username: admin
 * Password: admin
 * Bridge Network: internal-network
```shell
docker compose up cassandra --detach
docker compose logs cassandra --follow
docker compose down cassandra --rmi all --remove-orphans
```

## MongoDB
 * https://www.mongodb.com/
 * Username: admin
 * Password: admin
 * Bridge Network: internal-network
```shell
docker compose up mongodb --detach
docker compose logs mongodb --follow
docker compose down mongodb --rmi all --remove-orphans
```

## PostgreSQL
 * https://www.postgresql.org/
 * Username: admin
 * Password: admin
 * Bridge Network: internal-network
```shell
docker compose up postgres --detach
docker compose logs postgres --follow
docker compose down postgres --rmi all --remove-orphans
```

## MySQL
* https://www.mysql.com/
* Username: admin
* Password: admin
* Bridge Network: internal-network
```shell
docker compose up mysql --detach
docker compose logs mysql --follow
docker compose down mysql --rmi all --remove-orphans
```

## MariaDB
* https://mariadb.com/
* Username: admin
* Password: admin
* Bridge Network: internal-network
```shell
docker compose up mariadb --detach
docker compose logs mariadb --follow
docker compose down mariadb --rmi all --remove-orphans
```

## Microsoft SQL Server
 * https://www.microsoft.com/en-ca/sql-server/sql-server-downloads
 * Username: sa
 * Password: admin123!
 * Bridge Network: internal-network
```shell
docker compose up sqlserver --detach
docker compose logs sqlserver --follow
docker compose down sqlserver --rmi all --remove-orphans
```

## Oracle Express Edition
 * https://www.oracle.com/ca-en/database/technologies/appdev/xe.html
 * Username: oracle
 * Password: admin123!
 * Bridge Network: internal-network
```shell
docker compose up oracle --detach
docker compose logs oracle --follow
docker compose down oracle --rmi all --remove-orphans
```

## Hashicorp Vault
* https://www.vaultproject.io/
* Username: N/A
* Password: N/A
* Bridge Network: internal-network
```shell
docker compose up hashicorp_vault --detach
docker compose logs hashicorp_vault --follow
docker compose down hashicorp_vault --rmi all --remove-orphans
```
