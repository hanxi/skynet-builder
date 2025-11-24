#!/bin/bash

docker run -v./skynet:/workspace skynet-builder bash -c "make cleanall && make mingw"
