#!/bin/bash

# 本地构建时使用国内镜像加速
docker build --build-arg USE_CHINA_MIRROR=true -t skynet-builder .
