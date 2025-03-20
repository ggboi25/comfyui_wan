#!/bin/bash

echo "🚀 Setting up ComfyUI inside /workspace..."

# Step 1: Clone ComfyUI if it doesn't exist
if [ ! -d "/workspace/ComfyUI" ]; then
    echo "📥 Cloning ComfyUI..."
    git clone https://github.com/comfyanonymous/ComfyUI.git /workspace/ComfyUI
else
    echo "✅ ComfyUI already exists. Skipping clone."
fi

cd /workspace/ComfyUI

# Step 3: Install dependencies in the background
echo "📦 Installing dependencies..."
pip install -r requirements.txt > /workspace/install_logs.txt 2>&1 &

# Step 2: Start ComfyUI immediately in the background
echo "🚀 Starting ComfyUI..."
python main.py --listen 0.0.0.0 &  # Runs in the background

# Step 4: Install custom nodes in the background
(
    echo "📦 Installing Custom Nodes..."
    cd custom_nodes
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git
    cd ComfyUI-Manager
    pip install -r requirements.txt
    cd ..
    git clone https://github.com/kijai/ComfyUI-WanVideoWrapper.git
    cd ComfyUI-WanVideoWrapper
    pip install -r requirements.txt
    echo "✅ Custom Nodes Installed."
) > /workspace/custom_nodes_log.txt 2>&1 &

echo "✅ ComfyUI is running! Installations are happening in the background."
echo "📜 Logs:"
echo "- Dependencies: /workspace/install_logs.txt"
echo "- Custom Nodes: /workspace/custom_nodes_log.txt"
echo "- Model Downloads: /workspace/models_log.txt"
