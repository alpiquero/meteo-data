# Grafana

This repo contains the files and folders that the [compose.yaml](../compose.yaml) uses to run and configure the Grafana service.

1. [datasource.yaml](./datasource.yaml): Configures Grafana to use Prometheus as datasource.
2. [dashboard.yaml](./dashboard.yaml): Configures a dashboard provider that will import existing dashboards from a particular folder into Grafana.
3. [dashboards](./dashboards): This folder contains all dashboards that Grafana will import at startup.

