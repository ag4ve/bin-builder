
include ../includes/build.mk

ASSETS := $(addprefix ../$(ASSET_DIR)/, $(ASSETS_FULL))

TMPL_base = \
	from=golang:1.22

.PHONY: all
.SECONDEXPANSION:
all: docker-base $$(ASSETS)
	$(info echo $^)

$(ASSETS):
	docker run --rm \
		--name go \
		--entrypoint /bin/sh \
		--volume $(CURDIR)/../$(ASSET_DIR):/app/bin \
		--user $(UID):$(UID) \
		$(REGISTRY)/go \
		-c "cargo install --root /app --locked $(notdir $@)"

