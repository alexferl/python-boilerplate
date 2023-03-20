import logging
import logging.config

from app.config import settings


def setup_logging():
    config = {
        "version": 1,
        "disable_existing_loggers": False,
        "filters": {},
        "formatters": {
            "standard": {
                "format": settings.get("LOG_FORMAT"),
                "datefmt": settings.get("LOG_DATE_FORMAT"),
            }
        },
        "handlers": {
            "console": {
                "formatter": "standard",
                "class": "logging.StreamHandler",
                "filters": [],
            }
        },
        "loggers": {
            "": {
                "handlers": settings.get("LOG_HANDLERS").split(","),
                "level": settings.get("LOG_LEVEL"),
            }
        },
    }

    logging.config.dictConfig(config)
