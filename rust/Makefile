
include ../includes/build.mk

$(ASSETS): docker-build
	docker run --rm \
		--name cargo \
		--entrypoint /bin/sh \
		--volume $(CURDIR)/../asset:/app/bin \
		--user $(UID):$(UID) \
		rust \
		-c 'cargo install --root /app --locked $@'

