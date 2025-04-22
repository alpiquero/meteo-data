# Readme

Here you can find the Python code of the **Weather** service.

This service retrieves the current Tallin's temperature from **Open-Meteo** and sends it to Prometheus PushGateway.

## Requirements

* Python 3.13
* venv

## Development

Create your virtual env and activate it.

```shell
python -m venv .venv
source bin/.venv/bin/activate
```

Install python deps:

```shell
pip install -r requirements.txt
```

Running the application.

```shell
python main.py
```

## Configuration environment variables

We use environment variables to configure some service values. The default values will be used if not custom ones are specified.

* `PERIOD_SECONDS`: The number of seconds that the service fetches data from **Open-Meteo**. (Default: 1)
* `PUSHGATEWAY_URL`: The pushgateway service URL. (Default: http://localhost)

Example:

```shell
PUSHGATEWAY_URL=https://pushgateway.example.com python main.py
```

