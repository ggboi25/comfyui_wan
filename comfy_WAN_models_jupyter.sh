#!/bin/bash

# Create necessary directories if they don't exist
mkdir -p models/diffusion_models
mkdir -p models/text_encoders
mkdir -p models/VAE

# Download diffusion model
wget -O models/diffusion_models/Wan2_1-I2V-14B-480P_fp8_e4m3fn.safetensors \
    "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan2_1-I2V-14B-480P_fp8_e4m3fn.safetensors"

# Download text encoders
wget -O models/text_encoders/open-clip-xlm-roberta-large-vit-huge-14_visual_fp16.safetensors \
    "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/open-clip-xlm-roberta-large-vit-huge-14_visual_fp16.safetensors"

wget -O models/text_encoders/umt5-xxl-enc-fp8_e4m3fn.safetensors \
    "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/umt5-xxl-enc-fp8_e4m3fn.safetensors"

# Download VAE model
wget -O models/VAE/Wan2_1_VAE_fp32.safetensors \
    "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan2_1_VAE_fp32.safetensors"

echo "Model downloads complete!"
