# Redis Dockerfile

A Dockerfile that produces a Docker Image for [Redis](http://redis.io/).

## Redis version

The `master` branch currently hosts Redis 3.2.

Different versions of Redis are located at the github repo [branches](https://github.com/frodenas/docker-redis/branches).

## Usage

### Build the image

To create the image `frodenas/redis`, execute the following command:

```
docker build -t frodenas/redis .
docker build -t frodenas/redis:3.2 .
```

### Run the image

To run the image and bind to host port 6379:

```
docker run -d --name redis -p 6379:6379 frodenas/redis
```

The first time you run your container, a new random password will be generated. To get the password,
check the logs of the container by running:

```
docker logs redis
```

You will see an output like the following:

```
========================================================================
Redis Password: "LRaHE3zucm4CPSo3"
========================================================================
```

#### Credentials

If you want to preset credentials instead of a random generated ones, you can set the following environment variables:

* `REDIS_PASSWORD` to set a specific password

```
$ docker run -d \
    --name redis \
    -p 6379:6379 \
    -e REDIS_PASSWORD=mypassword \
    frodenas/redis
```

#### Extra arguments

When you run the container, it will start the Redis server without any arguments. If you want to pass any arguments,
just add them to the `run` command:

```
$ docker run -d --name redis -p 6379:6379 frodenas/redis --loglevel debug
```

#### Persistent data

The Redis server is configured to store data in the `/data` directory inside the container. You can map the
container's `/data` volume to a volume on the host so the data becomes independent of the running container:

```
$ mkdir -p /tmp/redis
$ docker run -d \
    --name redis \
    -p 6379:6379 \
    -v /tmp/redis:/data \
    frodenas/redis
```

There are also additional volumes at:

* `/etc/redis` which exposes Redis's configuration

### Use image to test Redis

This image includes `sanity-test` command that can interact with a Redis service (for example, another running container of this image).

```
$ docker run --entrypoint '' \
  -e credentials='{"hostname":"10.0.0.0","port":40000,"password":"qwerty"}' \
  frodenas/redis sanity-test
```

You can also easily use `sanity-test` command to self-test a running container:

```
docker run -d --name redis -p 6379:6379 frodenas/redis && \
  docker exec -ti redis sanity-test
```

The output will look similar to:

```
No $credentials provided, entering self-test mode.
Sanity testing Redis with {"hosthame":"localhost","host":"localhost","port":6379,"password":"EHaDbp6TyVaF7rsI"}
set sanity-test 1
OK
get sanity-test = 1
```

### Deploy the image with BOSH

If you have BOSH, with cloud config, you can deploy the image backed by a persistent disk volume managed by BOSH:

```
export BOSH_DEPLOYMENT=redis
bosh2 deploy bosh-redis.yml --vars-store creds.yml
```

To get the randomly generated Redis password:

```
bosh2 int creds.yml --path /redis-password
```

## Copyright

Copyright (c) 2014-2017 Ferran Rodenas. See [LICENSE](https://github.com/frodenas/docker-redis/blob/master/LICENSE) for details.
