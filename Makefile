REGISTRY = exaspace
IMAGE    = ansible
VERSION  = $(shell git describe --tags)

ifdef NO_CACHE
	CACHE_ARGS := --no-cache --pull
else
	CACHE_ARGS = 
endif

check-env:
ifndef DOCKER_HUB_TOKEN
	$(error DOCKER_HUB_TOKEN is undefined)
endif

all: build

build:
	docker buildx build --platform=linux/amd64 $(CACHE_ARGS) --build-arg IMAGE_VERSION=$(VERSION) \
		-t $(REGISTRY)/$(IMAGE):$(VERSION) ./

latest: build
	docker tag $(REGISTRY)/$(IMAGE):$(VERSION) $(REGISTRY)/$(IMAGE):latest

login: check-env
	# WARNING ensure below line does not display output
	@echo $(DOCKER_HUB_TOKEN) | docker login --username exaspace --password-stdin

push: latest login
	docker push $(REGISTRY)/$(IMAGE):$(VERSION)
	docker push $(REGISTRY)/$(IMAGE):latest

list:
	curl -L -s 'https://registry.hub.docker.com/v2/repositories/$(REGISTRY)/$(IMAGE)/tags?page_size=128'|\
		jq '."results"[]["name"]'

version:
	@echo $(VERSION)

