import argparse

from app.util.config import settings

settings = settings

parser = argparse.ArgumentParser(description="Runs the App")

# General
g = parser.add_argument_group("General")
g.add_argument(
    "--app-name",
    type=str,
    default="app",
    help="Application and process name (default %(default)s)",
)
g.add_argument(
    "--env-name",
    type=str,
    default="LOCAL",
    choices=["LOCAL", "DEV", "TEST", "STAGING", "PROD"],
    help="Environment to run as (default %(default)s)",
)
g.add_argument(
    "--environment-variables-prefix",
    type=str,
    default="app",
    help="Prefix for environment variables (default %(default)s)",
)

# Logs
l = parser.add_argument_group("Logs")
fmt = "[%(asctime)s] [%(process)d] [%(levelname)s] %(message)s"
l.add_argument(
    "--log-format", type=str, default=fmt, help="Log format (default %(default)s)"
)
l.add_argument(
    "--log-date-format",
    type=str,
    default="%Y-%m-%d %H:%M:%S %z",
    help="Log date format (default %(default)s)",
)
l.add_argument(
    "--log-handlers",
    type=str,
    default="console",
    help="Log handlers (default %(default)s)",
)
l.add_argument(
    "--log-level", type=str, default="INFO", help="Log level (default %(default)s)"
)
