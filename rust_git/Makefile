
include ../includes/build.mk

# Strip binary/target name from asset URL
ASSETS := $(addprefix ../$(ASSET_DIR)/, $(lastword $(subst /, ,$(ASSETS_FULL))))

$(ASSETS):
	NAME = $(notdir $@)
	URL = $(filter $(NAME), $(ASSETS_FULL))
	docker run --rm \
		--name cargo \
		--entrypoint /bin/sh \
		--volume $(CURDIR)/../$(ASSET_DIR):/app/bin \
		--user $(UID):$(UID) \
		$(REGISTRY)/rust \
		-c 'cargo install --root /app --locked --git $(URL)'

