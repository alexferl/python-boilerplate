.PHONY: help dev test lint pre-commit freeze

.DEFAULT: help
help:
	@echo "make dev"
	@echo "	prepare development environment"
	@echo "make test"
	@echo "	run tests"
	@echo "make freeze"
	@echo "	freeze requirements"
	@echo "make lint"
	@echo "	run black"
	@echo "make pre-commit"
	@echo "	run pre-commit hooks"

dev:
	pipenv install --dev

test:
	pipenv run test

freeze:
	pipenv requirements > requirements.txt
	pipenv requirements --dev > requirements-dev.txt

lint:
	pipenv run black .

pre-commit:
	pipenv run pre-commit
