
include ../includes/build.mk

ASSETS := $(addprefix ../$(ASSET_DIR)/, $(ASSETS_FULL))

TMPL_base = \
	from=rust:1.77

.PHONY: all
.SECONDEXPANSION:
all: docker-base $$(ASSETS)
	$(info echo $^)

$(ASSETS):
	docker run --rm \
		--name cargo \
		--entrypoint /bin/sh \
		--volume $(CURDIR)/../$(ASSET_DIR):/app/bin \
		--user $(UID):$(UID) \
		$(REGISTRY)/rust \
		-c "cargo install --root /app --locked $(notdir $@)"

