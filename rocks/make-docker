build:
	docker build --platform linux/amd64 $(IMAGE_NAME) .

build-multi:
	docker buildx build --platform linux/amd64,linux/arm64 $(IMAGE_NAME) .

run:
	docker run -d -p $(PORT):80 --name $(CONTAINER_NAME) $(IMAGE_NAME)

stop:
	docker stop $(CONTAINER_NAME)
	docker rm $(CONTAINER_NAME)

ship:
	docker build --platform linux/amd64 -t $(REGISTRY):$(IMAGE_TAG) .