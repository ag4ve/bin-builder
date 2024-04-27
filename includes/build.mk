
UID ?= $(shell id -u)
GID ?= $(shell id -g)
UNAME ?= $(shell whoami)

REGISTRY ?= $(shell hostname)
ASSET_DIR := assets

ASSETS_FULL := $(shell cat assets.txt)
FULL_IMAGE := $(notdir $(CURDIR))
IMAGE := $(word 1, $(subst _, ,$(FULL_IMAGE)))

# Use exported variables to fill in a template file and produce an output file
# Make does not display line breaks so this produces no output
# $(call <template filename>, <output filename>, <variable name>
# variable example is not passed to bash directory, but is separated by ';' and
# '\' to add spaces. So:
# TMPL_VAR = foo=bar ; baz=bam\bam2
# Passes foo="bar" and baz="bam bam2"
define tmplfile
	$(foreach export_var, \
		$(subst ;, , $(subst  ,,$(3))), \
		$(eval export $(subst \, , $(export_var))) \
		$(eval TMPLFILE_VAR += $$$$$(firstword $(subst =, , $(export_var)))) \
	)
	cat $(1) | envsubst '$(TMPLFILE_VAR)' > $(2)
	$(eval undefine TMPLFILE_VAR)
endef

# Variable is named after the Dockerfile. So, Dockerfile.base uses TMPL_base as
# the variable
Dockerfile.%:
	$(call tmplfile, ../includes/$@, $@, $(TMPL_$(lastword $(subst ., , $@)))) \

.PHONY: docker-base
docker-base: Dockerfile.base
	docker build \
		--no-cache \
		--build-arg UID=$(UID) \
		--build-arg GID=$(GID) \
		--build-arg UNAME=$(UNAME) \
		--tag $(REGISTRY)/$(IMAGE) \
		-f ./$^ .
 
