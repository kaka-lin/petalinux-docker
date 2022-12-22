#!/bin/bash 

docker run -it --rm \
    --volume $PWD:/home/petalinux/project \
    -u petalinux \
    kakalin/petalinux:2020.2
