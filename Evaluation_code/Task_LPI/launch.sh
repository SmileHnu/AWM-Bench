#!/bin/bash

# 时间戳
TIMESTAMP=$(date +"%Y%m%d_%H:%M:%S")
TASK_NAME="Layer3_SubLayer1_Task3"

# 日志目录
LOG_DIR="/home/zhongrend/code/LSLM_Benchmark/Qwen2.5-Omni/yinlei/log/master"
mkdir -p "$LOG_DIR"

MASTER_LOG="$LOG_DIR/master_${TASK_NAME}_${TIMESTAMP}.log"

echo ">>> 启动时间: $(date)"
echo ">>> MASTER_LOG: $MASTER_LOG"

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

echo ">>> 主任务结束"
echo ">>> 全部完成"