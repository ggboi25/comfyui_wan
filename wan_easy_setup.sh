#!/bin/bash

# Set up environment
export DEBIAN_FRONTEND=noninteractive

# Update system and install required packages
apt update && apt install -y git wget

# Upgrade pip
pip install --upgrade pip

# STEP 1: Install ComfyUI
git clone https://github.com/comfyanonymous/ComfyUI.git
cd ComfyUI

# Install ComfyUI dependencies
pip install -r requirements.txt

# STEP 2: Install custom_nodes
cd custom_nodes

# Install ComfyUI-Manager
git clone https://github.com/ltdrdata/ComfyUI-Manager.git
cd ComfyUI-Manager
[ -f "requirements.txt" ] && pip install -r requirements.txt
cd ..

# Install ComfyUI-WanVideoWrapper
git clone https://github.com/kijai/ComfyUI-WanVideoWrapper.git
cd ComfyUI-WanVideoWrapper
[ -f "requirements.txt" ] && pip install -r requirements.txt
cd ..

# Return to ComfyUI directory
cd ..

# STEP 3: Download models
cd models

# Download diffusion model
cd diffusion_models
wget -q --show-progress -O Wan2_1-I2V-14B-480P_fp8_e4m3fn.safetensors \
    https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan2_1-I2V-14B-480P_fp8_e4m3fn.safetensors
cd ..

# Download text encoders
cd text_encoders
wget -q --show-progress -O open-clip-xlm-roberta-large-vit-huge-14_visual_fp16.safetensors \
    https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/open-clip-xlm-roberta-large-vit-huge-14_visual_fp16.safetensors

wget -q --show-progress -O umt5-xxl-enc-fp8_e4m3fn.safetensors \
    https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/umt5-xxl-enc-fp8_e4m3fn.safetensors
cd ..

# Download VAE model
cd VAE
wget -q --show-progress -O Wan2_1_VAE_fp32.safetensors \
    https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan2_1_VAE_fp32.safetensors
cd ..

# Download LoRA models from CivitAI
cd loras

# Set CivitAI API Key if needed (optional)
CIVITAI_API_KEY="YOUR_CIVITAI_API_KEY"

# Check if API key is provided and use it if available
if [ -n "$CIVITAI_API_KEY" ]; then
    wget --header="Authorization: Bearer $CIVITAI_API_KEY" -q --show-progress -O model_1549343.safetensors \
        "https://civitai.com/api/download/models/1549343?type=Model&format=SafeTensor"

    wget --header="Authorization: Bearer $CIVITAI_API_KEY" -q --show-progress -O model_1516873.safetensors \
        "https://civitai.com/api/download/models/1516873?type=Model&format=SafeTensor"

    wget --header="Authorization: Bearer $CIVITAI_API_KEY" -q --show-progress -O model_1475095.safetensors \
        "https://civitai.com/api/download/models/1475095?type=Model&format=SafeTensor"
else
    wget -q --show-progress -O model_1549343.safetensors \
        "https://civitai.com/api/download/models/1549343?type=Model&format=SafeTensor"

    wget -q --show-progress -O model_1516873.safetensors \
        "https://civitai.com/api/download/models/1516873?type=Model&format=SafeTensor"

    wget -q --show-progress -O model_1475095.safetensors \
        "https://civitai.com/api/download/models/1475095?type=Model&format=SafeTensor"
fi
cd ..

# Return to ComfyUI directory
cd ..

# STEP 4: Start ComfyUI
python main.py
