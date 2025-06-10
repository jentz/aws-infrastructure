# Makefile for Terraform formatting and linting

TERRAFORM_DIRS := $(shell find terraform -type d)

.PHONY: format lint all

all: format lint

fmt:
	@echo "Formatting Terraform files..."
	@for dir in $(TERRAFORM_DIRS); do \
	  terraform -chdir=$$dir fmt -recursive; \
	done

lint:
	@echo "Linting Terraform files..."
	@for dir in $(TERRAFORM_DIRS); do \
	  terraform -chdir=$$dir init -backend=false -input=false >/dev/null; \
	  terraform -chdir=$$dir validate; \
	done
