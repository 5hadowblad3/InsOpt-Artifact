#!/bin/bash -e
# filepath: /data1/yifan/yf-docker/magma/magma-instrumentation-app/start.sh
#
# 本脚本用于构建并启动 Instrument 镜像，
# 镜像名称：magma/entropy/Instrument
# 共享目录映射：主机当前目录下的 ./magma-instrumentation-app 映射到容器内的 /magma_shared
#

# 定义 dockerfile 路径（假设当前目录即为 magma-instrumentation-app 目录）
DOCKERFILE="Dockerfile"

# 构建 docker 镜像，注意指定 build context 为上层目录（即 magma 工程根目录）
docker build -t magma/entropy/instrument -f ${DOCKERFILE} ..

echo "镜像构建完成，开始运行容器..."
# 运行容器，并挂载共享目录
docker run --rm -it \
    -v "$(pwd):/magma_shared" \
    magma/entropy/instrument