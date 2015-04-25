###
#
# FileName : Makefile
#
# Author :  polohb@gmail.com
#
# Description : Simple makefile to automate some tasks
#
##
PROJECT_NAME = teamspeak-docker
CONTAINER_NAME = teamspeak
IMG_NAME = polohb/$(CONTAINER_NAME)
#DATA_VOLUME = /opt/teamspeak
DATA_VOLUME = /ts3-data
TIMESTAMP = $(shell date +'%Y%m%d-%H%M%S')


# Get the latest built image from docker
pull:
	docker pull polohb/$(PROJECT_NAME)

#all: stop clean build run

#
clean-build: clean build

# Build the image locally
build:
	docker build -t $(IMG_NAME) .

# Run a container with port forwarding
run:
	docker run -d --name $(CONTAINER_NAME) -p=9987:9987/udp -p=10011:10011 -p=30033:30033 $(IMG_NAME)

# Run without port fw
runNoPortFW:
	docker run -d --name $(CONTAINER_NAME) $(IMG_NAME)

# Delete the image
clean:
	docker rm -v -f $(CONTAINER_NAME)

# Stop the container (do not delete it)
stop:
	docker stop $(CONTAINER_NAME)

# Start a previously stopped container
start:
	docker start $(CONTAINER_NAME)

# Restart a previously stopped container
#restart:
#	docker stop $(CONTAINER_NAME)

# Fetch the logs of the container
log:
	docker logs -f $(CONTAINER_NAME)

# List port mappings for the container
port:
	docker port $(CONTAINER_NAME)

# Run a bash shell into the container
enter:
	docker exec -it $(CONTAINER_NAME) /bin/bash

# Backup the gitblit-data folder as a tar archive
backup:
	docker run --rm --volumes-from $(CONTAINER_NAME) -v $(shell pwd):/backup busybox tar cvf /backup/backup-$(CONTAINER_NAME)$(TIMESTAMP).tar $(DATA_VOLUME)
	ln -nsf backup-$(CONTAINER_NAME)$(TIMESTAMP).tar backup-latest.tar

# Restore the gitblit-data folder from the tar archive created with 'make backup'
restore:
	docker run --rm --volumes-from $(CONTAINER_NAME) -v $(shell pwd):/backup busybox tar xvf /backup/backup-latest.tar

# Get the ip container
ip :
	docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${CONTAINER_NAME}
