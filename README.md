# meteo-data
This repository contains the code for **meteo-data** application.

This application retrieves the [Tallinn's](https://en.wikipedia.org/wiki/Tallinn) current temperature from [Open-meteo](https://open-meteo.com/) and sends it to [Prometheus](https://prometheus.io) via [Push Gateway](https://github.com/prometheus/pushgateway). A simple dashboard is published in [Grafana](https://grafana.com/) in order to allow users to watch the fetched data.

## Running

### Requirements

* [Docker Engine](https://docs.docker.com/engine/install)
* [Docker Compose](https://docs.docker.com/compose/install/)

### Executing the services

You can run the entire service from your local. From this repository root folder just run the following in your terminal:

```shell
docker compose up -d
```

Notice that `-d` runs the services in dettached mode.

To stop the services run:

```shell
docker compose stop
```

### See what you deployed

Point your browser to the following locations in order to see the following services running:

* Grafana: http://localhost:3000. Login with the ultra secure `admin/grafana` user/password combination and go to `Dashboards/Tallin Temperature` to see the dashbords that represent the current Temperature in Tallinn.
* Prometheus: http://localhost:9090
* Prometheus pushgateway: http://localhost:9091

### Removing the services

To remove the services run:

```shell
docker compose down
```

## Weather service

See the Weather service [README](./weather/README.md).

## Deploying IaC with Terraform in Azure

See the Terraform [README](./terraform/README.md).

## Deploying the services into Azure Virtual Machine

See the Ansible[README](./ansible/README.md).

## Prometheus and Grafana

Check [Prometheus](./prometheus/README.md) and [Grafana](./grafana/README.md) readme files for documentation about how I'm configuring it. 

