# TeamSpeak & Docker

These instructions assume you have already installed Docker and docker-compose.

## Running TeamSpeak in Docker

You can use the TeamSpeak Docker image I have created [polohb/teamspeak](https://registry.hub.docker.com/u/polohb/teamspeak/).

### Get the docker image
```
docker pull polohb/teamspeak
```

### Launch TeamSpeak
```
docker run -d --name teamspeak -p=9987:9987/udp -p=10011:10011 -p=30033:30033  polohb/teamspeak
```

 - Default voice port (UDP in): 9987
 - Default filetransfer port (TCP in): 30033
 - Default serverquery port (TCP in): 10011

## Build Instructions

### Clone this Repository
```
git clone https://github.com/polohb/teamspeak-docker.git
```

### Build your Docker container
```
cd teamspeak-docker
docker-compose build
```

### Run your TeamSpeak container and setup localhost port-forwarding
```
docker-compose start -d
```


