MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
BUILD_DIR   := $(patsubst %/,%,$(dir $(MKFILE_PATH)))

# local
.PHONY: dist push html clear install uninstall

PYTHON      := $(shell which python3.6 2>/dev/null || echo python3)
VIRTUALENV  := $(shell which virtualenv 2>/dev/null || echo virtualenv)
VENV_DIR    := $(BUILD_DIR)/venv
HTML_DIR    := $(BUILD_DIR)/html

$(VENV_DIR):
	$(PYTHON) $(VIRTUALENV) -p $(PYTHON) $(VENV_DIR)

dist: $(VENV_DIR)
	rm -rf $(BUILD_DIR)/dist
	$(VENV_DIR)/bin/python setup.py bdist_wheel

push: $(VENV_DIR)
	$(VENV_DIR)/bin/pip install twine
	$(VENV_DIR)/bin/twine upload $(BUILD_DIR)/dist/*

install: $(VENV_DIR)
	$(VENV_DIR)/bin/pip install $(BUILD_DIR)/dist/$(shell ls $(BUILD_DIR)/dist | head -1)

uninstall: $(VENV_DIR)
	$(VENV_DIR)/bin/pip uninstall -y sphinxcontrib-contentui

html: dist uninstall install
	rm -rf $(HTML_DIR)
	$(VENV_DIR)/bin/sphinx-build -b html $(BUILD_DIR)/docs $(HTML_DIR)

clear:
	rm -rf $(VENV_DIR) $(HTML_DIR) $(BUILD_DIR)/dist $(BUILD_DIR)/build
	$(DOCKER) rmi $(DOCKER_IMAGE)

# docker
.PHONY: docker-dist docker-push docker-build docker-html

DOCKER       := $(shell which docker 2>/dev/null || echo docker)
UID          := $(shell id -u)
BUILD_OS     := centos
DOCKER_IMAGE := build_contentui.$(BUILD_OS)
DOCKER_VENV  := venv

docker-build:
	$(DOCKER) build -f Dockerfile.$(BUILD_OS) --build-arg UID=$(UID) --build-arg VENV_DIR=$(DOCKER_VENV) -t $(DOCKER_IMAGE) .

docker-dist: docker-build
	$(DOCKER) run -it --rm -u $(UID) -v $(BUILD_DIR):/opt/app-root/src $(DOCKER_IMAGE) make VENV_DIR=$(DOCKER_VENV) dist

docker-push: docker-build
	$(DOCKER) run -it --rm -u $(UID) -v $(BUILD_DIR):/opt/app-root/src $(DOCKER_IMAGE) make VENV_DIR=$(DOCKER_VENV) push

docker-html: docker-build
	$(DOCKER) run -it --rm -u $(UID) -v $(BUILD_DIR):/opt/app-root/src $(DOCKER_IMAGE) make VENV_DIR=$(DOCKER_VENV) html
