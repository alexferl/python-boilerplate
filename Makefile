.PHONY: help dev run build test cover cover-html fmt type pre-commit

.DEFAULT: help
help:
	@echo "make dev"
	@echo "	prepare development environment"
	@echo "make run"
	@echo "	run application"
	@echo "make build"
	@echo "	build application"
	@echo "make test"
	@echo "	run tests"
	@echo "make cover"
	@echo "	run tests and coverage"
	@echo "make cover-html"
	@echo "	run tests, coverage and open HTML report"
	@echo "make fmt"
	@echo "	run ruff linter and formatter"
	@echo "make type"
	@echo "	run mypy static type checker"
	@echo "make pre-commit"
	@echo "	run pre-commit hooks"

dev:
	uv sync --all-extras --dev
	uv run pre-commit install

run:
	uv run python -m app.main

build:
	uv build

test:
	uv run python -m unittest

cover:
	uv run coverage run -m unittest
	uv run coverage report -m

cover-html:
	uv run coverage run -m unittest
	uv run coverage html
	open htmlcov/index.html

fmt:
	uv run ruff check --fix
	uv run ruff format

type:
	uv run mypy .

pre-commit:
	uv run pre-commit run --all-files
