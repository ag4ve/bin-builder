# Makefile with just enough logic to find and kick off other makefiles.

REGISTRY ?= $(shell hostname)
ASSET_DIR := assets

MAKEFILES := $(wildcard */Makefile)
FULL_IMAGES := $(subst /Makefile,,$(MAKEFILES))
IMAGES := $(foreach img,$(FULL_IMAGES),$(wordlist 1,1,$(subst _, ,$(img))))

IMAGE_IDS = $(shell docker images -q $(REGISTRY)/*)

.PHONY: all
all: load-env docker-build-all

.PHONY: docker-build-all
docker-build-all: $(FULL_IMAGES)

.PHONY: load-env
# Load environment variables from a file
load-env:
	@if [ -f .env ]; then \
		echo "Loading environment variables from .env file..."; \
		export $$(cat .env | xargs); \
	else \
		echo "No .env file found."; \
	fi

.PHONY: $(FULL_IMAGES)
$(FULL_IMAGES):
	make -C $@

.PHONY: docker-clean
# Remove Docker image
docker-clean:
ifneq (,$(IMAGE_IDS))
	echo defined $(IMAGE_IDS)
	docker rmi -f $(IMAGE_IDS)
endif
	rm -f $(addsuffix /Dockerfile, $(FULL_IMAGES))

.PHONY: asset-clean
# Remove assets
asset-clean:
	rm -Rf $(ASSET_DIR)/*

.PHONY: clean
# Remove everything
clean: docker-clean asset-clean

