# Makefile with just enough logic to find and kick off other makefiles.

MAKEFILES := $(wildcard */Makefile)
IMAGES := $(subst /Makefile,,$(MAKEFILES))

.PHONY: all
all: load-env docker-build-all

.PHONY: docker-build-all
docker-build-all: $(IMAGES)

.PHONY: load-env
# Load environment variables from a file
load-env:
	@if [ -f .env ]; then \
		echo "Loading environment variables from .env file..."; \
		export $$(cat .env | xargs); \
	else \
		echo "No .env file found."; \
	fi

.PHONY: $(IMAGES)
$(IMAGES):
	make -C $@

.PHONY: docker-clean
# Remove Docker image
docker-clean:
	docker rmi -f $(IMAGES)

.PHONY: asset-clean
# Remove assets
asset-clean:
	rm -Rf assets/*

.PHONY: clean
# Remove everything
clean: docker-clean asset-clean

