# Diffy Docker Container
[![Source Code](https://img.shields.io/badge/source-GitHub-blue.svg?style=flat)](https://github.com/zuazo/diffy-docker) [![Docker Repository on Quay.io](https://quay.io/repository/zuazo/diffy/status "Docker Repository on Quay.io")](https://quay.io/repository/zuazo/diffy) [![Build Status](http://img.shields.io/travis/zuazo/diffy-docker.svg?style=flat)](https://travis-ci.org/zuazo/diffy-docker)

A [Docker](https://www.docker.com/) image with [Diffy](https://github.com/twitter/diffy).

## Supported Tags and Respective `Dockerfile` Links

* `latest` ([*/Dockerfile*](https://github.com/zuazo/diffy-docker/tree/master/Dockerfile))

## What Is Diffy?

*Diffy finds potential bugs in your service using running instances of your new code and your old code side by side. Diffy behaves as a proxy and multicasts whatever requests it receives to each of the running instances. It then compares the responses, and reports any regressions that may surface from those comparisons. The premise for Diffy is that if two implementations of the service return “similar” responses for a sufficiently large and diverse set of requests, then the two implementations can be treated as equivalent and the newer implementation is regression-free.*

See [the official Diffy documentation](https://github.com/twitter/diffy/blob/master/README.md) and [the release blog post](https://blog.twitter.com/2015/diffy-testing-services-without-writing-tests) for more information.

## How to Use This Image

### Download the Image

    $ docker pull zuazo/diffy

### Running Diffy

For example:

    $ docker run -ti \
      -p 31900:31900 \
      -p 31149:31149 \
      zuazo/diffy \
        -candidate=http-candidate.herokuapp.com:9992 \
        -master.primary=http-primary.herokuapp.com:9990 \
        -master.secondary=http-secondary.herokuapp.com:9991 \
        -service.protocol=http \
        -serviceName="My Service" \
        -proxy.port=:31900 \
        -admin.port=:31159 \
        -http.port=:31149 \
        -rootUrl=localhost:31149

You need to replace the *Candidate*, the *Primary Master* and the *Secondary Master* values by your own API addresses.

You can now open [http://127.0.0.1:31149/](http://127.0.0.1:31149/) to see the web interface and use the `31900` port to make the API requests:

    $ curl localhost:31900/your_application_route

## Build from Sources

Instead of installing the image from Docker Hub, you can build the image from sources if you prefer:

    $ git clone https://github.com/zuazo/diffy-docker diffy
    $ cd diffy
    $ docker build -t zuazo/diffy .

# License and Author

|                      |                                          |
|:---------------------|:-----------------------------------------|
| **Author:**          | [Xabier de Zuazo](https://github.com/zuazo) (xabier@zuazo.org)
| **Copyright:**       | Copyright (c) 2015
| **License:**         | Apache License, Version 2.0

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
