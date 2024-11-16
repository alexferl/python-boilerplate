from mimesis import Person
from mimesis.locales import Locale

person = Person(Locale.EN)


def hello() -> str:
    return f"Hello, {person.full_name()}!"
