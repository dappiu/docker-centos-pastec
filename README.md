docker-centos-pastec
=============

Docker container based on Centos 7 with [Visu4Link Pastec](http://pastec.io/) image recognition platform.

## Build image

```sh
git clone https://github.com/dappiu/docker-centos-pastec.git
cd docker-centos-pastec
docker build -t pastec .
```

## Run image

* To map container port 4212 on host port 4212:

```sh
docker run -p 4212:4212 pastec
```

* Or, to get random host port redirected to port 4212 on the container:

```sh
docker run -P pastec
```


## Loading a custom index

By running this image with the commands above, *pastec* will run loading the
default **Visual Words ORB** downloaded during image build from *pastec.io*
website.
If you dump an index, remember to put it in /pastec directory so it will be
preserved. Then, you can load it on further image execution by specifying
index path as last argument to *docker run*

```sh
docker run -P pastec /pastec/my_index.dat
```
