
include ../includes/build.mk

# Strip binary/target name from asset URL
ASSETS := $(addprefix ../$(ASSET_DIR)/, $(lastword $(subst /, ,$(ASSETS_FULL))))

TMPL_base = \
	from=rust:1.77

.PHONY: all
.SECONDEXPANSION:
all: docker-ytermusic $$(ASSETS)
	$(info echo $^)

TMPL_ytmusic = \
	from = $(REGISTRY)/rust ; \
	apt = libdbus-1-dev
.PHONY: docker-ytermusic
docker-ytermusic: docker-base Dockerfile.ytermusic
	docker build \
		--no-cache \
		--tag $(REGISTRY)/ytermusic \
		-f $^

$(ASSETS):
	docker run --rm \
		--name cargo \
		--entrypoint /bin/sh \
		--volume $(CURDIR)/../$(ASSET_DIR):/app/bin \
		--user $(UID):$(UID) \
		$(REGISTRY)/ytermusic \
		-c "cargo install --root /app --locked --git $(filter %$(notdir $@), $(ASSETS_FULL))"

