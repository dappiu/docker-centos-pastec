docker-centos-pastec
====================

Docker container based on Centos 7 with [Visu4Link Pastec](https://github.com/Visu4link/pastec)
image recognition platform.

After you built this Docker image and attached it to a container, you might
interact with Pastec using its API documented [here](http://pastec.io/doc#api)


## Build image

```sh
git clone https://github.com/dappiu/docker-centos-pastec.git
cd docker-centos-pastec
docker build -t pastec .
```

With `-t pastec` we're calling this image `pastec` for further referencing


## Run a container with the image just built

* To map container port 4212 on host port 4212:

```sh
$ docker run -p 4212:4212 -d pastec
```

* Or, to get a random host port redirected to port 4212 of the container:

```sh
$ docker run -P -d --name pastec_container pastec

# docker port will show us which port on the host side is forwarded to Pastec
$ docker port pastec_container
4212/tcp -> 0.0.0.0:32770
```

In these commands, `pastec` is the argument to `-t` option of build command.

With `--name pastec_container` we're naming the running container, so later (as
with `docker port`) we can reference it with just `pastec_container`.

`-d` option detaches container execution sending it to the background.


## Loading a custom index

By running this image with the commands above, *pastec* will run loading the
default **Visual Words ORB** downloaded during image build from *pastec.io*
website.
If you dump an index, remember to put it in /pastec directory so it will be
preserved. Then, you can load it on further image execution by specifying
index path as last argument to *docker run*

```sh
$ docker run -P --name pastec_container pastec /pastec/my_index.dat
```


## Stopping the container

Before stopping the container, remember to dump the index using Pastec API,
if you previously indexed images and don't want to repeat the entire indexing.

To stop the container:
```sh
$ docker stop pastec_container

# Later can be started again with
$ docker start pastec_container

# Or deleted with (the image will still be available)
$ docker rm pastec_container
```
