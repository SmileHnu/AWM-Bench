#!/bin/bash

# --- 1. 全局配置 ---
export GPU_ID="cuda:0"
export TASK_NAME="Layer1_SubLayer2_Task1"
export PROMPT_PATH="/home/zhongrend/code/LSLM_Benchmark/Qwen2.5-Omni/yinlei/tasks/$TASK_NAME/prompt"
export SYS_PROMPT_PATH="/home/zhongrend/code/LSLM_Benchmark/Qwen2.5-Omni/yinlei/tasks/$TASK_NAME/sys_prompt.txt"
export BASE_DIR="/home/zhongrend/code/LSLM_Benchmark/Qwen2.5-Omni/yinlei/tasks/infer_code"

echo ">>> 配置已载入:"
echo "GPU: $GPU_ID | Task: $TASK_NAME"

# 日志目录
LOG_DIR="/home/zhongrend/code/LSLM_Benchmark/Qwen2.5-Omni/yinlei/log/$TASK_NAME"
mkdir -p "$LOG_DIR"

# 模型列表
TASKS=(
    "audio_flamingo3.sh"
    "Audio-Reasoner.sh"
    "Baichuan-Audio.sh"
    "Baichuan-Omini-1.5.sh"
    "LLaMA-Omini-2-0.5B.sh"
    "LLaMA-Omini-2.sh"
    "LLaMA-Omini-3B.sh"
    "MiMo_Audio.sh"
    "MiMo_Audio_think.sh"
    "MiniCPM-o-2.6.sh"
    "Qwen2.5-Omini.sh"
    # "VITA-Aduio.sh"
    "Voxtral-Mini-3B-2507.sh"
)

# 串行执行
for script in "${TASKS[@]}"; do
    # 时间戳
    TIMESTAMP=$(date +"%Y-%m-%d_%H:%M:%S")
    model_name=$(basename "$script" .sh)
    LOG_FILE="$LOG_DIR/${model_name}_${TIMESTAMP}.log"

    echo ">>> 开始任务: $script"
    echo ">>> 日志: $LOG_FILE"

    # ✅ 串行执行 + 日志头信息
    {
        echo "===== START $(date '+%Y-%m-%d %H:%M:%S') ====="
        echo "MODEL: $model_name"
        echo "SCRIPT: $script"
        echo "GPU: $GPU_ID"
        echo "----------------------------------------"

        bash "$BASE_DIR/$script"

        echo "----------------------------------------"
        echo "===== END $(date '+%Y-%m-%d %H:%M:%S') ====="
    } > "$LOG_FILE" 2>&1

    echo ">>> 完成任务: $script"

done

echo ">>> 所有任务执行完成"