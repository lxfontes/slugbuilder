Heavily inspired by flynn/slugbuilder, ddollar/mason and phusion/baseimage-docker

## Extra Features
- Extra environment variables
- slug compilation and compression
- slug upload
- Ping notifications with: slug size, errors, compile time

## Usage

First, you need Docker. Then you can either pull the image from the public index:

    docker pull lxfontes/slugbuilder

Or you can build from this source:

    git clone https://github.com/lxfontes/slugbuilder
    cd slugbuilder && make


The easiest way to get started, is to simply pipe your application and save capture the output using:

    git archive master | docker run -i -a stdin -a stdout lxfontes/slugbuilder > myslug.tgz

You can also pass parameters to slugbuilder as:

1. slug output path (default is "-" / stdout)
2. upload url (default is blank)
3. reporting url (default is blank)

### HTTP upload

Not binding to stdout as we don't need to save the slug locally:

    git archive master | docker run -i -a stdin -a stderr lxfontes/slugbuilder - http://fileserver/path/for/myslug.tgz

### Reporting example

Not binding to stdout as we don't need to save the slug locally:

    git archive master | docker run -i -a stdin -a stderr lxfontes/slugbuilder - http://fileserver/path/for/myslug.tgz http://reportserver/track

Saving slug locally and reporting:

    git archive master | docker run -i -a stdin -a stderr -a stdout lxfontes/slugbuilder - '' http://reportserver/track > myslug.tgz

## Caching

To speed up slug building, it's best to mount a volume specific to your app at `/tmp/cache`. For example, if you wanted to keep the cache for this app on your host at `/tmp/app-cache`, you'd mount a read-write volume by running docker with this added `-v /tmp/app-cache:/tmp/cache:rw` option:

    docker run -v /tmp/app-cache:/tmp/cache:rw -i -a stdin -a stdout lxfontes/slugbuilder

## Environment

Environment variables defined are parsed from 3 locations:

1. buildpack specific
2. `.env` file on git repo
3. `/tmp/cache/env` - which is usually mapped to a long-term storage on the docker host

These will be combined and appended to `.profile.d/99-extra.sh` and made available to application runtime.

## Buildpacks

As you can see, slugbuilder supports a number of official and third-party Heroku buildpacks. You can change the buildpacks.txt file and rebuild the container to create a version that supports more/less buildpacks than we do here. You can also bind mount your own directory of buildpacks if you'd like:

    docker run -v /my/buildpacks:/tmp/buildpacks:ro -i -a stdin -a stdout lxfontes/slugbuilder

## Base Environment

The Docker image here is based on [cedarish](https://github.com/progrium/cedarish), an image that emulates the Heroku Cedar stack environment. All buildpacks should have everything they need to run in this environment, but if something is missing it should be added upstream to cedarish.

## License

BSD
