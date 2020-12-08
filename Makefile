

.PHONY: all build builder test
.DEFAULT_GOAL := all

##### Global variables #####

DOCKER   ?= docker
REGISTRY ?= nvidia
VERSION  ?= 1.0.0-beta6

##### Public rules #####

all: ubuntu16.04 centos7 ubi8

push:
	$(DOCKER) push "$(REGISTRY)/k8s-device-plugin:$(VERSION)-ubuntu16.04"
	$(DOCKER) push "$(REGISTRY)/k8s-device-plugin:$(VERSION)-centos7"
	$(DOCKER) push "$(REGISTRY)/k8s-device-plugin:$(VERSION)-ubi8"

push-short:
	$(DOCKER) tag "$(REGISTRY)/k8s-device-plugin:$(VERSION)-ubuntu16.04" "$(REGISTRY)/k8s-device-plugin:$(VERSION)"
	$(DOCKER) push "$(REGISTRY)/k8s-device-plugin:$(VERSION)"

push-latest:
	$(DOCKER) tag "$(REGISTRY)/k8s-device-plugin:$(VERSION)-ubuntu16.04" "$(REGISTRY)/k8s-device-plugin:latest"
	$(DOCKER) push "$(REGISTRY)/k8s-device-plugin:latest"

ubuntu16.04:
	$(DOCKER) build --pull \
		--tag $(REGISTRY)/k8s-device-plugin:$(VERSION)-ubuntu16.04 \
		--file docker/amd64/Dockerfile.ubuntu16.04 .

ubi8:
	$(DOCKER) build --pull \
		--tag $(REGISTRY)/k8s-device-plugin:$(VERSION)-ubi8 \
		--file docker/amd64/Dockerfile.ubi8 .

centos7:
	$(DOCKER) build --pull \
		--tag $(REGISTRY)/k8s-device-plugin:$(VERSION)-centos7 \
		--file docker/amd64/Dockerfile.centos7 .
