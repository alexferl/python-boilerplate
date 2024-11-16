import unittest

from app.hello import hello


class HelloTestCase(unittest.TestCase):
    def test_hello(self) -> None:
        self.assertIn("Hello", hello())
