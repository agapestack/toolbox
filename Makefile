SHELL := /bin/bash # Use bash syntax
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
CYAN   := $(shell tput -Txterm setaf 6)
RESET  := $(shell tput -Txterm sgr0)

all: help

.PHONY: run-all
run-all: pgadmin ## run all container

.PHONY: stop-all
stop-all: pgadmin-stop ## stop all container

.PHONY: pgadmin
pgadmin: ## run pgadmin container
	sudo docker compose -f "docker-compose.pgadmin.yml" up -d --build

.PHONY: pgadmin-stop
pgadmin-stop: ## stop pgadmin container
	sudo docker compose -f "docker-compose.pgadmin.yml" down

## HELP
.PHONY: help
help: ## Show this help.
	@echo ''
	@echo 'Usage:'
	@echo '  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} { \
		if (/^[a-zA-Z_-]+:.*?##.*$$/) {printf "    ${YELLOW}%-30s${GREEN}%s${RESET}\n", $$1, $$2} \
		else if (/^## .*$$/) {printf "  ${CYAN}%s${RESET}\n", substr($$1,4)} \
		}' $(MAKEFILE_LIST)