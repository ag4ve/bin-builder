
UID ?= $(shell id -u)
GID ?= $(shell id -g)
UNAME ?= $(shell whoami)

REGISTRY ?= $(shell hostname)

ASSETS := $(shell cat assets.txt)
IMAGE := $(notdir $(CURDIR))

PHONY: all
all: $(ASSETS)

Dockerfile:
	cat Dockerfile.in ../includes/Dockerfile.part > Dockerfile

PHONY: docker-build
docker-build: Dockerfile
	docker build \
		--no-cache \
		--build-arg UID=$(UID) \
		--build-arg GID=$(GID) \
		--build-arg UNAME=$(UNAME) \
		--tag $(REGISTRY)/$(IMAGE) \
		.
 
