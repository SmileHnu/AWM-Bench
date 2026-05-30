#!/bin/bash

# 时间戳
TIMESTAMP=$(date +"%Y%m%d_%H:%M:%S")
TASK_NAME="Layer2_SubLayer1_Task1"
# 日志目录
LOG_DIR="/home/zhongrend/code/LSLM_Benchmark/Qwen2.5-Omni/yinlei/log/master"
mkdir -p "$LOG_DIR"

MASTER_LOG="$LOG_DIR/master_${TASK_NAME}_${TIMESTAMP}.log"
GPU0_LOG="$LOG_DIR/gpu0_${TASK_NAME}_${TIMESTAMP}.log"
GPU1_LOG="$LOG_DIR/gpu1_${TASK_NAME}_${TIMESTAMP}.log"

echo ">>> 启动时间: $(date)"
echo ">>> MASTER_LOG: $MASTER_LOG"
echo ">>> GPU0_LOG:   $GPU0_LOG"
echo ">>> GPU1_LOG:   $GPU1_LOG"

############################################
# ✅ GPU0监控
############################################
monitor_gpu0() {
    echo "timestamp,util,mem_used,mem_total,temp" > "$GPU0_LOG"
    while true; do
        nvidia-smi -i 0 \
        --query-gpu=timestamp,utilization.gpu,memory.used,memory.total,temperature.gpu \
        --format=csv,noheader,nounits >> "$GPU0_LOG"
        sleep 10
    done
}

############################################
# ✅ GPU1监控
############################################
monitor_gpu1() {
    echo "timestamp,util,mem_used,mem_total,temp" > "$GPU1_LOG"
    while true; do
        nvidia-smi -i 1 \
        --query-gpu=timestamp,utilization.gpu,memory.used,memory.total,temperature.gpu \
        --format=csv,noheader,nounits >> "$GPU1_LOG"
        sleep 10
    done
}

# 启动 GPU 监控
monitor_gpu0 &
GPU0_PID=$!

monitor_gpu1 &
GPU1_PID=$!

echo ">>> GPU0监控 PID: $GPU0_PID"
echo ">>> GPU1监控 PID: $GPU1_PID"

############################################
# ✅ 启动主任务（后台）
############################################
nohup bash run_all.sh > "$MASTER_LOG" 2>&1 &
MAIN_PID=$!

echo ">>> 主任务 PID: $MAIN_PID"

############################################
# ✅ 等待结束
############################################
wait $MAIN_PID

echo ">>> 主任务结束，关闭GPU监控"

kill $GPU0_PID 2>/dev/null
kill $GPU1_PID 2>/dev/null

echo ">>> 全部完成"