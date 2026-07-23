#!/bin/bash -e
# filepath: /data1/yifan/yf-docker/magma/tools/captain/Instrument_run.sh
#
# 本脚本针对所有 Targets 执行 fetch 和 build，然后调用 afl_entropy 插桩，
# 并最终统计数据。
#
# 预设环境变量:
#   FUZZER: afl_entropy fuzzer 路径，如 /magma/fuzzers/afl_entropy
#   MAGMA: Magma 工程在容器内的根路径，如 /magma
#   TARGETS_CONF: 存放所有 target 配置的目录或文件（这里假设将所有 targets 都复制到 /magma/targets 下）
#

echo "开始对所有 Targets 进行 fetch/build 操作..."

# 遍历 /magma/targets 目录下的每个 target
for TARGET in $(ls magma/targets); do
    export TARGET_PATH="magma/targets/${TARGET}"
    export TARGET=${TARGET}  # 将 target 名称导出，可供各脚本使用

    echo "========== Processing TARGET: ${TARGET} =========="
    if [ -x "${TARGET_PATH}/fetch.sh" ]; then
        echo "Fetching ${TARGET}..."
        "${TARGET_PATH}/fetch.sh"
    else
        echo "No fetch.sh for ${TARGET}, skipping fetch."
    fi

    if [ -x "${TARGET_PATH}/build.sh" ]; then
        echo "Building ${TARGET}..."
        "${TARGET_PATH}/build.sh"
    else
        echo "No build.sh for ${TARGET}, skipping build."
    fi
done

echo "所有 Targets 的 fetch/build 完成."
