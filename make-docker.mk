# USER = "$(shell id -u):$(shell id -g)"

# up:
# 	docker compose up -d dev postgres

# bind:
# 	docker compose exec --user=$(USER) dev bash

# docker-exec:
# 	docker compose exec dev $(ARGS)

# down:
# 	docker compose down

# down!:
# 	docker compose down --volumes --rmi local

# stop: down

# restart: stop start

# restart!: down! build! start

# build:
# 	docker compose build dev

# build!:
# 	docker compose build dev --no-cache

# rundb:
# 	docker compose up db

# start: up bind


# ci-image:
# 	# docker login registry.gitlab.com
# 	docker build . -f Dockerfile.ci -t registry.gitlab.com/setyl-team/setyl-backend:$(ARGS)
# 	docker push registry.gitlab.com/setyl-team/setyl-backend:$(ARGS)

# space:
# 	docker system prune --all -f

# Docker commands

build:
	docker build -t myapp .
	docker tag myapp:latest myapp:$(shell git rev-parse --short HEAD)

deploy:
	docker push myapp:latest
	docker push myapp:$(shell git rev-parse --short HEAD)

run:
	docker run -p 3000:3000 myapp

logs:
	docker logs -f myapp
