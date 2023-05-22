#! /bin/bash

docker build -t connect .

docker run -it --rm -p 8083:8083 connect
