# Colors for help output
CYAN := \033[36m
GREEN := \033[32m
YELLOW := \033[33m
RESET := \033[0m

.PHONY: help
help:
	@echo ""
	@echo "$(GREEN)i2pd Docker Management$(RESET)"
	@echo ""
	@echo "$(YELLOW)Usage:$(RESET) make $(CYAN)<target>$(RESET)"
	@echo ""
	@echo "$(YELLOW)Targets:$(RESET)"
	@echo "  $(CYAN)up$(RESET)      Start containers (docker compose up)"
	@echo "  $(CYAN)upd$(RESET)     Start containers in detached mode (docker compose up -d)"
	@echo "  $(CYAN)stop$(RESET)    Stop containers (docker compose stop)"
	@echo "  $(CYAN)down$(RESET)    Stop and remove containers (docker compose down --remove-orphans)"
	@echo "  $(CYAN)downv$(RESET)   Stop and remove containers with volumes (docker compose down --remove-orphans -v)"
	@echo "  $(CYAN)build$(RESET)   Build fresh image without cache (docker compose build --no-cache)"
	@echo "  $(CYAN)bash$(RESET)    Open bash shell in i2pd_proxy container"
	@echo "  $(CYAN)clean$(RESET)   Remove container, image, and volumes"
	@echo "  $(CYAN)status$(RESET)  Show container status"
	@echo "  $(CYAN)help$(RESET)    Show this help message"
	@echo ""
	@echo "$(YELLOW)Proxy Ports:$(RESET)"
	@echo "  $(CYAN)HTTP Proxy:$(RESET)   127.0.0.1:4444"
	@echo "  $(CYAN)SOCKS Proxy:$(RESET)  127.0.0.1:4447"
	@echo "  $(CYAN)Web Console:$(RESET)  http://127.0.0.1:7070"
	@echo "  $(CYAN)IRC (Ilita):$(RESET)  127.0.0.1:6668"
	@echo "  $(CYAN)IRC (Irc2P):$(RESET)  127.0.0.1:6669"
	@echo "  $(CYAN)SMTP:$(RESET)         127.0.0.1:7659"
	@echo "  $(CYAN)POP3:$(RESET)         127.0.0.1:7660"
	@echo ""

.PHONY: up
up:
	docker compose up

.PHONY: upd
upd:
	docker compose up -d

.PHONY: stop
stop:
	docker compose stop

.PHONY: down
down:
	docker compose down --remove-orphans

.PHONY: downv
downv:
	docker compose down --remove-orphans -v

.PHONY: build
build:
	docker compose build --no-cache

.PHONY: bash
bash:
	docker compose exec i2pd_proxy bash

.PHONY: clean
clean:
	docker compose down --remove-orphans -v --rmi local

.PHONY: status
status:
	docker compose ps
