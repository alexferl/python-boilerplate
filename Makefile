.PHONY: help dev run clean update test fmt

VENV_NAME?=venv
VENV_ACTIVATE=. $(VENV_NAME)/bin/activate
PYTHON=${VENV_NAME}/bin/python3

.DEFAULT: help
help:
	@echo "make dev"
	@echo "	prepare development environment, use only once"
	@echo "make run"
	@echo "	run application"
	@echo "make clean"
	@echo "	delete development environment"
	@echo "make update"
	@echo "	update dependencies"
	@echo "make test"
	@echo "	run tests"
	@echo "make fmt"
	@echo "	format code with black"

dev:
	make venv

venv: $(VENV_NAME)/bin/activate
$(VENV_NAME)/bin/activate:
	test -d $(VENV_NAME) || virtualenv -p python3 $(VENV_NAME)
	${PYTHON} -m pip install -U pip
	${PYTHON} -m pip install -r dev-requirements.txt
	$(VENV_NAME)/bin/pre-commit install
	touch $(VENV_NAME)/bin/activate

run: venv
	${PYTHON} run.py

clean:
	rm -rf venv

update:
	${PYTHON} -m pip install -r dev-requirements.txt

test: venv
	${PYTHON} -m pytest

fmt: venv
	$(VENV_NAME)/bin/black --exclude $(VENV_NAME) .
