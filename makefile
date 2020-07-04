# Makefile

# NAME = $(shell jq .name info.json -r)
# VERSION = $(shell jq .version info.json -r)

help:
	@echo "Available Commands"
	@echo "\tmake tests"
	@echo "\tmake zip"

.DEFAULT_GOAL := help

tests:
	@bash ./.scripts/tests.sh

zip:
	@bash ./.scripts/zip.sh
