
include ../includes/build.mk

ASSETS := $(addprefix ../$(ASSET_DIR)/, $(ASSETS_FULL))

$(ASSETS):
	docker run --rm \
		--name cargo \
		--entrypoint /bin/sh \
		--volume $(CURDIR)/../$(ASSET_DIR):/app/bin \
		--user $(UID):$(UID) \
		$(REGISTRY)/rust \
		-c "cargo install --root /app --locked $(notdir $@)"

