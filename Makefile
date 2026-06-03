COMPOSE := docker compose

.DEFAULT_GOAL := help

.PHONY: help up-dev up-prod down build logs ps up-migrate migrate

help:
	@echo Available commands:
	@echo   make up-dev     - Start database and pgAdmin development environment
	@echo   make up-prod    - Start database containers for production-like run
	@echo   make up-migrate - Start database and run Flyway migrator profile
	@echo   make migrate    - Run Flyway migrator against current database
	@echo   make down       - Stop Core containers
	@echo   make build      - Pull/build Core service images
	@echo   make logs       - Follow Core container logs
	@echo   make ps         - Show Core container status

up-dev:
	$(COMPOSE) up -d

up-prod:
	$(COMPOSE) up -d vkr-database

up-migrate:
	$(COMPOSE) --profile migrate up -d

migrate:
	$(COMPOSE) --profile migrate run --rm flyway-migrate

down:
	$(COMPOSE) down --remove-orphans

build:
	$(COMPOSE) build

logs:
	$(COMPOSE) logs -f

ps:
	$(COMPOSE) ps
