# Docker-specific variables
GIT_REPO = $(shell git remote get-url origin | sed -E 's/.*[\/:]([^\/]+\/[^\/]+)\.git$$/\1/' | sed 's/\.git$$//')
GIT_URL = $(shell git remote get-url origin)
REGISTRY = $(shell \
	if echo "$(GIT_URL)" | grep -q "github.com"; then \
		echo "ghcr.io/$(GIT_REPO)"; \
	elif echo "$(GIT_URL)" | grep -q "gitlab.com"; then \
		echo "registry.gitlab.com/$(GIT_REPO)"; \
	fi)
IMAGE_NAME = $(shell echo "$(GIT_REPO)" | sed 's/\//-/g' | sed 's/\./-/g')
IMAGE_TAG = latest

build:
	docker build --platform linux/amd64 -t $(IMAGE_NAME):$(IMAGE_TAG) .

build-multi:
	docker buildx build --platform linux/amd64,linux/arm64 -t $(IMAGE_NAME) .

run:
	docker run -d -p $(PORT):80 --name $(CONTAINER_NAME) $(IMAGE_NAME)

stop:
	docker stop $(CONTAINER_NAME)
	docker rm $(CONTAINER_NAME)

ship: build
	@if [ -z "$(REGISTRY)" ]; then \
		echo "❌ Cannot determine registry"; \
		echo "   Option 1: REGISTRY=your-registry.com make ship"; \
		echo "   Option 2: Add 'REGISTRY = your-registry.com' to make-engine.mk"; \
		exit 1; \
	fi
	docker tag $(IMAGE_NAME):$(IMAGE_TAG) $(REGISTRY):$(IMAGE_TAG)
	docker push $(REGISTRY):$(IMAGE_TAG)

docker-info:
	@echo "=== Docker Configuration ==="
	@echo "GIT_REPO: $(GIT_REPO)"
	@echo "GIT_URL: $(GIT_URL)"
	@echo "REGISTRY: $(REGISTRY)"
	@echo "IMAGE_NAME: $(IMAGE_NAME)"
	@echo "IMAGE_TAG: $(IMAGE_TAG)"
