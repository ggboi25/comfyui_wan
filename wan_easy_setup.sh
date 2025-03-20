#!/bin/bash

# Define the installation directory (volume mount)
INSTALL_DIR="/workspace"  # Change to /data if necessary

# Ensure the install directory exists
mkdir -p $INSTALL_DIR
cd $INSTALL_DIR

# Install ComfyUI inside the volume
echo "Cloning ComfyUI into $INSTALL_DIR..."
git clone https://github.com/comfyanonymous/ComfyUI.git
cd ComfyUI
pip install -r requirements.txt

# Install custom nodes inside the volume
echo "Installing custom nodes..."
cd $INSTALL_DIR/ComfyUI/custom_nodes

# Install ComfyUI-Manager
git clone https://github.com/ltdrdata/ComfyUI-Manager.git
cd ComfyUI-Manager
pip install -r requirements.txt
cd ..

# Install ComfyUI-WanVideoWrapper
git clone https://github.com/kijai/ComfyUI-WanVideoWrapper.git
cd ComfyUI-WanVideoWrapper
pip install -r requirements.txt
cd ..

# Download and place models inside the correct folders
echo "Downloading models..."

mkdir -p $INSTALL_DIR/ComfyUI/models/diffusion_models
wget -O $INSTALL_DIR/ComfyUI/models/diffusion_models/Wan2_1-I2V-14B-480P_fp8_e4m3fn.safetensors \
    https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan2_1-I2V-14B-480P_fp8_e4m3fn.safetensors

mkdir -p $INSTALL_DIR/ComfyUI/models/text_encoders
wget -O $INSTALL_DIR/ComfyUI/models/text_encoders/open-clip-xlm-roberta-large-vit-huge-14_visual_fp16.safetensors \
    https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/open-clip-xlm-roberta-large-vit-huge-14_visual_fp16.safetensors

wget -O $INSTALL_DIR/ComfyUI/models/text_encoders/umt5-xxl-enc-fp8_e4m3fn.safetensors \
    https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/umt5-xxl-enc-fp8_e4m3fn.safetensors

mkdir -p $INSTALL_DIR/ComfyUI/models/VAE
wget -O $INSTALL_DIR/ComfyUI/models/VAE/Wan2_1_VAE_fp32.safetensors \
    https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan2_1_VAE_fp32.safetensors

# Download LoRAs from CivitAI (check if API is needed)
mkdir -p $INSTALL_DIR/ComfyUI/models/loras
wget -O $INSTALL_DIR/ComfyUI/models/loras/model_1549343.safetensors \
    "https://civitai.com/api/download/models/1549343?type=Model&format=SafeTensor"

wget -O $INSTALL_DIR/ComfyUI/models/loras/model_1516873.safetensors \
    "https://civitai.com/api/download/models/1516873?type=Model&format=SafeTensor"

wget -O $INSTALL_DIR/ComfyUI/models/loras/model_1475095.safetensors \
    "https://civitai.com/api/download/models/1475095?type=Model&format=SafeTensor"

# Navigate back to the ComfyUI directory
cd $INSTALL_DIR/ComfyUI

# Start ComfyUI with external access
echo "Starting ComfyUI..."
python main.py --listen 0.0.0.0
