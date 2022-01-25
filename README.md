# fcrepo4 Docker Builds

## What

Tools and scripts for building [Docker](https://docker.io/) images for
all releases of [Fedora](https://github.com/fcrepo4/fcrepo4) version 4 and up.

## Why

Testing, simple deployment

## How

### Prerequisites

* [Docker](https://www.docker.com/products/docker-desktop)
* [jq](https://stedolan.github.io/jq/)
* Some basic understanding of Docker helps

### Build a version

```bash
bin/build VERSION
```

Example:

```bash
bin/build 5.1.0 # Produces an image tagged ghcr.io/samvera/fcrepo4:5.1.0
```

If you'd like to use something other than the default target repository
(`ghcr.io/samvera/fcrepo4`), set the `DOCKER_REPO` variable:

```bash
DOCKER_REPO=foo/bar bin/build 5.1.0 # Produces an image tagged foo/bar:5.1.0
```

### Build all versions

To create an image for every [fcrepo4 release](https://github.com/fcrepo4/fcrepo4/releases), run

```bash
bin/build-all
```

The `build-all` script respects the `DOCKER_REPO` variable the same way `build` does.
