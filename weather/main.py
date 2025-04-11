import os
import asyncio
import logging

import openmeteo_requests
from openmeteo_sdk.Variable import Variable

from prometheus_client import (
    CollectorRegistry,
    Gauge,
    push_to_gateway,
)

# Logger config
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger()

# Config Variables
period = int(os.getenv("PERIOD_SECONDS", 1))
pushgateway = os.getenv("PUSHGATEWAY_URL", "localhost:9091")

# Función para ejecutar una tarea periódica
async def run_periodic(interval_sec: float, coro_func, *args, **kwargs):
    while True:
        try:
            await coro_func(*args, **kwargs)
        except Exception as e:
            logger.exception(f"Error while running periodic task: {e}")
        await asyncio.sleep(interval_sec)

# Async task that get temperature from OpenMeteo and sends it to Pushgateway
async def get_and_push_temperature():
    
    om = openmeteo_requests.Client()
    params = {
        "latitude": 59.4370,
        "longitude": 24.7433,
        "current": "temperature_2m"
    }

    try:
        responses = om.weather_api("https://api.open-meteo.com/v1/forecast", params=params)
    except Exception as e:
        logger.exception(f"Failed to get temperature data: {e}")

    response = responses[0]

    current = response.Current()
    current_variables = list(
      map(
        lambda i: current.Variables(i),
        range(0, current.VariablesLength()
        )
      )
    )

    current_temperature_2m = next(
        filter(
            lambda x: x.Variable() == Variable.temperature and x.Altitude() == 2,
            current_variables
        )
    )

    temperature = current_temperature_2m.Value()
    logger.info(f"Time: {current.Time()} | Temperature: {temperature}°C")

    registry = CollectorRegistry()
    gauge = Gauge(
        'temperature_current_tallinn',
        'The current temperature for Tallinn',
        ["application"],
        registry=registry
    )
    gauge.labels("weather").set(temperature)

    try:
        push_to_gateway(pushgateway, job="Tallinn_Temperature", registry=registry)
    except Exception as e:
        logger.exception(f"Failed to push temperature data to pushgateway: {e}")

# Main
async def main():
    logger.info("Starting temperature fetcher")
    await run_periodic(period, get_and_push_temperature)

if __name__ == "__main__":
    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        logger.info("Shutting down gracefully...")
