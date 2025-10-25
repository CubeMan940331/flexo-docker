# flexo-docker

scripts to build docker image for [flexo](https://github.com/nroi/flexo) server

## Usage

to build the docker image run `./build.sh`

an example of running the container

```bash
docker run \
    --rm \
    --name flexo-server \
    -p 7878:7878 \
    --mount type=bind,source=./conf,target=/etc/flexo \
    --mount type=bind,source=/PATH/TO/HOST/STORAGE,target=/var/cache/flexo \
    --restart unless-stopped \
    flexo-server
```
