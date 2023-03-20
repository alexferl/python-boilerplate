import logging
import time
from typing import Any

from app.config import parser, settings
from app.util.config import setup_vyper
from app.util.logging import setup_logging

logger = logging.getLogger(__name__)


class App:
    def run(self):
        logger.info("Starting {}".format(settings.get("APP_NAME")))
        while True:
            time.sleep(0.1)


def configure(**overrides: Any):
    logging.getLogger("vyper").setLevel(logging.WARNING)
    setup_vyper(parser, overrides)
    setup_logging()


def create_app() -> App:
    logger.info("Environment: {}".format(settings.get("ENV_NAME")))
    logger.info("Creating {}".format(settings.get("APP_NAME")))

    app = App()
    return app
