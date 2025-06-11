# Makefile for Terraform formatting and linting

.SHELLFLAGS := -e -c

TERRAFORM_DIRS := $(shell find terraform -type d \( -name .terraform \) -prune -o -type d -print)
TERRAFORM_PROJ_DIRS := $(shell find terraform -maxdepth 1 -mindepth 1 -type d ! -name modules ! -name .terraform)

.PHONY: fmt lint init plan apply all

all: fmt lint

fmt:
	@echo "Formatting Terraform files..."
	@terraform fmt -recursive 

lint:
	@echo "Linting Terraform files..."
	@for dir in $(TERRAFORM_DIRS); do \
		echo "Validating Terraform in $$dir..."; \
		terraform -chdir=$$dir init -backend=false -input=false >/dev/null; \
		terraform -chdir=$$dir validate; \
	done

init:
	@echo "Initializing Terraform directories..."
	@for dir in $(TERRAFORM_DIRS); do \
		echo "Initializing Terraform in $$dir..."; \
		terraform -chdir=$$dir init; \
	done

plan:
	@echo "Planning Terraform changes..."
	@for dir in $(TERRAFORM_PROJ_DIRS); do \
		echo "Planning Terraform in $$dir..."; \
		terraform -chdir=$$dir plan; \
	done

apply:
	@echo "Applying Terraform changes..."
	@for dir in $(TERRAFORM_PROJ_DIRS); do \
		echo "Applying Terraform in $$dir..."; \
		terraform -chdir=$$dir apply -auto-approve; \
	done
