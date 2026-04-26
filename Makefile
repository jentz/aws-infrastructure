.SHELLFLAGS := -eu -o pipefail -c

TERRAFORM_DIRS := $(shell find terraform -type d \( -name .terraform \) -prune -o -type d -print)
PROJ_DIRS      := $(shell find terraform -maxdepth 1 -mindepth 1 -type d ! -name modules ! -name .terraform)

PARALLEL := 4

.DEFAULT_GOAL := help
.PHONY: help fmt check lint init plan apply clean

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  %-10s %s\n", $$1, $$2}'

fmt: ## Format all Terraform files
	@terraform fmt -recursive terraform

check: ## Check formatting without modifying (CI-safe)
	@terraform fmt -check -recursive terraform

lint: ## Validate all Terraform directories (parallel)
	@printf '%s\n' $(TERRAFORM_DIRS) | \
		xargs -P$(PARALLEL) -I{} sh -c \
		'echo "→ {}"; terraform -chdir={} init -backend=false -input=false >/dev/null && terraform -chdir={} validate'

init: ## Initialize all project directories (parallel)
	@printf '%s\n' $(PROJ_DIRS) | \
		xargs -P$(PARALLEL) -I{} sh -c \
		'echo "→ {}"; terraform -chdir={} init -input=false'

plan: ## Plan all project directories
	@for dir in $(PROJ_DIRS); do \
		echo "→ $$dir"; \
		terraform -chdir=$$dir plan -input=false; \
	done

apply: ## Apply all project directories
	@for dir in $(PROJ_DIRS); do \
		echo "→ $$dir"; \
		terraform -chdir=$$dir apply -input=false; \
	done

clean: ## Remove .terraform directories
	@find terraform -name '.terraform' -type d -exec rm -rf {} +
